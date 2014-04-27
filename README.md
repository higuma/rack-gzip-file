# Rack::GzipFile, Rack::GzipStatic

English | [日本語](README.ja.md)

Rack::GzipFile is the identical as [Rack::File](http://rack.rubyforge.org/doc/Rack/File.html) with the following two extensions.

* Supports gzip pre-compressed file optimization (same function as Nginx gzip\_static module).  If a client support gzip-encoding, it searchs `.gz` file from the same directory first and returns a gzipped body.
* Furthermore, if `.gz` file exists and a client does not support gzip, it inflates `.gz` file and returns as a body (you do not have to keep an non-gzipped original file). 

Rack::GzipStatic is also identical to [Rack::Static](http://rack.rubyforge.org/doc/Rack/Static.html) with the extensions shown above.

## Install

```
gem install rack-gzip-file
```

## Usage

Upper-compatible to Rack::File and Rack::Static.

```
require 'rack/gzip_file'
run Rack::GzipFile.new('public')
```

```
require 'rack/gzip_static
use Rack::Static, :urls => {"/" => 'index.html'}, :root => 'public'
run lambda {|env|}
```

## License

MIT (See [LICENSE.txt](LICENSE.txt))

