
# 勤怠管理アプリの完成 (2013-08-24)

これまで開発してきたパーツをまとめて、勤怠管理アプリを完成させます。

画面構成等、気に入らない箇所があったので
仕様を再検討しました。

<br />
<br />
<br />


## 画面構成

以下のような画面構成とします。

- タイムカード画面
- 週間表示画面
- 勤怠修正画面
- 勤怠表出力画面
- 勤怠設定画面

サーバーとの通信に関する設定はiPhoneの設定画面に移します。

<br />
<br />
<br />

### タイムカード画面

出勤、退勤処理を行います。

<br />

#### 画面初期表示

1. 今日の日付を取得
2. CoreDataから今日の入力データを取得
3. 出勤時間設定済みの場合
  - 出勤ボタンをdisableに設定
4. 出勤時間未設定の場合
  - 出勤ボタンをenableに設定
5. 退勤時間設定済みの場合
  - 退勤ボタンをdisableに設定
6. 退勤時間未設定の場合
  - 退勤ボタンをenableに設定

<br />

#### 出勤ボタン tap

1. 現在時刻を取得
2. CoreDataに出勤時刻として現在時刻を入力
3. 出勤ボタンをdisableに設定
4. 退勤ボタンをenableに設定

<br />

#### 退勤ボタン tap

1. 現在時刻を取得
2. CoreDataに退勤時刻として現在時刻を入力
3. 退勤ボタンをdisableに設定

<br />

#### 日付横のボタン tap

1. 今日の日付を遷移先 (勤怠修正画面) にセット
2. 画面遷移

<br />
<br />
<br />

### 週間表示画面

一週間の勤怠を表示します。

- TableView

#### 初期表示

今日 : NSDate  
基準日 : 今日の日付を元に、今週の日曜日を指定  
section数 : 1  
row数 : 7

<br />

#### cellForRowAtIndexPath

※ Cellの更新処理を切り出す

- 基準日を元にして1週間のデータを表示する

- 日曜日は赤
- 土曜日は青
- 平日は黒
- 今日は緑

<br />

#### prevボタン

1. 基準日 - 7
2. TableView再読み込み

<br />

#### nextボタン

1. 基準日 + 7
2. TableView再読み込み

<br />

#### セル選択

1. 選択された日を取得
2. 遷移先のView (勤怠修正) に1.の日付をセット
3. 画面遷移


<br /><br /><br />

### 勤怠修正画面

指定された日付の勤怠を修正する

#### 初期表示


##### Static Cellのカスタムセルを作る手順

Static Cell を生成する際は dequeueReusableCellWithIdentifier: メソッドが
nilを返すため、実行時エラーになってしまう。

    *** Terminating app due to uncaught exception 'NSInternalInconsistencyException',
    reason:'UITableView dataSource must return a cell from tableView:cellForRowAtIndexPath:'

各TableViewCellのIBOutletを定義して、cellForRowAtIndexPath で indexPath に応じたCellを返すようにする

[Configuring Table Views](https://developer.apple.com/library/ios/releasenotes/Miscellaneous/RN-AdoptingStoryboards/index.html#//apple_ref/doc/uid/TP40011297-CH1-DontLinkElementID_5)

<br /><br /><br />

### 勤怠表出力画面

PDF形式でファイル出力する
- 年月を指定
- 1か月のデータが表示される


#### テーブルヘッダーのカスタマイズ



<br />

#### 初期表示

1. 基準年月を今日にする
2. CoreDataから基準年月を元にデータを取得する
3. TableViewにセットする

<br />

#### PDF出力

1. PDFファイルを作成する
2. `UIDocumentInteractionController` で作成したファイルを他アプリに連携


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
- パートナーID
- 氏名
- URL

