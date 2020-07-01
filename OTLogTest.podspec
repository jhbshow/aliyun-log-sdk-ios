 
Pod::Spec.new do |spec|
 
  spec.name         = "OTLogTest"
  spec.version      = "0.0.1"
  spec.summary      = "阿里云日志上传-测试版"
 
  spec.homepage     = "https://github.com/cuirhong/OTLog.git"
 

  spec.license      = { :type => "MIT", :file => "LICENSE" }
 

  spec.author             = { "cuirhong" => "cuirhong@126.com" }
 
  spec.source       = { :git => "https://github.com/jhbshow/aliyun-log-sdk-ios.git", :tag => "0.0.1" }
  spec.platform     = :ios,'9.0'
 
  #需要包含的源文件
  spec.source_files = 'OTLog/OTLog.framework/Headers/*.{h}'
  #你的SDK路径
  spec.vendored_frameworks = 'OTLog/OTLog.framework'
  #SDK头文件路径
  spec.public_header_files = 'OTLog/OTLog.framework/Headers/OTLog.h'
  spec.swift_versions = "4.0"
end
