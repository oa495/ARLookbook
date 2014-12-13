import processing.video.*;
import jp.nyatla.nyar4psg.*;
import ddf.minim.*;
PImage yourImage;
// video object
Capture video;
PFont font;
// motion detector object (see class for more info)
MotionDetector detector;

// AR detector
MultiMarker augmentedRealityMarkers;

// array for the various shirts we want to display
PImage[] shirts = new PImage[4];
int imageIndex = 0;

// sound assets
Minim minim;
AudioPlayer snap;
AudioPlayer click;

// buttons & flags to keep track of button states
Buttons arrowL;
Buttons arrowR;
Buttons camera;
boolean cameraTouched;
boolean arrowRTouched;
boolean arrowLTouched;
PMatrix3D lastKnownPositionOfMarker;
// "cooldown" variable - helps prevent click spamming in motion detection
int cooldown = 0;


// interface holders (this will remove the buttons from the main canvas)
PGraphics buttonInterface;


// timer variables
int msec, sec;
boolean start;
boolean timerMode = false;
int timer;


void setup() 
{
  // set up canvas
  size(640, 480, OPENGL);
  font = loadFont("Avenir-Heavy-48.vlw");
  textFont(font);
  // set up video
  video = new Capture(this, 640, 480);
  video.start();

  // create our motion detector - this does everything for you!
  // we need to send it our video object, whether we want to mirror the video ("true")
  // and whether we want to be in "debug" mode and actually see the changed pixels ("true")
  // we can also send the detector a tolerance level - this is a percentage that represents
  // how many pixels need to change before we qualify a "hit"
  detector = new MotionDetector(video, true, false, 0.15);


  // set up AR markers  
  augmentedRealityMarkers = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  //augmentedRealityMarkers.addARMarker("patt.hiro", 80);
  augmentedRealityMarkers.addARMarker(loadImage("dress1_ar.png"), 16, 25, 80);


  // set up sound
  minim = new Minim(this);
  snap = minim.loadFile("snap.wav");
  click = minim.loadFile("click.mp3");


  // set up buttons
  arrowR = new Buttons(520, 200, "arrowRight");
  arrowL = new Buttons(50, 200, "arrowLeft");
  camera = new Buttons(300, 20, "camera");


  // set up shirts
  shirts[0] = loadImage("shirt.png");
  shirts[1] = loadImage("shirt2.png");
  shirts[2] = loadImage("shirt3.png");
  shirts[3] = loadImage("shirt4.png");


  // set up our button interface (this lets us draw the buttons to a different canvas so they
  // don't show up on the main canvas when we take a photo)
  buttonInterface = createGraphics(width, height);


  /*
  previousFrame = new PImage(640, 480, ARGB);
   finalImage = new PImage(640, 480, ARGB);
   //shirt = loadImage("shirt.png");
   */
}

void draw()
{
  // always have the detector call its run function here
  detector.run();


  // see if a button is touched (this uses the motion detector class)
  // ONLY DO THIS IF THE TIMER ISN'T RUNNING

  if ((timerMode == false) && (millis() > 20000))
  {
    print("ready!");
    arrowRTouched = detector.checkForMotion(arrowR.xPos, arrowR.yPos, 100, 100);
    arrowLTouched = detector.checkForMotion(arrowL.xPos, arrowL.yPos, 100, 100);
    cameraTouched = detector.checkForMotion(camera.xPos, camera.yPos, 100, 100);
  }

  // ask the detector to draw the video to the screen
  detector.displayVideo();


  // display the buttons ONLY IF THE TIMER ISN'T RUNNING
  if (timerMode == false)
  {
    buttonInterface.clear();
    if (arrowRTouched) {
      if (millis()%4 == 0) {
        click.pause();
        click.rewind();
        click.play();
      }
      // go to the next image, if necessary
      if (cooldown <= 0)
      {
        arrowR.displayOnHover();
        imageIndex--;
        if (imageIndex <= 0) {
          imageIndex = shirts.length-1;
        }
        cooldown = 50;
      }

      //arrowRTouched = false;
    } else {
      arrowR.display();
    }

    if (arrowLTouched) {
      //print("hey!");
      arrowL.displayOnHover();
      if (millis()%4 == 0) {
        click.pause();
        click.rewind();
        click.play();
      }
      // go to the next image, if necessary
      if (cooldown <= 0)
      {
        imageIndex++;
        if (imageIndex >= shirts.length) {
          imageIndex = 0;
        }
        cooldown = 50;
      }
      //   arrowLTouched = false;
    } else {   
      arrowL.display();
    }
    if (cameraTouched) {
      if (millis()%4 == 0) {
        click.pause();
        click.rewind();
        click.play();
      }
      // camera.displayOnHover();
      startTimer();
    } else {
      //println("x");
      //  println(cameraTouched);
      camera.display();
    }

    // draw the button interface ONLY if the timer isn't running!
    image(buttonInterface, 0, 0);
  }

  // always call the timer (it will run if the camera button has been touched)
  timer();

  // always reduce our cooldown
  if (cooldown > 0) {
    cooldown--;
  }



  // now draw the AR content
  try {
    augmentedRealityMarkers.detect(detector.mirroredFrame);

    // if they exists then we will be given information about their location
    // note that we only have one pattern that we are looking for, so it will be pattern 0
    if (augmentedRealityMarkers.isExistMarker(0))
    {
      // }
      // set the AR perspective
      augmentedRealityMarkers.setARPerspective();

      // next, remember the current transformation matrix
      pushMatrix();

      // change the transformation matrix so that we are now drawing in 3D space on top of the marker
      setMatrix(augmentedRealityMarkers.getMarkerMatrix(0));

      // flip the coordinate system around so that we can draw in a more intuitive way (if you don't do this
      // then the x axis will be flipped)
      scale(-1, -1);


      // draw the correct shirt here
      imageMode(CENTER);
      image(shirts[imageIndex], 0, 0, 375, 375);
      imageMode(CORNER);


      // all done!  time to clean up ...

      // reset to the default perspective
      perspective();

      // restore the 2D transformation matrix
      popMatrix();
    }
  }
  catch (Exception e) {
    println("AR error");
  }
}

void startTimer() {

  if (!timerMode) {
    msec = millis();
    timerMode = true;
  }
}

void timer() {

  if (timerMode) {
    if (!start) {
      sec = floor((millis()-msec)*.001);
      println("*"+sec);
      if (sec == 4) start = true;
    } else {   
      println("x");
      takePicture();
      reset();
    }
    fill(255);
    stroke(255);
    if (sec == 3) { //after three seconds one second remains ...
      //   println("z");
      fill(255);
      textSize(50);
      text(1, 100, 100);
    }
    if (sec == 2) {
      fill(255);
      textSize(50);
      // println("q");
      text(2, 100, 100);
    }
    if (sec == 1) {
      fill(255);
      textSize(50);
      text(3, 100, 100);
    }
  }
}
void reset() {
  // println("a");
  timerMode = false;
  start = false;
  // print("x");
  cameraTouched = false;
  // snap.pause();
}
int number = 0;
void takePicture() {        
  snap.pause();
  snap.rewind();
  snap.play();
  yourImage = detector.mirroredFrame;
  PImage myImage = yourImage.get(0, 0, 640, 480);
  // PImage myImage = yourImage.copy(0, 0, 640, 480, 0, 0, 640, 480);
  String s = "yourImage" + nf(number, 4) +".jpg";
  myImage.save(s);
  number++;
}

