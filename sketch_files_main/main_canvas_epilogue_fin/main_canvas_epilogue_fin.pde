PGraphics pallet, tab01, tab02, tab03;
final float golden_ratio = 1.618;
final float circle_ratio = 0.75;
color selectColor = color(0, 0, 0); //ウィンドウサイズが100と同じ
color eraserColor = color(255, 255, 255);

int size_height = 1000; //仕方ない
int lv01_golden = round(size_height*(golden_ratio-1)); // 618
int lv02_golden = round(lv01_golden*(golden_ratio-1)); // 382
int lv03_golden = round(lv02_golden*(golden_ratio-1)); // 236

float pen_size = 5; //5 20 50
float ers_size = 3; //3 10 50

boolean ers_change = false;

PImage[] stepImg;
int stepImgNumber = 15; //保存する画像数
int backCount = 0, forwardCount = 0; // 戻った回数進んだ回数
int stepImgCount; // 取り出す画像の指定
boolean changeCanvas = false;

boolean downCtrl = false, downShift = false, downA = false;

int dayY, dayM, dayD, timeH, timeM, timeS;
String dayString, timeString;

void setup(){
  size(1618, 1000);

  colorMode(HSB, 360, 100, 100);
  makeWindow();
  makeWindow_setup02(color(0, 0, 100));
  makeColorpallet(pallet);
  maketab01(tab01);
  maketab02(tab02);
  maketab03(tab03);

  makeWindow_show();

  stepImg = new PImage[stepImgNumber];
  make_stepImg_setup();
}
void makeWindow(){
  //canvas = createGraphics(height, height);
  pallet = createGraphics(lv02_golden, lv02_golden);
  tab01 = createGraphics(lv02_golden/2, lv01_golden);
  tab02 = createGraphics(lv02_golden/2, lv01_golden);
  tab03 = createGraphics(lv03_golden, height);
}
void makeWindow_setup02(color base_color){
  noStroke();
  fill(base_color);
  rect(0, 0, height, height);
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
  float separate_squareOneSide = r02*(1/sqrt(2))*2/separate;
  float start_separate_coordinate = -r02*(1/sqrt(2)); // スタートの座標

  gg.noStroke();
  for(int i = 0; i < separate; i++){
    for(int j = 0; j < separate; j++){
      float change_saturation = 100*(i+1)/separate;
      float change_brightness = 100*(j+0)/separate;
      gg.fill(color_hue, 100-change_saturation, 100-change_brightness);
      gg.rect(start_separate_coordinate + separate_squareOneSide*i, start_separate_coordinate + separate_squareOneSide*j, separate_squareOneSide + 1, separate_squareOneSide + 1); // 縦書いて横に伸ばす
    }
  }
}

void makeWindow_show(){
  //image(canvas, 0, 0);
  image(pallet, height, lv01_golden);
  image(tab01, height, 0);
  image(tab02, height+lv02_golden/2, 0);
  image(tab03, height+lv02_golden, 0);
}

void maketab01(PGraphics tt){
  int separate_count = floor(tt.height / tt.width);

  tt.beginDraw();
  tt.translate(0, tt.height*0/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  pencil(tt, tt.width/2, tt.height/6, 10);

  tt.translate(0, tt.height*1/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  pencil(tt, tt.width/2, tt.height/6, 20);

  tt.translate(0, tt.height*1/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  pencil(tt, tt.width/2, tt.height/6, 30);
  tt.endDraw();

}
void maketab02(PGraphics tt){
  int separate_count = floor(tt.height / tt.width);

  tt.beginDraw();
  tt.translate(0, tt.height*0/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  eraser(tt, tt.width/2, tt.height/6, 10);

  tt.translate(0, tt.height*1/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  eraser(tt, tt.width/2, tt.height/6, 20);

  tt.translate(0, tt.height*1/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  eraser(tt, tt.width/2, tt.height/6, 30);
  tt.endDraw();
}
void maketab03(PGraphics tt){
  int separate_count = floor(tt.height / tt.width);
  int arrowSize = 15;
  float arrowStart_x = tt.width/2 - 4*arrowSize;
  float arrowStart_y = tt.height/8;

  tt.beginDraw();
  tt.translate(0, tt.height*0/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);

  tt.translate(0, tt.height*1/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);

  tt.translate(0, tt.height*1/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  tt.noStroke();
  tt.fill(0);
  tt.triangle(arrowStart_x + 4*arrowSize, arrowStart_y + 4*arrowSize, arrowStart_x + 8*arrowSize, arrowStart_y, arrowStart_x + 4*arrowSize, arrowStart_y - 4*arrowSize);
  tt.fill(0);
  tt.quad(arrowStart_x, arrowStart_y + 2*arrowSize, arrowStart_x + 4*arrowSize, arrowStart_y + 2*arrowSize, arrowStart_x + 4*arrowSize, arrowStart_y - 2*arrowSize, arrowStart_x, arrowStart_y - 2*arrowSize);

  tt.translate(0, tt.height*1/separate_count);
  tt.stroke(1);
  tt.fill(240);
  tt.rect(0, 0, tt.width, tt.height*1/separate_count);
  tt.noStroke();
  tt.fill(0);
  tt.triangle(arrowStart_x, arrowStart_y, arrowStart_x + 4*arrowSize, arrowStart_y + 4*arrowSize, arrowStart_x + 4*arrowSize, arrowStart_y - 4*arrowSize);
  tt.fill(0);
  tt.quad(arrowStart_x + 4*arrowSize, arrowStart_y + 2*arrowSize, arrowStart_x + 8*arrowSize, arrowStart_y + 2*arrowSize, arrowStart_x + 8*arrowSize, arrowStart_y - 2*arrowSize, arrowStart_x + 4*arrowSize, arrowStart_y - 2*arrowSize);

  tt.endDraw();

}

void pencil(PGraphics tt, float center_x, float center_y, float pencilSize){
  tt.noStroke();
  tt.fill(0);
  tt.triangle(center_x + pencilSize, center_y - 2*pencilSize, center_x + pencilSize, center_y + 2*pencilSize, center_x + 3*pencilSize, center_y);
  tt.fill(230, 190, 130);
  tt.quad(center_x + pencilSize, center_y - 2*pencilSize, ((center_x + pencilSize)+(center_x + 3*pencilSize))/2, ((center_y - 2*pencilSize)+(center_y))/2, ((center_x + pencilSize)+(center_x + 3*pencilSize))/2, ((center_y + 2*pencilSize)+(center_y))/2, center_x + pencilSize, center_y + 2*pencilSize);
  tt.fill(80,150,50);
  tt.rect(center_x - 3*pencilSize, center_y - 2*pencilSize, 4*pencilSize, 4*pencilSize);
}
void eraser(PGraphics tt, float center_x, float center_y, float eraserSize){
  tt.fill(255);
  tt.ellipse(center_x + eraserSize, center_y, 4*eraserSize, 4*eraserSize);
  tt.fill(100,170,220);
  tt.rect(center_x - 3*eraserSize, center_y - 2*eraserSize, 4*eraserSize, 4*eraserSize);
}

void make_stepImg_setup(){
  for (int i=0; i<stepImgNumber; i++){
    stepImg[i] = get(0, 0, height, height);
  }
}
void save_stepImg(){
  backCount = min(backCount+1, stepImgNumber-1);
  forwardCount = 0;
  stepImgCount_add();
  stepImg[stepImgCount] = get(0, 0, height, height);
}
void undo(){
  if (0 < backCount){
    backCount--;
    forwardCount++;
    stepImgCount_sub();
    show_stepImg();
  }
}
void redo(){
  if (0 < forwardCount){
    backCount++;
    forwardCount--;
    stepImgCount_add();
    show_stepImg();
  }
}
void stepImgCount_add(){
  stepImgCount = (stepImgCount + 1) % stepImgNumber;
}
void stepImgCount_sub(){
  stepImgCount = (stepImgCount - 1 + stepImgNumber) % stepImgNumber;
}
void show_stepImg(){
  image(stepImg[stepImgCount], 0, 0);
}

void mouseClicked(){
  float x = mouseX, y = mouseY;
  if ( height < x && x < height+lv02_golden/2
  && lv01_golden*0/3 < y && y < lv01_golden*1/3){
    ers_change = false;
    pen_size = 0.5*10;
    println(pen_size, ers_size, ers_change);
  }else if(height < x && x < height+lv02_golden/2
  && lv01_golden*1/3 < y && y < lv01_golden*2/3){
    ers_change = false;
    pen_size = 2*10;
    println(pen_size, ers_size, ers_change);
  }else if(height < x && x < height+lv02_golden/2
  && lv01_golden*2/3 < y && y < lv01_golden*3/3){
    ers_change = false;
    pen_size = 5*10;
    println(pen_size, ers_size, ers_change);
  }
  else if(height+lv02_golden/2 < x && x < height+lv02_golden
  && lv01_golden*0/3 < y && y < lv01_golden*1/3){
    ers_change = true;
    ers_size = 0.3*10;
    println(pen_size, ers_size, ers_change);
  }
  else if(height+lv02_golden/2 < x && x < height+lv02_golden
  && lv01_golden*1/3 < y && y < lv01_golden*2/3){
    ers_change = true;
    ers_size = 1*10;
    println(pen_size, ers_size, ers_change);
  }
  else if(height+lv02_golden/2 < x && x < height+lv02_golden
  && lv01_golden*2/3 < y && y < lv01_golden*3/3){
    ers_change = true;
    ers_size = 5*10;
    println(pen_size, ers_size, ers_change);
  }
  else if(height+lv02_golden < x && x < height+lv01_golden
  && height*3/4 < y && y < height*4/4){
    undo();
  }
  else if(height+lv02_golden < x && x < height+lv01_golden
  && height*2/4 < y && y < height*3/4){
    redo();
  }
}
void mousePressed(){
  if (0 < mouseX && mouseX < height && 0 < mouseY && mouseY < height){
    changeCanvas = true;
  }
}
void mouseDragged(){
  if (0 < mouseX && mouseX < height && 0 < mouseY && mouseY < height){
    changeCanvas = true;
  }
}
void mouseReleased(){
  if (changeCanvas){
    save_stepImg();
    changeCanvas = false;
  }
}

void draw(){
  float gg_pallet_center_x = height + lv02_golden/2;
  float gg_pallet_center_y = lv01_golden + lv02_golden/2;
  float gg_pallet_halfSquareOneSide = (1/sqrt(2))*circle_ratio*lv02_golden/2;

  if (mousePressed){
    float x = mouseX, y = mouseY;

    // カラーパレットの色相
    if (gg_pallet_center_x - gg_pallet_halfSquareOneSide < x
    && x < gg_pallet_center_x + gg_pallet_halfSquareOneSide
    && gg_pallet_center_y - gg_pallet_halfSquareOneSide < y
    && y < gg_pallet_center_y + gg_pallet_halfSquareOneSide){
      selectColor = get(round(x), round(y));
    }

    // カラーパレットの彩度と明度　dist 座標から座標の距離　円の領域指定
    if (circle_ratio*lv02_golden/2 < dist(x, y, gg_pallet_center_x, gg_pallet_center_y)
    && dist(x, y, gg_pallet_center_x, gg_pallet_center_y) < lv02_golden/2){
      selectColor = get(round(x), round(y));
      pallet.beginDraw();
      pallet.translate(lv02_golden/2, lv02_golden/2);
      makeColorpallet_draw02(pallet, circle_ratio*lv02_golden/2, hue(selectColor));
      pallet.endDraw();
      image(pallet, height, lv01_golden);
    }

    // キャンバスだけ書けるように条件付け
    if (0 < mouseX && mouseX < height && 0 < mouseY && mouseY < height
    && 0 < pmouseX && pmouseX < height && 0 < pmouseY && pmouseY < height){
      if (ers_change){
        stroke(eraserColor);
        strokeWeight(ers_size);
      }else{
        stroke(selectColor);
        strokeWeight(pen_size);
      }
    line(mouseX, mouseY, pmouseX, pmouseY);
    }
    image(tab01, height, 0);
    image(tab02, height+lv02_golden/2, 0);
    image(tab03, height+lv02_golden, 0);
  }
}

void keyPressed(){
  if (keyCode == 'A'){
    downA = true;
    return;
  }
  if (key == CODED){
    if (keyCode == CONTROL){
      downCtrl = true;
    }
    if (keyCode == SHIFT){
      downShift = true;
    }
    return;
  }
  if (downCtrl){
    if (keyCode == 'Z'){
      if (downShift){
        redo();
      }else{
        undo();
      }
    }
    if (keyCode == 'S' && !downShift){
      dayY = year();
      dayM = month();
      dayD = day();
      timeH = hour();
      timeM = minute();
      timeS = second();
      dayString = nf(dayY, 4) + nf(dayM, 2) + nf(dayD, 2);
      timeString = nf(timeH, 2) + nf(timeM, 2) + "-" + nf(timeS, 2);
      get(0, 0, height, height).save("image_" + dayString + "_" + timeString +".png");
      println("保存しました");
    }
    if (downShift && downA){
      if (keyCode == 'D'){ //最後にDを押さないと実行しない
        noStroke();
        fill(color(0, 0, 100));
        rect(0, 0, height, height);
        make_stepImg_setup();
        backCount = 0;
        forwardCount = 0;
        stepImgCount = 0;
        changeCanvas = false;
        println("すべて削除");
      }
    }
    return;
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == CONTROL){
      downCtrl = false;
    }
    if (keyCode == SHIFT){
      downShift = false;
    }
  }
  if (keyCode == 'A'){
    downA = false;
  }
}
