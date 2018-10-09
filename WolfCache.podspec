Pod::Spec.new do |s|
    s.name             = 'WolfCache'
    s.version          = '1.0.1'
    s.summary          = 'Framework for retrieving and caching frequently-used data, including in-memory, in-storage, and in-network layers.'

    s.homepage         = 'https://github.com/wolfmcnally/WolfCache'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/WolfCache.git', :tag => s.version.to_s }

    s.swift_version = '4.2'

    s.source_files = 'WolfCache/Classes/**/*'

    s.ios.deployment_target = '9.3'
    s.macos.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'

    s.module_name = 'WolfCache'

    s.dependency 'WolfLog'
    s.dependency 'ExtensibleEnumeratedName'
    s.dependency 'WolfImage'
    s.dependency 'WolfConcurrency'
    s.dependency 'WolfNetwork'
end
