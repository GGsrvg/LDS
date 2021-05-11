Pod::Spec.new do |spec|
  spec.name         = "LDS"
  spec.version      = "1.1.5"
  spec.summary      = "LDS"
  spec.description  = <<-DESC
Easy Data Source
                       DESC

  spec.homepage     = "https://github.com/GGsrvg/LDS"
  
  spec.license      = { :type => "MIT", :file => 'LICENSE.txt' }

  spec.author             = "GGsrvg"

  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => "https://github.com/GGsrvg/LDS.git", :tag => spec.version }
  spec.source_files  = "LDS/**/*.{swift}"
  spec.swift_version = "5.0"
end
