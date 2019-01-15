void setup(){
  size(300, 300);
  fill(255, 255, 255);
  rect(0, 0, 200, 200);
}

void draw(){
}

void mouseClicked(){
  println("クリックされました");
  println("---");
}

void keyPressed(){
  println("キーが押されました");
  if (key == CODED){
    println("keyPressed", key);
  }else{
    println("elsekeyPressed", key);
  }
  println("keyPressedCode", keyCode);
  println("---");
}

void keyReleased(){
  println("キーが離されました");
  println("keyReleased", key);
  println("keyReleasedCode", keyCode);
  println("---");
}
