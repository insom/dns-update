Gem::Specification.new do |spec|
  spec.name          = 'dns-update'
  spec.version       = '0.0.1'
  spec.authors       = ['Aaron Brady']
  spec.email         = ['aaron@insom.me.uk']

  spec.summary       = 'Update BIND with your new IP'
  spec.description   = "Speaks nsupdate's protocol, queries jsonip.com"
  spec.homepage      = 'https://github.com/insom/dns-update'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.add_dependency 'dnsruby', '~> 1.59'

  spec.add_development_dependency 'bundler', '~> 1.12'
end
