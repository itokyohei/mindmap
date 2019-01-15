int c=15;
float a=236/2-4*c;
float b=618/8;

void setup(){
  size(236, 618);
  background(255);

  translate(0, 0);
  fill(255);
  rect(0,0,236,618/4);

  translate(0, 618*1/4);
  fill(255);
  rect(0,0,236,618/4);

  translate(0, 618*1/4);
  fill(255);
  rect(0,0,236,618/4);
  fill(0);
  triangle(a+4*c,b+4*c ,a+8*c,b ,a+4*c,b-4*c);
  fill(0);
  quad(a,b+2*c, a+4*c,b+2*c ,a+4*c,b-2*c ,a,b-2*c);



  translate(0, 618*1/4);
  fill(255);
  rect(0,0,236,618/4);
  fill(0);
  triangle(a,b,a+4*c,b+4*c,a+4*c,b-4*c);
  fill(0);
  quad(a+4*c,b+2*c, a+8*c,b+2*c, a+8*c,b-2*c, a+4*c,b-2*c);
}
