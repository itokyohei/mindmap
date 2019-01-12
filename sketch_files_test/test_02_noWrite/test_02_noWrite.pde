PGraphics g;
int a = 500;

void setup(){
  size(1000, 1000);

  g = createGraphics(a-200, a);
  g.beginDraw();
  g.background(255);
  g.endDraw();

}

void draw(){

  println(mouseX, mouseY);
  if (mousePressed){
  strokeWeight(10);
  line(mouseX, mouseY, pmouseX, pmouseY);
  image(g, 250, 250);
  }
}
