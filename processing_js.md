<html>

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title>Built with Processing</title>
<script type="text/javascript" src="processing.js">
</script>

</head>

<body>
<div align="center">

<h1>Processing.js!</h1>
<canvas data-src="sketch_suketti.pde" width="200" height="200"></canvas>

</div>
</body>

</html>
---

void setup() {
  size(640, 360);
  background(102);
}

void draw() {
  stroke(255);
  if (mousePressed == true) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

int count =1;
void keyPressed(){
  if(key =='p' ||key =='P'){
    String path =System.getProperty("user.home")+"/Desktop/screenshot"+count+".jpg";
    save(path);
    count++;
    println("screen saved."+path);
  }
  else if(key =='t'){
    link("https://twitter.com/intent/tweet?text=");
  }
}
---
>Processing.jsとは  
　Webブラウザ上でProcessingのプログラムを解釈し、グラフィックを描画することの出来るJavaScriptで作られたProcessing互換ライブラリである。
 Processing.jsはグラフィックの描画にCanvasを導入しているという特徴がある。FirefoxやGoogle Chrome、Safari、OperaなどはこのCanvas要素の機能を持っているためWebブラウザで表示が可能である。しかしIEではこのCanvas要素が標準装備されていないため、IE用のCanvas互換ライブラリをしなければProcessing.jsのグラフィックを表示することが出来ないので注意が必要になる。  
---
>Processing.jsのダウンロード  
　Processing.jsは、拡張子が.pdeであるProcessingのような実行ファイルとは違い、HTMLに読み込む.jsであるJavaScriptファイルになっている。  
Processing.jsはProcessingの公式サイトのダウンロードページ(http://processingjs.org/download/)  からダウンロードすることが可能である。  
---  
>Processing.jsの使い方  
　Processing.jsでは、実際にWeb上で表示させたいHTMLファイルの中にProcessingのプログラムを書かずに、ファイルを読み込み実行することが可能である。  
上記のようにProcessingファイルをHTML内で読み込ませるためには、Processing.jsを読み込んだHTML内のcanvasタグにdata-srcという属性でファイルのパスを書く。そうすることでcanvasタグのdata-src属性の情報からプログラムファイルを読み込み実行し、Web上に作成したProcessingのファイルを表示することが出来る。    
---  
>画面詳細  
<ファイル>  
・新規( Ctrl + N )…現在の日付をもとに"sketch_#######"という名前のファイルを作成する。  
・開く( Ctrl + O )…自分のPC内から.pdeのファイルを選択しProcessingでコードを読み込む。
・最近開いたファイル…直近で開いたファイル名が表示され選択することでコードを読み込む。  
・スケッチブック( Ctrl + Shift + K )…ローカルコンピュータまたはネットワーク、スケッチブックのどこからでもスケッチを開くことが出来る。  
・サンプル( Ctrl + Shift + O )…すでに１つの形として出来上がっている実行済みコードを読み込むことが出来る。  
・閉じる( Ctrl + W )…現在のウィンドウを閉じる。  
・保存( Ctrl + Shift + S )…現在のウィンドウで作られているものを上書き保存する。  
・名前を付けて保存( Ctrl + Shift + S )…新規に名前を付け、指定した場所に保存する。  
・アプリケーションとしてエクスポート( Ctrl + Shift + E )…プログラムしたものを.pdeではなく.exeとして保存する。ProcessingがインストールされていないPCでも実行が可能となる。  
・ページ設定( Ctrl + Shift + P )…印刷するうえでのサイズ等を変更できる。  
・印刷( Ctrl + P )…印刷の実行。
・設定( Ctrl + . )…処理の仕組みを変更できる。  
・終了( Ctrl + Q )…すべてのウィンドウを閉じる。  
  
<編集>  
・元に戻す( Ctrl + Z )…最後に入力したコマンドまたは最後に入力したエントリを元に戻す。  
・やり直し( Ctrl + Y )…
・切り取り( Ctrl + X )…
・コピー( Ctrl + C )…
・Htmlとしてコピー( Ctrl + V )…
・貼り付け( Ctrl + V )…
・すべて選択( Ctrl + A )…
・自動フォーマット( Ctrl + T )…プログラムのインデントを整形する。  
・コメント/アンコメント( Ctrl + / )…
・→インデントを増やす( Ctrl + [ )…
・←インデントを減らす( Ctrl + ] )…
・検索( Ctrl + F )…
・次を探す( ctrl + G )…









---  
>命令入力  









