Pod::Spec.new do |s|
  s.name             = 'SCWebPreview'
  s.version          = '1.0.0'
  s.summary          = 'Preview content in Website:)'

  s.description      = 'Preview content in Website'

  s.homepage         = 'https://github.com/myoungsc/SCWebPreview'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'myoungsc' => 'myoungsc.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/myoungsc/SCWebPreview.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'SCWebPreview/Classes/**/*'

end
