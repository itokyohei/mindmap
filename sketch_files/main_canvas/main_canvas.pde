PGraphics canvas, pallet, tab01, tab02, tab03;
final float golden_ratio = 1.618;

int size_height = 1000; //仕方ない
int lv01_golden = round(size_height*(golden_ratio-1)); // 618
// int lv01_golden = round(height*(golden_ratio-1)); // 62
int lv02_golden = round(lv01_golden*(golden_ratio-1)); // 382
int lv03_golden = round(lv02_golden*(golden_ratio-1)); // 236

void setup(){
  size(1618, 1000);
  colorMode(HSB, 360, 100, 100);

  // println(lv01_golden);

  makeWindow();
  makeWindow_show();

}

void makeWindow(){
  canvas = createGraphics(height, height);
  pallet = createGraphics(lv02_golden, lv02_golden);
  tab01 = createGraphics(lv02_golden/2, lv01_golden);
  tab02 = createGraphics(lv02_golden/2, lv01_golden);
  tab03 = createGraphics(lv03_golden, height);

  makeWindow_setup(canvas, 0);
  makeWindow_setup(pallet, 100);
  makeWindow_setup(tab01, 150);
  makeWindow_setup(tab02, 200);
  makeWindow_setup(tab03, 250);
}

void makeWindow_setup(PGraphics aaa, int bbb){
  aaa.beginDraw();
  aaa.background(bbb, 100, 100);
  aaa.endDraw();
}

void makeWindow_show(){
  image(canvas, 0, 0);
  image(pallet, height, lv01_golden);
  image(tab01, height, 0);
  image(tab02, height+lv02_golden/2, 0);
  image(tab03, height+lv02_golden, 0);
}

void draw(){
if (mousePressed){
    strokeWeight(10);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
  image(pallet, height, lv01_golden);
}
