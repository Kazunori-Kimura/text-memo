---
layout: post
title: eclipseの設定とxdebug
date: 2013-06-26
category: PHP
tags: [php, eclipse, xdebug, mac]
---


eclipseのセットアップ for Mac
---

[eclipse](http://www.eclipse.org/) から
`Eclipse Classic 4.2.2`をダウンロードします。

ファイルを解凍し、`/Applications`配下に移動します。

    $ tar xzf eclipse-SDK-4.2.2-macosx-cocoa-x86_64.tar.gz
    $ mv eclipse /Applications/


workspaceのフォルダを確認するダイアログが表示されます。
適当な箇所を選択し、OKをクリックしてください。


<br>
<br>

### 起動時のエラー対応

私の環境では、初回起動時に以下のようなエラーが表示され
eclipseが起動しませんでした。

    $ /Applications/eclipse/eclipse -clean
    gogo: InterruptedException: sleep interrupted
    java.lang.InterruptedException: sleep interrupted
        at java.lang.Thread.sleep(Native Method)
        at org.apache.felix.gogo.shell.Activator.run(Activator.java:72)
        at java.lang.Thread.run(Thread.java:680)


また、logには以下の様な例外が表示されていました。

    !ENTRY org.eclipse.osgi 4 0 2013-06-25 21:30:48.291
    !MESSAGE An unexpected runtime error has occurred.
    !STACK 0
    javax.xml.parsers.FactoryConfigurationError: Provider org.apache.xerces.jaxp.SAXParserFactoryImpl not found

`org.apache.xerces.jaxp.SAXParserFactoryImpl`が見つからないようです。
`SAXParserFactoryImpl`は`xercesImpl.jar`に含まれているらしいですが
システム内を検索しても見つかりませんでした。

[xerces.apache.orgのアーカイブページ](http://archive.apache.org/dist/xerces/j/)
から`Xerces-J-bin.2.9.1.zip`をダウンロードして解凍し、`xercesImpl.jar`を
`/Library/Java/Home/lib/endorsed/`にコピーします。

`/Applications/eclipse/eclipse -clean`で起動します。

<br>
#### 参考

[SAXParserFactoryがエラーを吐いたときの対処法](http://stachibana.biz/?p=772)

[org.apache.xerces.jaxp.SAXParserFactoryImpl not found when importing Gears API in GWT](http://stackoverflow.com/questions/1016286/org-apache-xerces-jaxp-saxparserfactoryimpl-not-found-when-importing-gears-api-i)


<br>
<br>

---

サンプルアプリを開く
---

先ほど作成したサンプルアプリをeclipseで開きます。

<ol>
<li>PHPエクスプローラで右クリック</li>
<li>新規 > プロジェクト</li>
<li>PHPプロジェクト を選択して 次へ</li>
<li>
    <ul>
    <li>プロジェクト名: SampleApp</li>
    <li>既存ロケーションにプロジェクトを作成<br>
    先ほど作成したZendのプロジェクトを選択</li>
    </ul>
</li>
<li>完了をクリック</li>
</ol>

<br>
<br>

### ライブラリの設定

eclipseがZendFrameworkを認識できるように
インクルードパスを設定します。

- PHP インクルード・パス を右クリック
- インクルード・パス > インクルード・パスの構成 を選択
- ライブラリー > 外部ソース・フォルダーの追加 をクリック
- `/Users/<username>/zend/ZendFramework-2.2.1/library`を選択


<br>
---

<br>
XDebug設定
---

ブレークポイントで実行が止まるように、XDebugを設定します。

`/etc/php.ini`を開きます。
以下のようにxdebugの設定を追加します。


    zend_extension="/usr/lib/php/extensions/no-debug-non-zts-20090626/xdebug.so"
    :
    [xdebug]
    xdebug.idekey="macgdbp"
    xdebug.remote_enable=On
    xdebug.remote_handler = dbgp
    xdebug.remote_mode = req
    xdebug.remote_host = 127.0.0.1
    xdebug.remote_port = 9000
    xdebug.profiler_enable = 1
    xdebug.profiler_output_dir = /var/tmp/xdebug


トレースログの出力先となる`/var/tmp/xdebug`を作成します。

    $ sudo mkdir -p /var/tmp/xdebug
    $ sudo chmod 777 /var/tmp/xdebug


apacheを起動して、`http://sample.localhost`が
正しく表示されることを確認してください。

    $ sudo httpd -k start

<br>
<br>
---

<br>

eclipseデバッグ設定
---

### ブラウザ設定

既定でeclipseの内蔵ブラウザで開こうとするため、
外部ブラウザを使用するように構成を変更します。

- ウィンドウ > 設定
- 一般 > Webブラウザー
- 外部Webブラウザーを使用

<br>
<br>

### 実行構成

- 実行 > 実行構成
- PHP Web アプリケーション を選択して"新規の起動構成"を選択
- 名前を xampp に変更
- PHPサーバーの"新規"をクリック
  - 名前: `apache-zend`
  - ベースURL: http://sample.localhost
  - Local Web Root: /Users/<username>/zend/sample_app/public
- ファイル: /SampleApp/public/index.php
- URL:
  - "自動生成"のチェックを外す
  - `http://sample.localhost/`となるように変更
- 適用をクリック

<br>
<br>

### ブレークポイントの設定

- public/index.phpを開く
- 適当な箇所にブレークポイントを設定

<br>
<br>

### デバッグ実行

- 虫のアイコンの横にある▼をクリック
- `apache-zend`をクリック
- 初期設定ではindex.phpの先頭で一時停止するはず

<br>
<br>

---

<br>

以上で eclipse、XDebug の設定は完了です。




