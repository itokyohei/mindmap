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
>processingの特徴  
オープンソースで開発されている。  
無料で使用可能  
ほかの言語よりも視覚的な表現が多く初心者でも触れられやすい  
Processing.jsを使用すれば端末問わずブラウザで動作可能  
Windows、Mac OS X、Linux上で動作するプログラミング言語  
実行結果を確認することがすごく容易  
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
<br>今まで生きてきた中でpcを使い何かを作ったり調べたりという機会が多く、何も意識すること無くIllustratorやphotoshopと言ったお絵かきアプリや、pc内に常備されている機能、webbrowserでの検索機能などを使用してきた。
<br>大学生になり、高校までにはなかったような内容の様々な情報系の授業やゼミでの授業を受けているうちに「もしも今までPC上で使っていた機能を自分で1から作成してみたらどれほど大変なのだろうか？」と思うようになり、研究してみようと意識し始めたのがこの卒業研究を作成するに到った経緯です。
<br>
