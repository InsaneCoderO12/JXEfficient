Pod::Spec.new do |s|
  s.name = "JXKit"
  s.version = "0.1.34"
  s.summary = "A short description of JXKit."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"CoderSun"=>"codersun@126.com"}
  s.homepage = "https://github.com/augsun"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/JXKit.framework'
end
