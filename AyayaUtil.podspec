Pod::Spec.new do |s|
  s.name                      = 'AyayaUtil'
  s.version                   = '0.7'
  s.summary                   = 'AyayaUtil Framework'
  s.homepage                  = 'https://github.com/tang3680564/AyayaUtil'
  s.license                   = { :type => 'MIT', :file => 'LICENSE' }
  s.author                    = { 'tangjianqiang' => '494326253@qq.com' }
  s.source                    = { :git => 'https://github.com/tang3680564/AyayaUtil.git', :branch => 'master' }
  s.platform                  = :ios
  s.ios.deployment_target     = '9.0'
  s.swift_version             = '5.0'
  s.source_files = 'AyayaUtil/**/*.swift'

  
end 
