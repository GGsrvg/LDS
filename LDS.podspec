Pod::Spec.new do |spec|
  spec.name         = "LDS"
  spec.version      = "0.2.2"
  spec.summary      = "LDS"
  spec.description  = <<-DESC
Easy Data Source
                       DESC

  spec.homepage     = "https://github.com/GGsrvg/LDS"
  
  spec.license      = { :type => "MIT", :file => 'LICENSE.txt' }

  spec.author             = "GGsrvg"

  spec.ios.deployment_target = "12.0"
  spec.source       = { :git => "https://github.com/GGsrvg/LDS.git", :tag => spec.version }
  spec.source_files  = "LDS/**/*.{swift}"
  spec.swift_version = "5.0"
end