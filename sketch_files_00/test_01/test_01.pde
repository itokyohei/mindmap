int squareOneSide = 800;
float r = squareOneSide*3/4;
boolean controlDown = false;
boolean shiftDown = false;

void setup() {
  size(1000, 1000);
  background(255);
  colorMode(HSB, 360, 100, 100);
  colorPallet();
  colorPalletDraw();
}

void draw() {
    /*
    if (mousePressed){
    strokeWeight(10);
    line(mouseX, mouseY, pmouseX, pmouseY);
    */
    if(mousePressed){
      color c = get(mouseX, mouseY);
      println("color", hue(c), saturation(c), brightness(c));
      // println("zahyou", mouseX, mouseY);
    }

}

void colorPallet(){
  translate(width/2, height/2);
  rect(- squareOneSide/2, - squareOneSide/2, squareOneSide, squareOneSide);
  ellipse(0, 0, squareOneSide, squareOneSide);
  // ellipse(0, 0, r, r);
  rect(- r*(1/sqrt(2))/2, - r*(1/sqrt(2))/2, r*(1/sqrt(2)), r*(1/sqrt(2)));
  colorPallet02();
}

void colorPalletDraw(){
  for(int i = 0; i < 360; i++){
    strokeWeight(8);
    float rad = TWO_PI/360;
    stroke(getColor(i, 100, 100));
    line(cos(rad*i)*r/2, sin(rad*i)*r/2, cos(rad*i)*squareOneSide/2, sin(rad*i)*squareOneSide/2);
  }
}

color getColor(int i, int j, int k){
  return color(i, j, k);
}

void colorPallet02(){
  int s = 50; // 何個に分けるか
  float x = r*(1/sqrt(2))/s; // 1マスの辺
  float y = -r*(1/sqrt(2))/2; // スタートの座標
  noStroke();
  for(int i = 0; i < s; i++){
    for(int j = 0; j < s; j++){
      int aa = 100*(i+1)/s;
      int bb = 100*(j+1)/s;
      fill(getColor(0, abs(100-aa), abs(100-bb)));
      rect(y+x*i, y+x*j, x, x); // 縦書いて横に伸ばす
      // println("S_S", i, "B_B", j);
      // println("S", 100*(i+1)/s, "B", 100*(j+1)/s);
    }
  }
}

void keyPressed() {
  if (key=='s') {
    saveFrame("image####.png");
  }
}
