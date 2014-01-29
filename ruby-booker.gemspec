Gem::Specification.new do |s|
  s.name        = 'ruby-booker'
  s.version     = '0.0.0'
  s.date        = '2014-01-29'
  s.summary     = "Interact with booker api"
  s.description = "Interact with booker api in rails"
  s.authors     = ["Jake Craige"]
  s.email       = 'jake@poeticsystems.com'
  s.files       = ["lib/ruby-booker.rb", "LICENSE", "lib/booker.rb"]
  s.require_paths = ["lib"]
  #s.homepage    =
    #'http://rubygems.org/gems/ruby-booker'
  s.license       = 'MIT'
  s.add_dependency "httparty", [">= 0.5.0"]
end