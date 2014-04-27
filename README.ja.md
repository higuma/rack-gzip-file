# Rack::GzipFile, Rack::GzipStatic

[English](README.md) | 日本語

Rack::GzipFileは[Rack::File](http://rack.rubyforge.org/doc/Rack/File.html)と同機能で、次に示す2つの拡張機能を持ちます。

* gzipで事前圧縮されたファイルに対する最適化機能をサポートします(Nginxのgzip\_staticモジュールと同機能)。クライアントがgzip圧縮に対応している場合は`.gz`ファイルを先に検索してそれをそのままgzip圧縮されたbodyとして返します。
* さらに`.gz`ファイルがあり、クライアントがgzipに対応していない場合はファイルを解凍してbodyとして返します。これで元の非圧縮ファイルは不要となり、サーバリソースを削減できます。

Rack::GzipStaticも[Rack::Static](http://rack.rubyforge.org/doc/Rack/Static.html)と同じで、上記2点の機能拡張を加えたものです。

# インストール

```
gem install rack-gzip-file
```

# 使用法

Rack::File及びRack::Staticの上位互換で、機能は全く同じです。

```
require 'rack/gzip_file'
run Rack::GzipFile.new('public')
```

```
require 'rack/gzip_static
use Rack::GzipStatic, urls: [''], root: 'public', index: 'index.html'
run lambda {|env|}
```

## ライセンス

MIT (See [LICENSE.txt](LICENSE.txt))


