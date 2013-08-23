---
layout: post
title: 勤怠管理アプリの完成
date: 2013-08-24
category: Objective-C
tags: [Objective-C, CoreText]
---

# 勤怠管理アプリの完成 (2013-08-24)

これまで開発してきたパーツをまとめて、勤怠管理アプリを完成させます。

画面構成等、気に入らない箇所があったので
仕様を再検討しました。


Github プロジェクトページ [TimeManager]()

<br />
<br />
<br />


## 画面構成

以下のような画面構成とします。

- タイムカード画面
- 勤怠修正画面
- 勤怠表画面
- 勤怠設定画面

サーバーとの通信に関する設定はiPhoneの設定画面に移します。

<br />
<br />
<br />

### タイムカード画面

出勤、退勤処理を行います。

<br />

#### 画面初期表示

![初期表示]()

大きな出勤ボタン、退勤ボタンを表示。

ボタン画像は有効時・無効時の2パターン作成、
CustomButtonに貼りつける。

buttonがdisableな時の画像の設定項目がStoryBoard上で
見当たらなかったので、`ViewDidLoad`で設定。

<br />

#### 出勤ボタン tap

1. 現在時刻を取得
2. CoreDataに出勤時刻として現在時刻を入力
3. 出勤ボタンをdisableに設定

<br />

#### 退勤ボタン tap

1. 現在時刻を取得
2. CoreDataに退勤時刻として現在時刻を入力
3. 退勤ボタンをdisableに設定

<br />

#### 日付横のボタン tap

1. 今日の日付を遷移先 (勤怠修正画面) にセット
2. 画面遷移



<br /><br /><br />

### 勤怠修正画面

指定された日付の勤怠を修正する

#### 初期表示

![勤怠修正画面]()


##### Static Cellのカスタムセルを作る手順

Static Cell を生成する際は dequeueReusableCellWithIdentifier: メソッドが
nilを返すため、実行時エラーになってしまう。

    *** Terminating app due to uncaught exception 'NSInternalInconsistencyException',
    reason:'UITableView dataSource must return a cell from tableView:cellForRowAtIndexPath:'

各TableViewCellのIBOutletを定義して、cellForRowAtIndexPath で indexPath に応じたCellを返すようにする

[Configuring Table Views](https://developer.apple.com/library/ios/releasenotes/Miscellaneous/RN-AdoptingStoryboards/index.html#//apple_ref/doc/uid/TP40011297-CH1-DontLinkElementID_5)

<br /><br /><br />

### 勤怠表画面

一か月分のデータを表示する

前後ボタンで月を変更

PDF形式でファイル出力する

<br />

#### 初期表示

![勤怠表画面]()

<br />

#### テーブルヘッダーのカスタマイズ

ViewをTableViewの上にぺロっと貼りつける

ボタン、ラベルを配置

<br />

#### PDF出力

PDFの作成は`CoreText`で行う

`CoreText.Framework`を追加

MCEAの月間報告書のフォーマットを使用

PDFを画像にして 692 x 712 のサイズに変換。
このサイズがデフォルトっぽいので。





1. PDFファイルを作成する
2. `UIDocumentInteractionController` で作成したファイルを他アプリに連携

`[image drawAtPoint:point];`





<br /><br /><br />


### データ形式

PDFファイルに必要な項目を列挙

#### Daily

月間報告書の1行

- 月日
- 曜日
- 出勤
- 退勤
- 昼休憩
- 昼以外の休憩
- 実作業時間
- 作業内容

#### Report

- 開始日
- 終了日

↑これいる？中身確認

#### Project

- 契約先会社名
- 作業場所名称
- 外線番号
- 内線番号
- 呼出方
- 責任者氏名

#### DefaultSettings

- サーバー通信ON/OFF
- 氏名
- パートナーID
- URL


<br /><br /><br />

# 設定をiOSの設定メニューで行う

サーバー通信云々は普通の人は関係ないので
アプリから追い出したい

1. 新規ファイル作成
2. Resource->Settings Bundle
3. Root.plistで定義

取り出す場合は

```
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
NSString *hoge = [userDefaults stringForKey: @"hoge"];
```





