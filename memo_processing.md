## 参考になりそうなサイト
  [Processing] 残像表現との共存
  https://qiita.com/tscp/items/9fe4b03a099d046d18f4
  PGraphicsを使って文字が地面に映っているようなエフェクトを作る
  http://blog.p5info.com/?p=217
  a-08 変換する（移動, 回転, 拡大縮小）
  http://www.d-improvement.jp/learning/processing/2011-a/08.html
  基本図形(扇型や任意の四角形が書ける関数が紹介されている)
  http://www-im.dwc.doshisha.ac.jp/~ariga/processingweb/PFuncDraw.html

## 疑問点
  枠なしの部分の色はどーなるか
  1度多く書けばいいのか

## 解決
  sizeをsetupで入れる前のheightは1000が入っているっぽい
  試しにsizeを書かなかったら100*100のウィンドウが作成された
  変数を最初に定義しているところの前でint height = 1000;を宣言したら正常だった
  本来クラスにしてどーのこーのするところを、先にsize_heightを作成して対処しよう
  むしろsetupの後のheightが全部正常に動くのが謎
