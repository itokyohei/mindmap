int penColor = 0;
PGraphics g;

boolean colorSelecting = false;

// finalは値を変更できない変数　つまり定数
final int PEN_W = 2;  //ペン太さ
final int ERS_W = 8;  //消しゴム太さ
final int COLOR_MAX = 100;

void setup() {
  //size(300, 300 + 20);
  size(300, 320);
  noCursor();  //カーソルを消す
  // カラーモードをHSBに変更し、範囲をCOLOR_MAX(100)にする
  colorMode(HSB, COLOR_MAX);

  // バックグラウンドウィンドウを作成する
  g = createGraphics(300, 300);
  g.beginDraw();

  g.colorMode(HSB, COLOR_MAX);
  g.background(0);

  g.endDraw();
}

void draw() {
  image(g, 0, 0);
  // 線の太さを指定　デフォルトで1らしい
  strokeWeight(1);
  //色選択バー
  for (int x = 0; x < 280; x++) {
    // strokeは線の輪郭の色を変える
    stroke(getMapppedColor(x));
    line(x, 300, x, 320);
  }
  //消しゴム部分
  // 線の輪郭の色をCOLOR_MAX(100)にする
  stroke(COLOR_MAX);
  // 図形内部を塗りつくす色を0(黒?)に設定する
  fill(0);
  // 四角形を描く
  rect(280, 300, 20 - 1, 20 - 1);

  stroke(0);

  if (penColor != 290) {
    fill(getMapppedColor(penColor));
    // 関数ellipseは楕円を描く関数　ellipse(中心座標x,中心座標y, 横直径, 縦直径)
    ellipse(penColor, 300 + 10, 5, 5);

    //十字
    strokeWeight(PEN_W + 1);
    stroke(0);
    line(mouseX - 5, mouseY, mouseX + 5, mouseY);
    line(mouseX, mouseY - 5, mouseX, mouseY + 5);
    strokeWeight(PEN_W);
    stroke(getMapppedColor(penColor));
    line(mouseX - 5, mouseY, mouseX + 5, mouseY);
    line(mouseX, mouseY - 5, mouseX, mouseY + 5);
  } else {
    fill(100);
    ellipse(penColor, 300 + 10, 5, 5);

    //バツ印
    strokeWeight(ERS_W/2);
    stroke(100);
    line(mouseX - 5/2., mouseY - 5/2., mouseX + 5/2., mouseY + 5/2.);
    line(mouseX - 5/2., mouseY + 5/2., mouseX + 5/2., mouseY - 5/2.);
  }
}

//色選択バーから色を取るときに使う
color getMapppedColor(int i) {
  // map(a, b, c, d, e)	aを範囲b-cから別の範囲d-eへ変換する
  // 例:map(2, 0, 10, 100, 200);	// 120を出力
  // color(R,G,B)だけど変更されているからcolor(H,S,B)
  return color(map(i, 0, 280, 0, COLOR_MAX), COLOR_MAX, COLOR_MAX);
}

//色選択モード
void colorSelect() {
  // constrain(a, min, max)	aをminとmaxの間に制限する
  penColor = constrain(mouseX, 0, 300);
  if (280 < penColor)
    penColor = 290;
}

//線描画モード
void drawLine() {
  g.beginDraw();
  if (penColor != 290) {
    g.stroke(getMapppedColor(penColor));
    g.strokeWeight(PEN_W);
  } else {
    g.stroke(0);
    g.strokeWeight(ERS_W);
  }
  g.line(pmouseX, pmouseY, mouseX, mouseY);
  g.endDraw();
}


void mousePressed() {
  if (mouseY > 300) {
    colorSelecting = true;
    colorSelect();
  } else if (!colorSelecting) {
    drawLine();
  }
}

void mouseDragged() {
  if (colorSelecting)
    colorSelect();
  else
    drawLine();
}

void mouseReleased() {
  colorSelecting = false;
}
