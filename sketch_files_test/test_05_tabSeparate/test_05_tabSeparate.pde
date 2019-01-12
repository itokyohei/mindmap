PGraphics canvas, pallet, tab01, tab02, tab03;
final float golden_ratio = 1.618;
PGraphics[] tab01_separate, tab02_separate, tab03_separate;

int size_height = 1000; //仕方ない
int lv01_golden = round(size_height*(golden_ratio-1)); // 618
int lv02_golden = round(lv01_golden*(golden_ratio-1)); // 382
int lv03_golden = round(lv02_golden*(golden_ratio-1)); // 236

void setup(){
  size(1618, 1000);
  colorMode(HSB, 360, 100, 100);

  makeWindow();
  makeWindow_setup02();
  makeWindow_show();
  maketab00_separate(tab01, tab01_separate, height, 140);
  maketab00_separate(tab02, tab02_separate, height+lv02_golden/2, 210);
  maketab00_separate(tab03, tab03_separate, height+lv02_golden, 280);

}

void makeWindow(){
  canvas = createGraphics(height, height);
  pallet = createGraphics(lv02_golden, lv02_golden);
  tab01 = createGraphics(lv02_golden/2, lv01_golden);
  tab02 = createGraphics(lv02_golden/2, lv01_golden);
  tab03 = createGraphics(lv03_golden, height);
}

void makeWindow_setup01(PGraphics gg, color c){
  gg.beginDraw();
  gg.colorMode(HSB, 360, 100, 100);
  gg.background(c);
  gg.endDraw();
}

void makeWindow_setup02(){
  int a = 35, b = 90;
  makeWindow_setup01(canvas, color(0, a, b));
  makeWindow_setup01(pallet, color(70, a, b));
  makeWindow_setup01(tab01, color(140, a, b));
  makeWindow_setup01(tab02, color(210, a, b));
  makeWindow_setup01(tab03, color(280, a, b));
}

void makeWindow_show(){
  image(canvas, 0, 0);
  image(pallet, height, lv01_golden);
  image(tab01, height, 0);
  image(tab02, height+lv02_golden/2, 0);
  image(tab03, height+lv02_golden, 0);
}

void maketab00_separate(PGraphics jj, PGraphics[] tab00_separate, float start_x, int cc){
  int base_x = jj.width, base_y = jj.height;
  int separate_count = floor(base_y / base_x);
  tab00_separate = new PGraphics[separate_count];
  for (int i = 0; i < separate_count; i++){
    tab00_separate[i] = createGraphics(base_x, base_y / separate_count);
    makeWindow_setup01(tab00_separate[i], color(cc, 30+i*15, 60));
    image(tab00_separate[i], start_x, i * base_y / separate_count);
  }
}
