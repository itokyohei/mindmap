## メインとなる動作を記述
  シフトとコントロールが押されているかの変数を定義
  データ型が自作クラスの変数を定義
  関数setup
    ファイルが実行されたときに一度だけ実行される
    ウィンドウの作成
    変数undoにインスタンスUndo(10)を代入
      Undo(levels)だからlevels=10
      つまりCircImgCollection(10)のインスタンスが生成される
      amountOfImages=amount=10
      つまり変数img(PImage型リスト型)に値数が10個と代入される
      CircImgCollectionの初期動作として10回繰り返して格納する
      実際どんな値かというと、ウィンドウの状態を10個保存しておく感じ
  関数draw
    マウスが押されているか確認
    押されていた場合、線を描く
  関数mouseReleased
    マウスが離れたとき、クラスUndoの中の関数takeSnapshotを実行する
      ウィンドウを進める変数は0になる　つまり進めることができない
      ウィンドウを戻る変数は1つずつ増えていく　最大amount-1回戻れる
  関数keyPressed
    キーが押されたとき、ShiftやCtrlか確認する
      押されているかの変数をtrueにする
    キーが同時押しの処理
      CtrlとShiftとZのとき
        undo(つまりクラスUndo)の関数redoを実行　進む処理
      CtrlとZのとき
        undo(つまりクラスUndo)の関数undoを実行　戻る処理
    キーが押されたとき、sだった場合
      ウィンドウを保存する処理
  関数keyReleased
    キーが押されなくなったときの処理
      押されているかの変数をfalseにする
## クラスUndoについて
  変数undoSteps=0, redoSteps=0;を定義
  データ型が自作クラス(CircImgCollection)の変数imagesを定義
  初期動作
    引数としてlevelsを必要とする
    変数imagesにCircImgCollectionのインスタンスを生成し代入
    CircImgCollectionインスタンスを生成するときの引数をlevelsを使う
  パブリック関数takeSnapshot
    変数undoStepsに小さい方の値を代入(undoSteps+1かamount-1か)
      書けば書くほどundoStepsは増えていくがamount-1より大きくならない
      あるときから一定の値になる
    redoSteps=0を代入　進む変数を0に設定し直す
    images(つまりクラスCircImgCollection)の関数nextを実行
      一時保存する番地を1つ進める
    images(つまりクラスCircImgCollection)の関数captureを実行
      現在のウィンドウ状態を格納する
  パブリック関数undo
    undoStepsが0より大きいとき実行する(1度でも書いてあるとき)　ウィンドウ状態を1つ戻す
      undoStepsを1ずつ減らす　つまり戻る変数を1つ減らす
      redoStepsを1ずつ増やす　つまり進む変数を1つ増やす
      images(つまりクラスCircImgCollection)の関数prevを実行
        一時保存する番地を1つ戻す
      images(つまりクラスCircImgCollection)の関数showを実行
        PImageのリストから特定の状態を取り出して上書き
  パブリック関数redo
    redoStepsが0より大きいとき実行する(1度でも戻ったことがあるとき)　ウィンドウ状態を1つ進める
      undoStepsは1ずつ増やす　つまり戻る変数を1つ増やす(1手書いたことになる)
      redoStepsを1ずつ減らす　つまり進む変数を1つ減らす(減らせる回数を1つ使ったから)
      images(つまりクラスCircImgCollection)の関数nextを実行
        一時保存する番地を1つ進める
      images(つまりクラスCircImgCollection)の関数showを実行
        PImageのリストから特定の状態を取り出して上書き
## クラスCircImgCollectionについて
  変数amount, currentを定義
  データ型PImageリストの変数imgを定義
  初期動作
    引数としてamountOfImages
    その引数をamountに代入
    変数imgにPImage[amount]のリストを代入
    amountの回数だけ繰り返す
      リストの最初から値を代入する。
      代入する値はウィンドウの現在の状態(同じ状態が10個できるのでは?)
  関数next
    一時保存する番地を1つ進める
  関数prev
    一時保存する番地を1つ戻す
  関数capture
    変数img(PImageのリスト)の変数current番に現在のウィンドウ状態を格納する
  関数show
    変数img(PImageのリスト)の変数current番を呼び出してウィンドウを上書きする?
## 疑問点


## 解決
  変数を定義するだけではnullなのにcurrentはいつから使い始めている?
    java boolean null 判定 - intがnullでも空でもないかどうかをチェックする方法は？
    https://code.i-harness.com/ja/q/3a4c3a
  keyCodeについて
    http://mslabo.sakura.ne.jp/WordPress/make/%EF%BC%88%E6%94%B9%E5%AE%9A%E7%89%88%EF%BC%89processing%E3%81%A7%E5%A7%8B%E3%82%81%E3%82%8B%E3%82%B2%E3%83%BC%E3%83%A0%E4%BD%9C%E3%82%8A%E3%81%A8%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF/28%EF%BC%9A%E3%82%AD%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%89%E3%81%AE%E5%85%A5%E5%8A%9B%E3%82%92%E5%87%A6%E7%90%86%E3%81%99%E3%82%8B/
  Undo undo;とは?
    型としてUndoで変数名としてundoとしている?
    データ型にクラスを指定できるのか?
    わざわざ変数を定義しなくてもインスタンスを生成すればいいのでは?
    変数を定義する必要のある言語では、自作クラスのインスタンスを生成するときに代入する変数は自作クラスの型と定義しないといけない
  undoSteps変数やredoSteps変数はどんな意味をもっているのか
    undoStepsは戻るための変数　redoStepsは進むための変数
    つまりundoは戻る処理　redoは進む処理

## よく使うサイト
  Processingクイックリファレンス
  http://www.musashinodenpa.com/p5/index.php
  processingの公式リファレンス
  https://processing.org/reference/
