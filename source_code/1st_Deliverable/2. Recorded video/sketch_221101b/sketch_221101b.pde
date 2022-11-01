import processing.video.*;
Movie myMovie;

void setup() {
  size(1500, 1500);
  frameRate(30);
  myMovie = new Movie(this, "videaki.mp4");
  myMovie.speed(2.0);
  myMovie.loop();
}

void draw() {
  float r = map(mouseX,0,width,0,4);
  myMovie.speed(r);
  if (myMovie.available()) {
    myMovie.read();
  }
  image(myMovie, 0, 0);
}
