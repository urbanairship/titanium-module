
Pod::Spec.new do |s|

    s.name         = "ti.airship"
    s.version      = "9.0.0"
    s.summary      = "The Airship Titanium module."
  
    s.description  = <<-DESC
                     The Airship Titanium module.
                     DESC
  
   s.homepage     = "https://airship.com"
    s.license      = { :type => "Apache 2", :file => "LICENSE" }
    s.author       = 'Airship'
  
    s.platform     = :ios
    s.ios.deployment_target = '11.0'
  
    s.source       = { :git => "https://github.com/urbanairship/titanium-module.git" }
    
    s.ios.dependency 'TitaniumKit'
  
    s.public_header_files = 'Classes/*.h'
    s.source_files = 'Classes/*.{h,m,swift}'
  end