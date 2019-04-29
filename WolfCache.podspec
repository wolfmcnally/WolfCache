Pod::Spec.new do |s|
    s.name             = 'WolfCache'
    s.version          = '3.0.4'
    s.summary          = 'Framework for retrieving and caching frequently-used data, including in-memory, in-storage, and in-network layers.'

    s.homepage         = 'https://github.com/wolfmcnally/WolfCache'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/WolfCache.git', :tag => s.version.to_s }

    s.swift_version = '5.0'

    s.source_files = 'Sources/WolfCache/**/*'

    s.ios.deployment_target = '12.0'
    s.macos.deployment_target = '10.14'
    s.tvos.deployment_target = '12.0'

    s.module_name = 'WolfCache'

    s.dependency 'WolfLog'
    s.dependency 'WolfCore'
    s.dependency 'WolfGraphics'
    s.dependency 'WolfNetwork'
    s.dependency 'WolfNIO'
end
