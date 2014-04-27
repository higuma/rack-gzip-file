# Rack::GzipFile, Rack::GzipStatic

English | [日本語](README.ja.md)

Rack::GzipFile has the same function as [Rack::File](http://rack.rubyforge.org/doc/Rack/File.html) with the following two extensions.

* Supports gzip pre-compressed file optimization (like Nginx gzip\_static module).  If a client support gzip-encoding, it searchs `.gz` file first from the same directory and returns a gzipped body.
* Furthermore, if `.gz` file exists and a client does not support gzip, it inflates `.gz` file and returns as a body (non-gzipped original file is no longer needed). 

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
use Rack::GzipStatic, urls: [''], root: 'public', index: 'index.html'
run lambda {|env|}
```

## License

MIT (See [LICENSE.txt](LICENSE.txt))

