PGraphics g;

float pen_size = 10; //0.5 2 5
float ers_size = 5; //0.1 1 5



void setup(){
  size(1000, 1000);

  g = createGraphics(250, 250);
  g.beginDraw();
  g.background(255);
  g.endDraw();
  image(g, 0, 0);
}

void mouseClicked(){
  if ( mouseX < 250 && mouseY < 250){
    pen_size = 1;
  }else{
    pen_size = 10;
  }
}

void draw(){
  if (mousePressed){
    strokeWeight(pen_size);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}
