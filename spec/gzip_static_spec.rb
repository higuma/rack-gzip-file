require 'rack/gzip_static'
require 'rack/mock'

describe Rack::GzipStatic do
  before do
    @root = 'spec/site'
    @server = Rack::MockRequest.new(
      Rack::GzipStatic.new lambda {|env|}, urls: [''], root: @root
    )
    @plain_content = "plain text\n"
    @gzip_inflated_content = "gzipped text\n"
  end

  describe '#call' do
    describe 'when gzip-precompressed file does not exist' do
      it 'should serve non-gzipped file if exist' do
        res = @server.get '/plain.txt'
        res.status.should be 200
        res.headers['Content-Encoding'].should be_nil
        res.body.should eql @plain_content
      end

      it 'should respond 304 if If-Modified-Since matches' do
        date = File.mtime("#{@root}/plain.txt").httpdate
        res = @server.get '/plain.txt', 'HTTP_IF_MODIFIED_SINCE' => date
        res.status.should be 304
        res.headers.empty?.should be_true
        res.body.empty?.should be_true
      end

      it 'should respond 404 if not exist' do
        @server.get('/not-exist.txt').status.should be 404
      end
    end

    describe 'when gzip-precompressed file exists' do
      it 'should respond 304 if If-Modified-Since matches' do
        date = File.mtime("#{@root}/gzipped.txt.gz").httpdate
        res = @server.get '/gzipped.txt', 'HTTP_IF_MODIFIED_SINCE' => date
        res.status.should be 304
        res.headers.empty?.should be_true
        res.body.empty?.should be_true
      end

      describe 'when request supports gzip encoding' do
        it 'should serve gzipped body' do
          res = @server.get '/gzipped.txt', 'HTTP_ACCEPT_ENCODING' => 'gzip'
          res.status.should be 200
          res.headers['Content-Encoding'].should eql 'gzip'
          Zlib::GzipReader.new StringIO.new(res.body) do |f|
            f.read.should eql @gzip_inflated_content
          end
        end
      end

      describe 'when request does not support gzip encoding' do
        it 'should inflate gzipped file and serve it as body' do
          res = @server.get '/gzipped.txt'
          res.status.should be 200
          res.headers['Content-Encoding'].should be_nil
          res.body.should eql @gzip_inflated_content
        end
      end
    end
  end
end
