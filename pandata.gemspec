require './lib/pandata'

Gem::Specification.new do |s|
  s.name                          = 'pandata'
  s.version                       = Pandata::Version::STRING
  s.required_ruby_version         = '>= 1.9.1'
  s.summary                       = 'A Pandora.com web scraper'
  s.description                   = 'A library and tool for downloading Pandora.com data (likes, bookmarks, stations, etc.)'
  s.homepage                      = 'https://github.com/ustasb/pandata'
  s.license                       = 'MIT'
  s.authors                       = ['Brian Ustas']
  s.email                         = 'brianustas@gmail.com'
  s.files                         = Dir.glob('lib/**/*.rb')
  s.extra_rdoc_files              = %w[LICENSE README.md]
  s.executables                   << 'pandata'
  s.add_runtime_dependency        'nokogiri', '~> 1.5.6'
  s.add_development_dependency    'rspec', '~> 2.12.2'
  s.add_development_dependency    'yard', '~> 0.8.5'
end
