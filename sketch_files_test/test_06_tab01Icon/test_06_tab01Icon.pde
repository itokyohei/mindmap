float c=10;
float a=191/2;
float b=618/6;

void setup(){
  size(191, 618);
  background(255);

  translate(0, 0);
  fill(0);
  triangle(a+c,b-2*c, a+c,b+2*c, a+3*c,b);
  fill(0,128,0);
  rect(a-3*c,b-2*c,4*c,4*c);

  translate(0, 618/3);
  fill(0);
  triangle(a+2*c,b-2*2*c, a+2*c,b+2*2*c, a+3*2*c,b);
  fill(0,128,0);
  rect(a-3*2*c,b-2*2*c,4*2*c,4*2*c);


  translate(0, 618/3);
  fill(0);
  triangle(a+3*c,b-2*3*c, a+3*c,b+2*3*c, a+3*3*c,b);
  fill(0,128,0);
  rect(a-3*3*c,b-2*3*c,4*3*c,4*3*c);
}
