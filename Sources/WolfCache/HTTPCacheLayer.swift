//
//  HTTPCacheLayer.swift
//  WolfCache
//
//  Created by Wolf McNally on 12/4/16.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
#if canImport(AppKit)
    import AppKit
#elseif canImport(UIKit)
    import UIKit
#endif

import ExtensibleEnumeratedName
import WolfLog
import WolfGraphics
import WolfNIO
import WolfCore
import WolfNetwork

#if !os(Linux)
    // Support the Serializable protocol used for caching
    extension OSImage: Serializable {
        public typealias ValueType = OSImage

        public func serialize() -> Data {
            return try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        }

        public static func deserialize(from data: Data) throws -> OSImage {
            if let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: OSImage.self, from: data) {
                return image
            } else {
                throw ValidationError(message: "Invalid image data.", violation: "imageFormat")
            }
        }
    }
#endif

extension ContentType {
    public static let image = ContentType("image")
}

public class HTTPCacheLayer: CacheLayer {
    public init() {
        logTrace("init", obj: self, group: .cache)
    }

    public func store(data: Data, for url: URL) {
        logTrace("storeData for: \(url)", obj: self, group: .cache)
        // Do nothing.
    }

    public func retrieveData(for url: URL) -> Future<Data> {
        logTrace("retrieveDataForURL: \(url)", obj: self, group: .cache)
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.setMethod(.get)

        let a = HTTPNIO.retrieveData(with: request)
        let b: Future<Data> = a.flatMapThrowing { arg in
            let (response, data) = arg

            var contentType: ContentType?
            if let contentTypeString = response.value(for: .contentType) {
                contentType = ContentType(rawValue: contentTypeString)
                guard contentType != nil else {
                    throw CacheError.unsupportedContentType(url, contentType!.rawValue)
                }
            }

            let encoding = response.value(for: .encoding)

            guard encoding == nil else {
                throw CacheError.unsupportedEncoding(url, encoding!)
            }

            if let contentType = contentType {
                switch contentType {
                case ContentType.jpg, ContentType.png, ContentType.gif, ContentType.image:
                    if let serializedImageData = OSImage(data: data)?.serialize() {
                        return serializedImageData
                    } else {
                        throw CacheError.badImageData(url)
                    }
                case ContentType.pdf, ContentType.svg:
                    return data
                default:
                    throw CacheError.unsupportedEncoding(url, contentType.rawValue)
                }
            } else {
                return data
            }
        }
        let c = b.flatMapErrorThrowing { error in
            if error.httpStatusCode == .notFound {
                throw CacheError.miss(url)
            } else {
                throw error
            }
        }
        return c
    }

    public func removeData(for url: URL) {
        logTrace("removeDataForURL: \(url)", obj: self, group: .cache)
        // Do nothing.
    }

    public func removeAll() {
        logTrace("removeAll", obj: self, group: .cache)
        // Do nothing.
    }
}
