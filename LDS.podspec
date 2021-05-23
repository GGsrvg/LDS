Pod::Spec.new do |spec|
  spec.name         = "LDS"
  spec.version      = "2.0.0"
  spec.summary      = "LDS"
  spec.description  = <<-DESC
Easy Data Source
                       DESC

  spec.homepage     = "https://github.com/GGsrvg/LDS"
  
  spec.license      = { :type => "MIT", :file => 'LICENSE.txt' }

  spec.author             = "GGsrvg"

  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => "https://github.com/GGsrvg/LDS.git", :tag => spec.version.to_s }
  spec.source_files  = "LDS/**/*.{swift}"
  spec.swift_version = "5.0"
end
