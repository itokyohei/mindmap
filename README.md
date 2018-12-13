>mindmap
>進め方
1. Sketch(メイン？)やIllustratorでマインドマップを書きsvgファイルとして保存
1. 文書化
1. 座標等の整地
1. javascriptの導入、図を動かせるようにする
---
processingのインストール、何か書いてみる  

>processingのとは  
画像処理、アニメーション、音楽のようなデザイン面にすぐれたプログラミング言語

void setup() {  
  size(640, 360);  
  background(102);  
}  
void draw() {  
  stroke(255);  
  if (mousePressed==true){  
    line(mouseX, mouseY, pmouseX, pmouseY);  
  }  
}  
---
>研究背景
今まで生きてきた中でpcを使い何かを作ったり調べたりという機会が多く、何も意識すること無くIllustratorやPhotoshopと言ったお絵かきアプリや、pc内に常備されている機能、web browserでの検索機能などを使用してきた。  
大学生になり、高校までにはなかったような内容の様々な情報系授業やゼミでの授業を受けて簡単な仕組みのプログラムを書き、形になったのをきっかけに「言っている意味も分からないし自分には書けないであろう」という考えから「もしも今までPC上で使っていた機能を自分で1から作成してみたらどれほど大変なのだろうか？どのような過程に意識しつつ作成をしていかなければならないのか？」と思うようになり、研究・製作してみようと意識し始めたのがこの卒業研究を作成するに到った経緯である。  
だが「作ってみよう！」と思ったものの、プログラムを書いていく上での前知識があるわけでもなく素人でありかつ簡単なものしか作ったことのなかった自分は、なにをすることからスタートすればいいのか分からなかったので教授に相談してみたところ「processingを使ってみると良い」とアドバイスをいただいた。調べてみると、このprocessingは他とは違い自分でプログラムを書いてすぐに結果がどのようになっているのかを見ることが出来、初心者にも優しい作りになっていた。  
なので、このprocessingを用いて当初の目的であったアプリや機能の作成を自分のような初心者にもわかるような説明書を書いていこうという方向性の元、卒業論文を書いていこうと思う。  

---
>processingのインストール方法  
1…processingの公式サイトである「https://processing.org/」  
  にとび、画面の上部にある「Download Processing」をクリック  
2…自分のpcのosに合ったものを選択し、ダウンロード  
3…ダウンロードが終了したら、ダウンロードした圧縮ファイル解凍する。解凍しフォルダーを開けるようになったら、その中にあるアプリケーションファイルである「processing」を選択し「すべて展開」を選択する。  
4…さっき触っていたアプリケーションファイルの「processing」のアイコンが変化し、クリックすることにより起動が可能になる。  
---
>保存方法  



---
>processingの特徴  
オープンソースで開発されている。  
無料で使用可能  
ほかの言語よりも視覚的な表現が多く初心者でも触れられやすい  
Processing.jsを使用すれば端末問わずブラウザで動作可能  
Windows、Mac OS X、Linux上で動作するプログラミング言語  
実行結果を確認することがすごく容易  
javaをベースにした手軽なプログラミング環境  
エディターが内蔵され、すぐに作り始められる  
作ったソースコードはクリック一つですぐに動作する  
作品をweb用に出力し、手軽に公開できる  
マウスだけでなく、マイク、カメラ、ペン等様々な入力機械を使用可能  
---
>processingの歴史  
元はDesign By Numberと呼ばれるものであり、アーティストやデザイナー向けにプログラミングによるデザインの考え方を伝える教材として作られた。  
しかしDesign By Numberは描画する範囲は一辺が100ピクセルの正方形だけであり、色は白黒で100段階の濃度でしか調節の効かないものだった。  
プログラミングの概念を大きく掴むためには環境が良いが、その分表現できる範囲は限られており作品の作成や仕事等で使うには機能不足であった。  
そこでようやく登場したのが今回の卒論でも用いたprocessingである。  
当時MITのメディアラボに所属していたCasey ReasとBenFryにより、processingが開発された。  
processingはDesign By Numberとは違い、フルカラー・100ピクセルよりも大きなスクリーンサイズを指定可能・3次元グラフィックスなど様々な追加機能が実装された。  
初期のprocessingは、MITの研究者や授業を受けていた人たちだけで使われており、そこのコミュニティー間で機能追加やバグの修正がなされていた。  
このような改良を経て、2002年8月3日にα版が公開された。  
その後も改良は続き、β版の公開→1.0verをリリースした。  
また、processingはオープンソースのソフトウェアであるため、開発者が新しい機能を改良できなくても、他の使用しているものが開発・改良をしているため今でもさらなる広がりをみせている。  
(※オープンソース‥‥ソフトウェアの設計図に相当するソースコードを誰でも閲覧出来、そのソフトウェアの改良と再配布をライセンスの範囲内で行えるもののこと)  
引用…Built with Processing デザイン/アートのためのプログラミング入門　田中孝太郎・前川峻志  

---
>使用した関数一覧  
引用…https://processing.org/reference/  公式  

PGraphics…新たに画面を作成し、それを指定した場所に呼び出す関数  
例…  
PGraphics pg;  

void setup() {  
  size(100, 100);  
  pg = createGraphics(40, 40);  
}  

void draw() {  
  pg.beginDraw();  
  pg.background(100);  
  pg.stroke(255);  
  pg.line(20, 20, mouseX, mouseY);  
  pg.endDraw();  
  image(pg, 9, 30);   
  image(pg, 51, 30);  
}    
初期に作成した(100,100)の画面上ではなく、(40,40)のキャンバスを作成しそこに図を作成  
pg.beginDraw();～pg.endDraw();の中に、新しく作成をしたキャンバスで動かしたいものの指示を書き込み、imageで今作成したものを呼び出したい位置を指定  
---
>processing.jsを使い、作成したものをweb上で動かす方法  
---
12月19日(水)…表紙、目次、1ページ  
1月17日(木)…最終締め切り
















