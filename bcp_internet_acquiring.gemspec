
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bcp_internet_acquiring/version"

Gem::Specification.new do |spec|
  spec.name          = "bcp_internet_acquiring"
  spec.version       = BcpInternetAcquiring::VERSION
  spec.authors       = ["Alexander Shvaykin"]
  spec.email         = ["skiline.alex@gmail.com"]

  spec.summary       = %q{Gem for BCP acquiring API.}
  spec.description   = %q{Gem for BCP acquiring API.}
  spec.homepage      = "https://github.com/AlexanderShvaykin"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency 'rest-client', '~> 2.0'
end
