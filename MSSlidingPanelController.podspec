Pod::Spec.new do |spec|
  spec.name						       = "MSSlidingPanelController"
  spec.version      			   = "2.0.0"

  spec.platform					     = :ios
  spec.ios.deployment_target = "8.0"
  spec.requires_arc				   = true
  spec.ios.framework			   = "UIKit"

  spec.source       			   = { :git => "https://github.com/SebastienMichoy/MSSlidingPanelController.git", :tag => "2.0.0" }
  spec.source_files 			   = 'MSSlidingPanelController/*.swift'
  spec.summary      			   = "Integrate easily a sliding panel controller mechanism in your project!"
  spec.homepage     			   = "https://github.com/SebastienMichoy/MSSlidingPanelController"
  spec.author       			   = { "Sébastien MICHOY" => "sebastienmichoy@gmail.com" }
  spec.license      			   = { :type => "BSD", :file => "LICENSE" }
  spec.screenshots  			   = "https://raw.githubusercontent.com/SebastienMichoy/MSSlidingPanelController/assets/MSSlidingPanelController.png"
end
