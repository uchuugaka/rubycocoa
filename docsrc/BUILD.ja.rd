# -*-rd-*-
= RubyCocoaをソースから構築・インストールする

この文書ではRubyCocoa 0.4をソースから構築・インストールする方法について
説明します。バイナリ配付をインストールして使う場合にはとくに読む必要はありません。

構築・インストール作業は、Terminalアプリケーションなどからシェルコマンド
を入力して行います。シェルコマンド入力例にはbashを想定して記述しています。
その他のシェル(例えばtcsh)を使っている場合、適当に読み変えてください。


== 構築・インストールの手順

構築・インストールは、おおよそ以下のような手順で行います。

  * ((<Rubyの構築・インストール>))
  * ((<RubyCocoaの構築>))
  * ((<RubyCocoaの単体テスト>))
  * ((<RubyCocoaのインストール>))

あらかじめどこかにRubyCocoaのソースを展開しておいてください。

  $ cd {どこか}
  $ tar zxf rubycocoa-0.4.0.tar.gz

((*注意*)) StuffItを使うとファイル名の長さの問題でRubyCocoaが正しく
インストールされないのでtarコマンドを使ってください。


== Rubyの構築・インストール

RubyCocoaを構築するためには、最低限librubyとRubyに付随するC言語の
ヘッダーファイルが必要となります。ここでは次に示す場合を例に、
RubyCocoaのベースとなるRubyの構築手順を説明します。

  * ソースからインストールしたRuby 1.8
  * Mac OS X 10.2付属のRuby 1.6.7

RubyCocoa 0.4バイナリパッケージは、後者の方法で作られたものです。
((<Fink|URL:http://fink.sf.net/>))などのパッケージを使ってRubyを
インストールしている場合などは、それに合わせて読み変えてください。


=== ソースからインストールしたRuby 1.8

Ruby 1.8のソースディレクトリに移動して、以下のように構築・インストール
します。オプションは必要に応じて変更してください。
((- CFLAGSに'-fno-common'オプションを指定しないと、RubyCocoa.framework
がリンクできないようです -))

  $ CFLAGS='-g -O2 -fno-common' ./configure
  $ make
  $ make test
  $ sudo make install
  $ sudo ranlib /usr/local/lib/libruby-static.a  # 




=== Mac OS X 10.2付属のRuby 1.6.7

==== インストールされているMac OS Xパッケージの確認

Mac OS X 10.2をインストールした時のオプション設定次第では、必要な
パッケージ(BSD.pkgとBSDSDK.pkg)がインストールされていない可能性があります。
まずはRubyがインストールされているか確認して、必要であればインストール
してください。

  $ ls -dF /Library/Receipts/BSD*.pkg   # 確認
  /Library/Receipts/BSD.pkg/   /Library/Receipts/BSDSDK.pkg/

Mac OS X 10.2にはRubyが含まれていますが、どういうわけかlibruby
が含まれていません。したがって、RubyCocoaを構築するためには、
Ruby 1.6.7のソースからlibrubyを作る必要があります。

==== Ruby 1.6.7のソースにパッチをあてる

まず最初にRuby 1.6.7のtarballを展開して、RubyCocoaに付属の
Ruby 1.6.7用パッチをあてます。

  $ cd {どこか}
  $ tar zxf ruby-1.6.7.tar.gz
  $ cd ruby-1.6.7
  $ patch -p1 < {RubyCocoaソース}/ruby-1.6.7-osx10.2.patch

==== librubyの構築・インストール

Mac OS X付属Rubyの環境に合わせてRuby 1.6.7を構築します。
((- CFLAGSに'-fno-common'オプションを指定しないと、RubyCocoa.framework
がリンクできないようです -))

  $ rbhost=`ruby -r rbconfig -e "print Config::CONFIG['host']"`
  $ CFLAGS='-g -O2 -fno-common' ./configure --prefix=/usr --host=$rbhost
  $ make
  $ make test

libruby.aのみをインストールします。

  $ ranlib libruby.a
  $ rubyarchdir=`ruby -r rbconfig -e 'print Config::CONFIG["archdir"]'`
  $ sudo install -m 0644 libruby.a $rubyarchdir


== RubyCocoaの構築

次のように入力してRubyCocoaを構築します。

  $ ruby install.rb --help   # オプションの確認
  $ ruby install.rb config
  $ ruby install.rb setup

((% ruby install.rb config %))にはいくつかRubyCocoa用のオプションがあります。
必要ならconfigフェーズのときにオプションを指定してください。


== RubyCocoaの単体テスト

  $ cd {ソース}/tests
  $ DYLD_FRAMEWORK_PATH={ソース}/framework/build ruby -I../lib testall.rb

単体テストにはTest::Unitが必要です。このプロセスは省略可能です。


== RubyCocoaのインストール

  $ sudo ruby install.rb install

以上でインストールは完了です。ここまでの手順で以下のものがインストール
されました。

: /Library/Frameworks/RubyCocoa.framework
  RubyCocoaフレームワーク (本体)

: /usr/lib/ruby/site_ruby/1.6/osx/ の中
  RubyCocoaライブラリ (stub) 
  - addressbook.rb, appkit.rb, cocoa.rb, foundation.rb

: /usr/lib/ruby/site_ruby/1.6/powerpc-darwin6.0/rubycocoa.bundle
  RubyCocoa拡張ライブラリ (stub)

: '/Developer/ProjectBuilder Extras/' の中
  ProjectBuilderのテンプレート
  * 'File Templates/Ruby'
  * 'Project Templates/Application/Cocoa-Ruby Document-based Application'
  * 'Project Templates/Application/Cocoa-Ruby Application'

: /Developer/Documentation/RubyCocoa
  ドキュメント (HTML)

: /Developer/Examples/RubyCocoa
  サンプルプログラム


((<「付属サンプルを試してみる」|URL:trysamples.ja.html>)) を参考に
動作確認してみてください。


== [FYI] バイナリパッケージングに便利なインストールオプション

RubyCocoaのバイナリパッケージを作るときに便利な'ruby install.rb
config'のオプションがあります。

  * --install-prefix : 
    拡張ライブラリとライブラリのインストール先に影響
  * --install-root :
    フレームワーク・テンプレート・ドキュメント・サンプルのインストール先に影響

=== 例

  $ ruby -r rbconfig -e 'p Config::CONFIG["prefix"]'
  "/usr"
  $ ruby install.rb config \
      --install-prefix=/tmp/build/usr --install-root=/tmp/build
  $ ruby install.rb setup
  $ sudo ruby install.rb install

結果として以下の場所に(疑似)インストールされます。

  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/addressbook.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/appkit.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/cocoa.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/foundation.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/powerpc-darwin6.0/rubycocoa.bundle
  /tmp/build/Library/Frameworks/RubyCocoa.framework
  /tmp/build/Developer/ProjectBuilder Extras/File Templates/Ruby
  /tmp/build/Developer/ProjectBuilder Extras/Project Templates/ \
          Application/Cocoa-Ruby Application
  /tmp/build/Developer/ProjectBuilder Extras/Project Templates/ \
          Application/Cocoa-Ruby Document-based Application
  /tmp/build/Developer/Examples/RubyCocoa
  /tmp/build/Developer/Documentation/RubyCocoa


== 開発動作確認環境

以下の環境で開発動作確認をしています。

* PowerMacintosh G4/400/384MB or iBook G3/600/384MB
* Mac OS X 10.2.3
* DevTools 10.2
* ruby-1.6.7 (pre-installed in Mac OS X 10.2)
* ruby-1.8 (preview 1 from cvs server)

== ではお楽しみください

感想、アイデア、提案、疑問、質問などなんでも気軽に教えてください。


$Date$
