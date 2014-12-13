int msec, sec;
boolean start;

void setup() {
  size(320, 600);
  smooth();
}

void draw() {
  background(0);

  if (!start) {
    sec = floor((millis()-msec)*.001);
    //above:
    //current cumulative time in thousands of a second subtract the
    //time the countdown started to start from "now" divide by 1000
    //and drop the decimal part
    if (sec == 4) start = true;
  } else {
    //do stuff here when the coundown finishes    
    ellipse(random(width), random(height), 100, 100);
  }


  ////seconds////
  fill(255);
  stroke(255);
  if (sec == 3) { //after three seconds one second remains ...
    textSize(80);
    text(1, 100, 100);
  }
  if (sec == 2) {
    textSize(80);
    text(2, 100, 100);
  }
  if (sec == 1) {
    textSize(80);
    text(3, 100, 100);
  }
}

void mouseClicked() {
  //countdown again first resetting the "now" time and start var
  msec = millis();
  start = false;
}

