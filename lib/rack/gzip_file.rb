require 'zlib'
require 'rack/file'

module Rack
  # Rack::File with gzip pre-compressed files support and
  # extraction for a client whitch does not support gzip.
  class GzipFile
    PATH_INFO = 'PATH_INFO'
    DOT_GZ = '.gz'
    TEXT_PLAIN = 'text/plain'
    CONTENT_TYPE = 'Content-Type'
    HTTP_ACCEPT_ENCODING = 'HTTP_ACCEPT_ENCODING'
    GZIP = 'gzip'
    CONTENT_ENCODING = 'Content-Encoding'
    CONTENT_LENGTH = 'Content-Length'

    def initialize(*args)
      @file_server = Rack::File.new(*args)
      @default_mime = args[2] || TEXT_PLAIN
    end

    def call(env)
      path = env[PATH_INFO]
      env[PATH_INFO] = path + DOT_GZ
      status, headers, body = result = @file_server.call(env)
      case status
      when 200  # OK
        mime = Rack::Mime.mime_type(::File.extname(path), @default_mime)
        headers[CONTENT_TYPE] = mime if mime
        enc = env[HTTP_ACCEPT_ENCODING]
        if enc && enc.include?(GZIP)
          headers[CONTENT_ENCODING] = GZIP
        else
          # inflate body for a client which does not support gzip
          body = [Zlib::GzipReader.open(body.to_path) {|f| f.read }]
          headers[CONTENT_LENGTH] = body[0].bytesize.to_s
          headers.delete CONTENT_ENCODING
        end
        [status, headers, body]
      when 304  # not modified
        result
      else      # retry with the original path
        env[PATH_INFO] = path
        @file_server.call(env)
      end
    end
  end
end
