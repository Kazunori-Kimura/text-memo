---
layout: post
title: PHP講習会(2)
date: 2013-06-22
category: PHP
tags: [php, eclipse, xdebug]
---

eclipseのセットアップとデバッグ設定
===

eclipseのセットアップ
---

[MergeDoc Project](http://mergedoc.sourceforge.jp/) からPleiadesをダウンロードします。

    安定版は4.2みたいですが、4.3でも大差ないと思われます。

お使いのPCにJREがすでにインストールされているのであれば
Standard Editionで良いと思います。
Full EditionはXAMPPが含まれており、サイズが非常に大きいです。


ファイルを解凍し、`C:\pleiades\eclipse\eclipse.exe`となるように
配置してください。

配置後、eclipse.exeをダブルクリックします。

workspaceのフォルダを確認するダイアログが表示されます。
適当な箇所を選択し、OKをクリックしてください。


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
- `C:\xampp\ZendFramework-2.2.1\library`を選択


<br>
---

<br>
XDebug設定
---

ブレークポイントで実行が止まるように、XDebugを設定します。

`C:\xampp\php\php.ini`を開きます。
ファイルの最後にXDebugの設定があります。
コメントアウトされているので、先頭の ; を削除します。

    [XDebug]
    zend_extension = "\xampp\php\ext\php_xdebug.dll"
    xdebug.profiler_append = 0
    xdebug.profiler_enable = 1
    xdebug.profiler_enable_trigger = 0
    xdebug.profiler_output_dir = "\xampp\tmp"
    xdebug.profiler_output_name = "cachegrind.out.%t-%s"
    xdebug.remote_enable = on
    xdebug.remote_handler = "dbgp"
    xdebug.remote_host = "127.0.0.1"
    xdebug.trace_output_dir = "\xampp\tmp"



apacheを起動して、`http://sample.localhost`が
正しく表示されることを確認してください。

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
  - 名前: xampp
  - ベースURL: http://sample.localhost
  - Local Web Root: C:\xampp\sample_app\public
- ファイル: /SampleApp/public/index.php  
プロジェクト名とフォルダ名を一致させておくべきでした...
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
- xamppをクリック
- 初期設定ではindex.phpの先頭で一時停止するはず

<br>
<br>

---

<br>

以上で eclipse、XDebug の設定は完了です。




