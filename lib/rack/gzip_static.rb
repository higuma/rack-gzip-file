require 'rack/static'
require 'rack/gzip_file'

module Rack
  # Rack::Static with gzip pre-compressed files support.
  class GzipStatic < Static
    def initialize(app, options = {})
      super
      @file_server = Rack::GzipFile.new(options[:root] || Dir.pwd, @headers)
    end
  end
end
