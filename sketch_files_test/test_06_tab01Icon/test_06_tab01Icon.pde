int a=100;
int b=100;
int c=10;
void setup(){
  size(191, 618);
  background(255);
  triangle(a,b,a+4*c,b+4*c,a+4*c,b-4*c);
  quad(a+4*c,b+2*c, a+8*c,b+2*c, a+8*c,b-2*c, a+4*c,b-2*c);
}
