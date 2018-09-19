//
//  MemoryCacheLayer.swift
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
import WolfLog
import WolfConcurrency

public class MemoryCacheLayer: CacheLayer {

    private let cache = NSCache<NSURL, NSData>()

    public init() {
        logTrace("init", obj: self, group: .cache)
    }

    public func store(data: Data, for url: URL) {
        logTrace("storeData for: \(url)", obj: self, group: .cache)
        cache.setObject(data as NSData, forKey: url as NSURL)
    }

    public func retrieveData(for url: URL) -> DataPromise {
        func perform(promise: DataPromise) {
            logTrace("retrieveDataForURL: \(url)", obj: self, group: .cache)
            let data = cache.object(forKey: url as NSURL) as NSData?
            if let data = data {
                promise.keep(data as Data)
            } else {
                promise.fail(CacheError.miss(url))
            }
        }

        return DataPromise(with: perform)
    }

    public func removeData(for url: URL) {
        logTrace("removeDataForURL: \(url)", obj: self, group: .cache)
        cache.removeObject(forKey: url as NSURL)
    }

    public func removeAll() {
        logTrace("removeAll", obj: self, group: .cache)
        cache.removeAllObjects()
    }
}
