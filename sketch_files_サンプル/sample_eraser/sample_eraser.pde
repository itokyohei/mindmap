int penColor = 0;
PGraphics g;

boolean colorSelecting = false;

final int PEN_W = 2;  //ペン太さ
final int ERS_W = 8;  //消しゴム太さ
final int COLOR_MAX = 100;

void setup() {
  size(300, 320);
  noCursor();  //カーソルを消す
  colorMode(HSB, COLOR_MAX);

  g = createGraphics(300, 300);
  g.beginDraw();

  g.colorMode(HSB, COLOR_MAX);
  g.background(0);

  g.endDraw();
}

void draw() {
  image(g, 0, 0);
  strokeWeight(1);
  //色選択バー
  for (int x = 0; x < 280; x++) {
    stroke(getMapppedColor(x));
    line(x, 300, x, 320);
  }
  //消しゴム部分
  stroke(COLOR_MAX);
  fill(0);
  rect(280, 300, 20 - 1, 20 - 1);

  stroke(0);

  if (penColor != 290) {
    fill(getMapppedColor(penColor));
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
  return color(map(i, 0, 280, 0, COLOR_MAX), COLOR_MAX, COLOR_MAX);
}

//色選択モード
void colorSelect() {
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
