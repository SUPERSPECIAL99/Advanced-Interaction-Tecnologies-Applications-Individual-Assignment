PImage img; 

void setup() {
  size(600, 600);
  
  img = loadImage("qr.png");
}

void draw() {
  background(0);
  image(img, 0, 0, width, height);
}
