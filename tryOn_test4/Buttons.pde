class Buttons {
  float xPos;
  float yPos;
  String name;
  boolean hover = false;
  PImage arrowRightOH;
  PImage arrowLeft;
  PImage arrowRight;
  PImage arrowLeftOH;
  PImage cameraP;
  PImage cameraOnHover;


  Buttons(float x, float y, String n) {
    this.xPos = x;
    this.yPos = y;
    this.name = n;
    arrowLeft = loadImage("arrowleft.png");
    arrowRight = loadImage("arrowright.png");
    arrowLeftOH = loadImage("arrowleft(OT).png");
    arrowRightOH = loadImage("arrowright(OT).png");
    cameraP = loadImage("camera.png");
    cameraOnHover = loadImage("camera(OT).png");
  }

  void display() {
    if (name == "arrowRight") {
      buttonInterface.image(arrowRight, xPos, yPos);
    }
    if (name == "arrowLeft") {
      buttonInterface.image(arrowLeft, xPos, yPos);
    }
    if (name == "camera") {
      buttonInterface.image(cameraP, xPos, yPos);
    }
  }
  void displayOnHover() {
    if (name == "arrowRight") {
      buttonInterface.image(arrowRightOH, xPos, yPos);
    }
    if (name == "arrowLeft") {
      buttonInterface.image(arrowLeftOH, xPos, yPos);
      //print("hi");
    }
    if (name == "camera") {
  //    print("It changes!");
      buttonInterface.image(cameraOnHover, xPos, yPos);
    }
  }
}

