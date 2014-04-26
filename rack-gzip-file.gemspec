Gem::Specification.new do |s|
  s.name        = 'rack-gzip-file'
  s.version     = '0.0.1'
  s.summary     = 'Rack::GzipFile, Rack::GzipStatic'
  s.description = <<EOF
Extends Rack::File and Rack::Static with gzip pre-compression optimization support. Also supports gzipped file extraction for clients which do not support gzip encoding.'
EOF

  s.authors = 'Yuji Miyane'
  s.email = 'myuj1964@gmail.com'
  s.test_files = Dir['spec/**/*']
  s.files = Dir['lib/**/*'] + s.test_files + Dir['*.md'] +
            ['Rakefile', 'LICENSE.txt']
  s.homepage = 'https://github.com/higuma/rack-gzip-file'
  s.license = 'MIT'
  s.add_runtime_dependency 'rack', '>= 1.5.0'
  s.add_development_dependency 'rspec'
end
