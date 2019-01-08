PGraphics canvas, pallet, tab01, tab02, tab03;
final float golden_ratio = 1.618;
final float circle_ratio = 0.75;
color selectColor = color(0, 0, 0);
PGraphics[] tab01_separate, tab02_separate, tab03_separate;

int size_height = 1000; //仕方ない
int lv01_golden = round(size_height*(golden_ratio-1)); // 618
// int lv01_golden = round(height*(golden_ratio-1)); // 62
int lv02_golden = round(lv01_golden*(golden_ratio-1)); // 382
int lv03_golden = round(lv02_golden*(golden_ratio-1)); // 236

void setup(){
  size(1618, 1000);
  colorMode(HSB, 360, 100, 100);

  // println(lv01_golden);
  // println(circle_ratio);

  makeWindow();
  makeWindow_setup01(canvas, color(0, 0, 100));
  makeColorpallet(pallet);

  tab01_separate = maketab00_separate(tab01, tab01_separate, height, 140);
  tab02_separate = maketab00_separate(tab02, tab02_separate, height+lv02_golden/2, 210);
  tab03_separate = maketab00_separate(tab03, tab03_separate, height+lv02_golden, 280);

  maketab00_separate_show01();

  makeWindow_show();
}

void makeWindow(){
  canvas = createGraphics(height, height);
  pallet = createGraphics(lv02_golden, lv02_golden);
  tab01 = createGraphics(lv02_golden/2, lv01_golden);
  tab02 = createGraphics(lv02_golden/2, lv01_golden);
  tab03 = createGraphics(lv03_golden, height);
}

void makeWindow_setup01(PGraphics ff, color base_color){
  ff.beginDraw();
  ff.colorMode(HSB, 360, 100, 100);
  ff.background(base_color);
  ff.endDraw();
}

void makeColorpallet(PGraphics gg){
  int squareOneSide = gg.height;
  float large_r = squareOneSide/2;
  float small_r = (large_r)*circle_ratio;

  gg.beginDraw();
  gg.colorMode(HSB, 360, 100, 100);
  gg.pushMatrix();
  gg.translate(large_r, large_r);

  makeColorpallet_draw01(gg, large_r, small_r);
  makeColorpallet_draw02(gg, small_r, 0);
  //gg.popMatrix();
  gg.endDraw();
}
void makeColorpallet_draw01(PGraphics gg, float r01, float r02){
  float on_rad = TWO_PI/360;
  gg.noStroke();
  gg.fill(200);
  gg.rect(-r01, -r01, r01*2, r01*2);
  gg.noStroke();
  for(int i = 0; i < 360; i++){
    gg.fill(i, 100, 100);
    gg.arc(0, 0, r01*2, r01*2, i*on_rad, (i+1)*on_rad);
  }
  gg.fill(0, 0, 100);
  gg.ellipse(0, 0, r02*2, r02*2);
}
void makeColorpallet_draw02(PGraphics gg, float r02, float color_hue){
  int separate = 50;
  float separate_squareOneSide = r02*(1/sqrt(2))*2/separate; // 1マスの辺
  float start_separate_coordinate = -r02*(1/sqrt(2)); // スタートの座標
  //gg.strokeWeight(100);
  //gg.rect(start_separate_coordinate, start_separate_coordinate, r02*(1/sqrt(2))*2, r02*(1/sqrt(2))*2);
  gg.noStroke();
  for(int i = 0; i < separate; i++){
    for(int j = 0; j < separate; j++){
      float change_saturation = 100*(i+1)/separate;
      float change_brightness = 100*(j+0)/separate;
      gg.fill(color_hue, abs(100-change_saturation), abs(100-change_brightness));
      gg.rect(start_separate_coordinate + separate_squareOneSide*i, start_separate_coordinate + separate_squareOneSide*j, separate_squareOneSide + 1, separate_squareOneSide + 1); // 縦書いて横に伸ばす
    }
  }
}

PGraphics[] maketab00_separate(PGraphics jj, PGraphics[] tab00_separate, float start_x, int cc){
  int base_x = jj.width, base_y = jj.height;
  int separate_count = floor(base_y / base_x);
  tab00_separate = new PGraphics[separate_count];
  for (int i = 0; i < separate_count; i++){
    tab00_separate[i] = createGraphics(base_x, base_y / separate_count);
    makeWindow_setup01(tab00_separate[i], color(cc, 30+i*15, 60));
  }
  return tab00_separate;
}

void makeWindow_show(){
  image(canvas, 0, 0);
  image(pallet, height, lv01_golden);
  //image(tab01, height, 0);
  //image(tab02, height+lv02_golden/2, 0);
  //image(tab03, height+lv02_golden, 0);
}

void maketab00_separate_show01(){
  maketab00_separate_show02(tab01, tab01_separate, height, 0);
  maketab00_separate_show02(tab02, tab02_separate, height+lv02_golden/2, 0);
  maketab00_separate_show02(tab03, tab03_separate, height+lv02_golden, 0);
}

void maketab00_separate_show02(PGraphics hh, PGraphics[] tab00_separate, int start_x, int start_y){
  int separate_count = floor(hh.height / hh.width);
  for (int i=0; i < separate_count; i++){
    image(tab00_separate[i], start_x, start_y + i*tab00_separate[i].height);
  }
}

void draw(){
  float gg_pallet_center_x = height + lv02_golden/2;
  float gg_pallet_center_y = lv01_golden + lv02_golden/2;
  float gg_pallet_squareOneSide = (1/sqrt(2))*circle_ratio*lv02_golden/2;

  if (mousePressed){
    float x = mouseX, y = mouseY;

    // カラーパレットの色相
    if (gg_pallet_center_x - gg_pallet_squareOneSide < x
    && x < gg_pallet_center_x + gg_pallet_squareOneSide
    && gg_pallet_center_y - gg_pallet_squareOneSide < y
    && y < gg_pallet_center_y + gg_pallet_squareOneSide){
      selectColor = get(round(x), round(y));
      // println("color", hue(selectColor), saturation(selectColor), brightness(selectColor));
    }

    // カラーパレットの彩度と明度
    if (circle_ratio*lv02_golden/2 < dist(x, y, gg_pallet_center_x, gg_pallet_center_y)
    && dist(x, y, gg_pallet_center_x, gg_pallet_center_y) < lv02_golden/2){
      selectColor = get(round(x), round(y));
      // println("color", hue(selectColor), saturation(selectColor), brightness(selectColor));

      pallet.beginDraw();
      pallet.translate(lv02_golden/2, lv02_golden/2);
      makeColorpallet_draw02(pallet, circle_ratio*lv02_golden/2, hue(selectColor));
      pallet.endDraw();
    }

    // キャンバスだけ書けるように条件付け
    if (x < height && y <height){
      strokeWeight(10);
      stroke(selectColor);
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
  }
  image(pallet, height, lv01_golden);
}
