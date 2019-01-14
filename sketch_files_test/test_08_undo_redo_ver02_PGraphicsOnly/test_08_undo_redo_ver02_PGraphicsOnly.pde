PGraphics gg;
PGraphics[] step_img;
int step_img_number = 15; //保存する画像数
int back_count = 0, forward_count = 0; // 戻った回数進んだ回数
int step_img_count; // 取り出す画像の指定
boolean changeCanvas = false;
boolean makeBranch;

void setup(){
  size(1500, 1500);

  gg = createGraphics(500, 500);
  gg.beginDraw();
  gg.background(255);
  gg.endDraw();
  image(gg, 250, 250);

  fill(color(0, 255, 0));
  rect(0, 0, 100, 100);
  fill(color(0, 0, 255));
  rect(100, 0, 100, 100);

  step_img = new PGraphics[step_img_number];
  for (int i=0; i<step_img_number; i++){
    step_img[i] = createGraphics(500, 500);
  }
  //step_img[1].beginDraw();
  //step_img[1].background(255);
  //step_img[1].endDraw();
  //image(step_img[1], 750, 750);
}

void undo(){
  if (0 < back_count){
    back_count--;
    forward_count++;
    println("back_count戻った回数", back_count, "forward_count進んだ回数", forward_count);
    step_img_count_sub();
    show_step_img();
  }
}

void redo(){
  if (0 < forward_count){
    back_count++;
    forward_count--;
    println("back_count戻った回数", back_count, "forward_count進んだ回数", forward_count);
    step_img_count_add();
    show_step_img();
  }
}

void save_step_img(){
  println("back_count一時保存するときに戻れる回数を増やす前", back_count);
  back_count = min(back_count+1, round(step_img_number/2));
  println("back_count一時保存するときに戻れる回数を増やす後", back_count);
  step_img_count_add();
  println("step_img_count保存する配列番号", step_img_count);
  step_img[step_img_count] = gg;
}

void step_img_count_add(){
  step_img_count = (step_img_count + 1) % step_img_number;
}
void step_img_count_sub(){
  step_img_count = (step_img_count - 1 + step_img_number) % step_img_number;
}

void show_step_img(){
  println("step_img_count一時保存から取り出した配列番号", step_img_count);
  image(step_img[step_img_count], 250, 250);
  println("---");
}

void mouseClicked(){
  float x = mouseX, y = mouseY;
  if (0 < x && x < 100 && 0 < y && y < 100){
    undo();
  }else if (100 < x && x < 200 && 0 < y && y < 100){
    redo();
  }
}

void mousePressed(){
  if (250 < mouseX && mouseX < 750 && 250 < mouseY && mouseY < 750){
    changeCanvas = true;
  }
}
void mouseDragged(){
  if (250 < mouseX && mouseX < 750 && 250 < mouseY && mouseY < 750){
    changeCanvas = true;
  }
}

void mouseReleased(){
  if (changeCanvas){
    changeCanvas = false;
    save_step_img();
  }
}

void draw(){
  if (mousePressed){
    gg.beginDraw();
    gg.strokeWeight(10);
    gg.line(mouseX-250, mouseY-250, pmouseX-250, pmouseY-250);
    gg.endDraw();
    image(gg, 250, 250);
  }
  image(step_img[0], 800, 250);
  image(step_img[1], 250, 800);
  image(step_img[2], 800, 800);
}



/*
画像の保存はcanvasに変更があったときってしたい
でも外で押してcanvasを書いて中に外にいくやつをどう対応するか
もしストロークしている途中の線がエリアの中に入ったら保存する機能を発動させればいい
でも保存するのは一筆で1回にしたい
入ったからtrueにして離れたときにifで保存させればいいのでは?
クリックでも描画されるからクリックした点が範囲内ならtrueにすればいい

一瞬残るのは、tabでクリックしているから
一時保存しているのと表示しているのが違うから
PImageとPGraphicsの違い
ウィンドウには書かれているのに一番上がPImageだから
配列をウィンドウにすればいい?
*/
/*
boolean controlDown = false, shiftDown = false;
void keyPressed() {
  if (key == CODED) {
    if (keyCode == CONTROL)
      controlDown = true;
    if (keyCode == SHIFT)
      shiftDown = true;
    return;
  }

  if (controlDown) {
    if (keyCode == 'Z') {
      if (shiftDown)
        redo();
      else
        undo();
    }
    return;
  }
  if (key=='s') {
    gg.save("image"+"###"+".png");
    println("保存しました");
  }
}
*/
/*
void keyReleased() {
  if (key == CODED) {
    if (keyCode == CONTROL)
      controlDown = false;
    if (keyCode == SHIFT)
      shiftDown = false;
  }
}
*/
