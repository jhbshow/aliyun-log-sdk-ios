 
Pod::Spec.new do |spec|
 
  spec.name         = "OTAliyunLog"
  spec.version      = "1.2.0"
  spec.summary      = "阿里云日志上传"
 
  spec.homepage     = 'https://github.com/jhbshow/aliyun-log-sdk-ios.git'
 

  spec.license      = { :type => "MIT", :file => "LICENSE" }
 

  spec.author             = { "cuirhong" => "cuirhong@126.com" }
 
  spec.source       = { :git => "https://github.com/jhbshow/aliyun-log-sdk-ios.git", :tag => spec.version.to_s }
  spec.platform     = :ios,'9.0'
 
  #需要包含的源文件
  spec.source_files = 'OTLog/**/*.{h,swift,c}'
  spec.swift_versions = "5.0"
  # 第三方开源框架(多个)
  spec.dependency 'FMDB'
  #spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
