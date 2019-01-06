<html>

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title>Built with Processing</title>
<script type="text/javascript" src="processing.js">
</script>

</head>

<body>
<div align="center">

<h1>Processing.js!</h1>
<canvas data-src="sketch_suketti.pde" width="200" height="200"></canvas>

</div>
</body>

</html>
---

void setup() {
  size(640, 360);
  background(102);
}

void draw() {
  stroke(255);
  if (mousePressed == true) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

int count =1;
void keyPressed(){
  if(key =='p' ||key =='P'){
    String path =System.getProperty("user.home")+"/Desktop/screenshot"+count+".jpg";
    save(path);
    count++;
    println("screen saved."+path);
  }
  else if(key =='t'){
    link("https://twitter.com/intent/tweet?text=");
  }
}
---
