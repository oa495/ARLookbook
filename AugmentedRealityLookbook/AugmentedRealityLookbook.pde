import saito.objloader.*;
import processing.video.*;
import jp.nyatla.nyar4psg.*;
Capture video;
MultiMarker augmentedRealityMarkers;
int itemRotation;
OBJModel skirt1;
OBJModel outfit2;
OBJModel outfit3;
OBJModel dress1;
PShape shoe2;
PShape shoe3;
PShape dress2;
PShape dress3;
PShape bag1;
PShape bag2;
PImage dressTexture1;
PImage dressTexture2;
PImage bagTexture1;
PImage bagTexture2;
PImage skirtTexture1;
PImage skirtTexture2;
PImage shoeTexture1;
PImage shoeTexture2;
PFont font;
String price;
int whichToShow = 1;
int numberToShow;
boolean called;
boolean called2;
boolean color1Detected = false;
boolean color2Detected = false;

// look array to hold the 7 clothing items
PImage[] look1 = new PImage[5];
PImage[] look2 = new PImage[5];
PImage[] look3 = new PImage[12];
PImage[] look4 = new PImage[5];
PImage[] look5 = new PImage[6];

// image index positions
int imageIndex = 0;
int imageIndexLeft = 7;

boolean imageReadyToGoRight = true;

boolean imageReadyToGoLeft = true;

void setup() 
{
  size(640, 480, OPENGL);
  font = loadFont("Avenir-BookOblique-48.vlw");
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("none");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + ": " + cameras[i]);
    }
  }

 // video = new Capture(this, 640, 480);
 video = new Capture(this, 640, 480);
  video.start();
  augmentedRealityMarkers = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  augmentedRealityMarkers.addARMarker(loadImage("bag1_ar.png"), 16, 25, 80);
  augmentedRealityMarkers.addARMarker(loadImage("dress1_ar.png"), 16, 25, 80);
  augmentedRealityMarkers.addARMarker(loadImage("shoe1_ar.png"), 16, 25, 80);
  augmentedRealityMarkers.addARMarker(loadImage("skirt1_ar.png"), 16, 25, 80);
  load3DModels();
  // look1 marker
  augmentedRealityMarkers.addARMarker(loadImage("look1.png"), 16, 25, 80);  
  // look2 marker
  augmentedRealityMarkers.addARMarker(loadImage("look2.png"), 16, 25, 80); 
  // look3 marker
  augmentedRealityMarkers.addARMarker(loadImage("look3.png"), 16, 25, 80); 
  // look4 marker
  augmentedRealityMarkers.addARMarker(loadImage("look4.png"), 16, 25, 80); 
  // look5 marker
  augmentedRealityMarkers.addARMarker(loadImage("look5.png"), 16, 25, 80); 
  augmentedRealityMarkers.addARMarker(loadImage("shirt1_ar.png"), 16, 25, 80);


  // load in look1 images
  look1[0] = loadImage("look1_1.png");
  look1[1] = loadImage("look1_2.png");
  look1[2] = loadImage("look1_3.png");
  look1[3] = loadImage("look1_4.png");
  look1[4] = loadImage("look1_5.png");

  // load in look2 images
  look2[0] = loadImage("look2_1.png");
  look2[1] = loadImage("look2_2.png");
  look2[2] = loadImage("look2_3.png");
  look2[3] = loadImage("look2_4.png");
  look2[4] = loadImage("look2_5.png");

  // load in look3 images
  look3[0] = loadImage("look3_1.png");
  look3[1] = loadImage("look3_2.png");
  look3[2] = loadImage("look3_3.png");
  look3[3] = loadImage("look3_4.png");
  look3[4] = loadImage("look3_5.png");
  look3[5] = loadImage("look3_6.png");
  look3[6] = loadImage("look3_7.png");
  look3[7] = loadImage("look3_8.png");
  look3[8] = loadImage("look3_9.png");
  look3[9] = loadImage("look3_10.png");
  look3[10] = loadImage("look3_11.png");
  look3[11] = loadImage("look3_12.png");

  // load in look4 images
  look4[0] = loadImage("look4_1.png");
  look4[1] = loadImage("look4_2.png");
  look4[2] = loadImage("look4_3.png");
  look4[3] = loadImage("look4_4.png");
  look4[4] = loadImage("look4_5.png");

  // load in look5 images
  look5[0] = loadImage("look5_1.png");
  look5[1] = loadImage("look5_2.png");
  look5[2] = loadImage("look5_3.png");
  look5[3] = loadImage("look5_4.png");
  look5[4] = loadImage("look5_5.png");
  look5[5] = loadImage("look5_6.png");
}

void load3DModels() {
  bagTexture1 = loadImage("bag/bag3T.jpg");
  bagTexture2 = loadImage("bag/bag2T.jpg");
  dressTexture1 = loadImage("dress/dress3T.JPG");
  dressTexture2 = loadImage("dress/dress1T.JPG");
  skirtTexture1 = loadImage("skirt/Skirt.jpg");
  skirtTexture2 = loadImage("skirt/Skirt2.JPG");
  shoeTexture1 = loadImage("shoe/shoe2.jpg");
  shoeTexture2 = loadImage("shoe/shoe.jpg");
  skirt1 = new OBJModel(this, "skirt/Skirt.obj");
  dress1 = new OBJModel(this, "dress/halter.obj");
  outfit2 = new OBJModel(this, "outfit/outfit2.obj");
  outfit3 = new OBJModel(this, "outfit/outfit3.obj");
  dress2 = loadShape("dress/dress2.obj");
  dress3 = loadShape("dress/dress3.obj");
  bag1 = loadShape("bag/bag.obj");
  bag2 = loadShape("bag/bag2.obj");  
  shoe2 = loadShape("shoe/Sneakers.obj");
  shoe3 = loadShape("shoe/heel.obj");
  alter();
}

void alter() {
  //skirt1.disableMaterial();
  dress1.disableMaterial();
  skirt1.scale(2);
  shoe2.scale(4);
  shoe3.scale(4);
  dress1.scale(5);
  dress2.scale(1);
  dress3.scale(1);
  bag1.scale(4);
  bag2.scale(4);
} 
void draw()
{
  textFont(font);
  if (video.available())
  {
    video.read();
    imageMode(CORNER);
    image(video, 0, 0);
    try {
      augmentedRealityMarkers.detect(video);
      boolean closeSS = false;
      if (augmentedRealityMarkers.isExistMarker(9) && augmentedRealityMarkers.isExistMarker(3))
      {
        // ok, now we are in business!  Test to see how far apart they are
        // first, get their position in 2D space
        PVector[] marker1 = augmentedRealityMarkers.getMarkerVertex2D(3);
        PVector[] marker2 = augmentedRealityMarkers.getMarkerVertex2D(9);

        // now we can compute the distance from marker1 to marker2


        // cheesy way - just use one point (the top left point of the marker)
        //      float distance = dist(marker1[0].x, marker1[0].y, marker2[0].x, marker2[0].y);

        // a better way would be to:  average up the 4 points of each marker and obtain the center point, then compute the
        // distance between the two center points
        float x1 = (marker1[0].x + marker1[1].x + marker1[2].x + marker1[3].x)/4;
        float y1 = (marker1[0].y + marker1[1].y + marker1[2].y + marker1[3].y)/4;
        float x2 = (marker2[0].x + marker2[1].x + marker2[2].x + marker2[3].x)/4;
        float y2 = (marker2[0].y + marker2[1].y + marker2[2].y + marker2[3].y)/4;      
        float distance = dist(x1, y1, x2, y2);

        // if it's less than a certain threshold, we can make a note of this
        println("distance is: " + distance);
        if (distance < 200)
        {
          // they are close!
          closeSS = true;
        }
      }
      if (augmentedRealityMarkers.isExistMarker(0))
      {
        augmentedRealityMarkers.setARPerspective();
        //bag
        pushMatrix();
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(0));
        scale(-1, -1);
        pushMatrix();
        translate(0, 0, 50);
        rotateX( radians(90) );
        rotateY( radians(itemRotation) );
        if (whichToShow == 1) {
          if (color1Detected) {
            bag1.setTexture(bagTexture1);
          } else if (color2Detected) {
            bag1.setTexture(bagTexture2);
          } else {
            bag1.setTexture(bagTexture1);
          }

          shape(bag1);
          price = "$50";
        } else if (whichToShow == 2) {
          if (color2Detected) {
            bag2.setTexture(bagTexture1);
          } else if (color1Detected) {
            bag2.setTexture(bagTexture2);
          } else {
            bag2.setTexture(bagTexture2);
          }
          shape(bag2);
          price = "$75";
        }
        popMatrix();
        displayText(price); // zzzzz
        itemRotation++;
        makeArrowButtons(2);
      } else if (augmentedRealityMarkers.isExistMarker(2)) {
        //shoe
        augmentedRealityMarkers.setARPerspective();
        pushMatrix();
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(2));
        scale(-1, -1);
        pushMatrix();
        shoe2.setTexture(shoeTexture1);
        shoe3.setTexture(shoeTexture1);

        translate(0, 0, 30);
        rotateZ( radians(180) );
        if (whichToShow == 1) {
          if (color1Detected) {
            shoe2.setTexture(shoeTexture1);
          } else if (color2Detected) {
            shoe2.setTexture(shoeTexture2);
          } else {
            shoe2.setTexture(shoeTexture1);
          }
          rotateZ( radians(itemRotation) );
          price = "$80";
          shape(shoe2);
        } else if (whichToShow == 2) {
          if (color1Detected) {
            shoe3.setTexture(shoeTexture1);
          } else if (color2Detected) {
            shoe3.setTexture(shoeTexture2);
          } else {
            shoe3.setTexture(shoeTexture1);
          }
          price = "$50";
          rotateY( radians(itemRotation) );
          shape(shoe3);
        }    
        popMatrix();
        displayText(price);
        itemRotation++;
        makeArrowButtons(2);
      } else if (augmentedRealityMarkers.isExistMarker(3)) {
        //skirt
        augmentedRealityMarkers.setARPerspective();
        pushMatrix();
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(3));
        scale(-1, -1);
        pushMatrix();
        if (closeSS) {
          translate(10, 10, 90);
          rotateY( radians (180) );
          rotateY( radians (180) );
          stroke(227, 196, 211);
          skirt1.draw();
          popMatrix();

          pushMatrix();
          translate(10, 10, 40);
          rotateX( radians(90) );
          shoe3.setTexture(shoeTexture2);
          shape(shoe3);
          popMatrix();
          perspective();
          popMatrix();
        } else {
          translate(0, 0, 70);
          rotateY( radians (180) );
          price = "$50";
          //   displayText(price);
          rotateY( radians(180) );
          rotateZ( radians(itemRotation) );
          noStroke();
          noFill();
          if (color1Detected) {
            //print("pink");
            stroke(227, 196, 211);
            // skirt1.setTexture(skirtTexture2);
            color1Detected = false;
          } else if (color2Detected) {
            // print("red");
            stroke(176, 30, 33);
            skirt1.setTexture(skirtTexture1);
          } else {
            noStroke();
            noFill();
          }
          skirt1.draw();
          popMatrix();
          displayText(price);
          itemRotation++;
          makeArrowButtons(3);
        }
      } else if (augmentedRealityMarkers.isExistMarker(1)) {
        //dress
        augmentedRealityMarkers.setARPerspective();
        pushMatrix();
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(1));
        scale(-1, -1);
        pushMatrix();

        //  whichToShow = 2;
        if (whichToShow == 1) {
          rotateX( radians(180) );
          if (color1Detected) {
            dress1.setTexture(dressTexture1);
            stroke(229, 209, 202);
          } else if (color2Detected) {
            dress1.setTexture(dressTexture2);
            stroke(205, 140, 230);
          } else {
            dress1.setTexture(dressTexture1);
            stroke(229, 209, 202);
          }
          rotateZ( radians(itemRotation) );
          price = "$50";
          //   displayText(price);
          rotateX( radians(90) );
          dress1.draw();
        } else if (whichToShow == 2) {
          rotateX( radians(-180) );
          translate(0, 0, 10);
          if (color1Detected) {
            dress2.setTexture(dressTexture1);
          } else if (color2Detected) {
            dress2.setTexture(dressTexture2);
          } else {
            dress2.setTexture(dressTexture1);
          }
          rotateY( radians(itemRotation) );
          shape(dress2);
          price = "$50";
          /// displayText(price);
        } else if (whichToShow == 3) {
          rotateX( radians(180) ); //-90
          if (color1Detected) {
            dress3.setTexture(dressTexture1);
          } else if (color2Detected) {
            dress3.setTexture(dressTexture2);
          } else {
            dress3.setTexture(dressTexture1);
          }
          rotateY( radians(itemRotation) );
          shape(dress3);
          price = "$50";
        }
        popMatrix();
        itemRotation++;
        displayText(price);
        makeArrowButtons(3);
      } else if (augmentedRealityMarkers.isExistMarker(4))
      {
        // set the AR perspective
        augmentedRealityMarkers.setARPerspective();

        // next, remember the current transformation matrix
        pushMatrix();

        // change the transformation matrix so that we are now drawing in 3D space on top of the marker
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(4));

        // flip the coordinate system around so that we can draw in a more intuititve way (if you don't do this
        // then the x & y axis will be flipped)
        scale(-1, -1);

        // we are now at 0,0,0 in the dead center of the marker
        // if we draw anything here it will be rotated and scaled accordingly
        // note that the marker is 80 x 80
        imageMode(CENTER);

        // display the item of clothing to the screen
        image(look1[imageIndex], 0, 0, 80, 80);

        // move to the bottom right side of the marker (right arrow button)
        pushMatrix();
        translate(32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);

        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosRightButton = (int)screenX(0, 0, 0);
        int yPosRightButton = (int)screenY(0, 0, 0);
        popMatrix();


        // do the same for the left button
        pushMatrix();
        translate(-32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosLeftButton = (int)screenX(0, 0, 0);
        int yPosLeftButton = (int)screenY(0, 0, 0);
        popMatrix();


        // all done!  time to clean up ...

        // reset to the default perspective
        perspective();

        // restore the 2D transformation matrix
        popMatrix();

        // ok, now we can use our xPos and yPos variables to grab the color value
        video.loadPixels();

        // right button
        int locationRight = xPosRightButton + yPosRightButton*video.width;

        // is this point on the screen?
        if (locationRight < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationRight]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            println("nothing here!");
            imageReadyToGoRight = true;
          } else if ( imageReadyToGoRight == true )
          {
            imageReadyToGoRight = false;
            println("something here!");  
            // increment image index by one each cycle
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look1.length;
          }
        }


        // left button
        int locationLeft = xPosLeftButton + yPosLeftButton*video.width;

        // is this point on the screen?
        if (locationLeft < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationLeft]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            println("nothing here!");
            imageReadyToGoLeft = true;
          } else if (imageReadyToGoLeft == true)
          {
            imageReadyToGoLeft = false;

            println("something here!");  
            // decrement image index by one each cycle ???
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look1.length;
          }
        }
      } else if (augmentedRealityMarkers.isExistMarker(5))
      {
        // set the AR perspective
        augmentedRealityMarkers.setARPerspective();

        // next, remember the current transformation matrix
        pushMatrix();

        // change the transformation matrix so that we are now drawing in 3D space on top of the marker
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(5));

        // flip the coordinate system around so that we can draw in a more intuititve way (if you don't do this
        // then the x & y axis will be flipped)
        scale(-1, -1);

        // we are now at 0,0,0 in the dead center of the marker
        // if we draw anything here it will be rotated and scaled accordingly
        // note that the marker is 80 x 80
        imageMode(CENTER);

        // display the item of clothing to the screen
        image(look2[imageIndex], 0, 0, 80, 80);

        // move to the bottom right side of the marker (right arrow button)
        pushMatrix();
        translate(32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosRightButton = (int)screenX(0, 0, 0);
        int yPosRightButton = (int)screenY(0, 0, 0);
        popMatrix();


        // do the same for the left button
        pushMatrix();
        translate(-32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosLeftButton = (int)screenX(0, 0, 0);
        int yPosLeftButton = (int)screenY(0, 0, 0);
        popMatrix();


        // all done!  time to clean up ...

        // reset to the default perspective
        perspective();

        // restore the 2D transformation matrix
        popMatrix();

        // ok, now we can use our xPos and yPos variables to grab the color value
        video.loadPixels();

        // right button
        int locationRight = xPosRightButton + yPosRightButton*video.width;

        // is this point on the screen?
        if (locationRight < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationRight]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoRight = true;
            println("nothing here!");
          } else if (imageReadyToGoRight == true)
          {
            imageReadyToGoRight = false;

            println("something here!");  
            // increment image index by one each cycle
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look2.length;
          }
        }


        // left button
        int locationLeft = xPosLeftButton + yPosLeftButton*video.width;

        // is this point on the screen?
        if (locationLeft < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationLeft]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoLeft = true;
            println("nothing here!");
          } else if (imageReadyToGoLeft == true)
          {
            imageReadyToGoLeft = false;

            println("something here!");  
            // decrement image index by one each cycle ???
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look2.length;
          }
        }
      } else if (augmentedRealityMarkers.isExistMarker(6))
      {
        // set the AR perspective
        augmentedRealityMarkers.setARPerspective();

        // next, remember the current transformation matrix
        pushMatrix();

        // change the transformation matrix so that we are now drawing in 3D space on top of the marker
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(6));

        // flip the coordinate system around so that we can draw in a more intuititve way (if you don't do this
        // then the x & y axis will be flipped)
        scale(-1, -1);

        // we are now at 0,0,0 in the dead center of the marker
        // if we draw anything here it will be rotated and scaled accordingly
        // note that the marker is 80 x 80
        imageMode(CENTER);

        // display the item of clothing to the screen
        image(look3[imageIndex], 0, 0, 80, 80);

        // move to the bottom right side of the marker (right arrow button)
        pushMatrix();
        translate(32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosRightButton = (int)screenX(0, 0, 0);
        int yPosRightButton = (int)screenY(0, 0, 0);
        popMatrix();


        // do the same for the left button
        pushMatrix();
        translate(-32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosLeftButton = (int)screenX(0, 0, 0);
        int yPosLeftButton = (int)screenY(0, 0, 0);
        popMatrix();


        // all done!  time to clean up ...

        // reset to the default perspective
        perspective();

        // restore the 2D transformation matrix
        popMatrix();

        // ok, now we can use our xPos and yPos variables to grab the color value
        video.loadPixels();

        // right button
        int locationRight = xPosRightButton + yPosRightButton*video.width;

        // is this point on the screen?
        if (locationRight < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationRight]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoRight = true;
            println("nothing here!");
          } else if (imageReadyToGoRight == true)
          {
            imageReadyToGoRight = false;

            println("something here!");  
            // increment image index by one each cycle
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look3.length;
          }
        }


        // left button
        int locationLeft = xPosLeftButton + yPosLeftButton*video.width;

        // is this point on the screen?
        if (locationLeft < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationLeft]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoLeft = true;
            println("nothing here!");
          } else if (imageReadyToGoLeft == true)
          {
            imageReadyToGoLeft = false;

            println("something here!");  
            // decrement image index by one each cycle ???
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look3.length;
          }
        }
      } else if (augmentedRealityMarkers.isExistMarker(7))
      {
        // set the AR perspective
        augmentedRealityMarkers.setARPerspective();

        // next, remember the current transformation matrix
        pushMatrix();

        // change the transformation matrix so that we are now drawing in 3D space on top of the marker
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(7));

        // flip the coordinate system around so that we can draw in a more intuititve way (if you don't do this
        // then the x & y axis will be flipped)
        scale(-1, -1);

        // we are now at 0,0,0 in the dead center of the marker
        // if we draw anything here it will be rotated and scaled accordingly
        // note that the marker is 80 x 80
        imageMode(CENTER);

        // display the item of clothing to the screen
        image(look4[imageIndex], 0, 0, 80, 80);

        // move to the bottom right side of the marker (right arrow button)
        pushMatrix();
        translate(32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosRightButton = (int)screenX(0, 0, 0);
        int yPosRightButton = (int)screenY(0, 0, 0);
        popMatrix();


        // do the same for the left button
        pushMatrix();
        translate(-32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosLeftButton = (int)screenX(0, 0, 0);
        int yPosLeftButton = (int)screenY(0, 0, 0);
        popMatrix();


        // all done!  time to clean up ...

        // reset to the default perspective
        perspective();

        // restore the 2D transformation matrix
        popMatrix();

        // ok, now we can use our xPos and yPos variables to grab the color value
        video.loadPixels();

        // right button
        int locationRight = xPosRightButton + yPosRightButton*video.width;

        // is this point on the screen?
        if (locationRight < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationRight]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoRight = true;
            println("nothing here!");
          } else if (imageReadyToGoRight == true)
          {
            imageReadyToGoRight = false;

            println("something here!");  
            // increment image index by one each cycle
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look4.length;
          }
        }


        // left button
        int locationLeft = xPosLeftButton + yPosLeftButton*video.width;

        // is this point on the screen?
        if (locationLeft < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationLeft]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoLeft = true;
            println("nothing here!");
          } else if (imageReadyToGoLeft == true)
          {
            imageReadyToGoLeft = false;

            println("something here!");  
            // decrement image index by one each cycle ???
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look4.length;
          }
        }
      } else if (augmentedRealityMarkers.isExistMarker(8))
      {
        // set the AR perspective
        augmentedRealityMarkers.setARPerspective();

        // next, remember the current transformation matrix
        pushMatrix();

        // change the transformation matrix so that we are now drawing in 3D space on top of the marker
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(8));

        // flip the coordinate system around so that we can draw in a more intuititve way (if you don't do this
        // then the x & y axis will be flipped)
        scale(-1, -1);

        // we are now at 0,0,0 in the dead center of the marker
        // if we draw anything here it will be rotated and scaled accordingly
        // note that the marker is 80 x 80
        imageMode(CENTER);

        // display the item of clothing to the screen
        image(look5[imageIndex], 0, 0, 80, 80);

        // move to the bottom right side of the marker (right arrow button)
        pushMatrix();
        translate(32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosRightButton = (int)screenX(0, 0, 0);
        int yPosRightButton = (int)screenY(0, 0, 0);
        popMatrix();


        // do the same for the left button
        pushMatrix();
        translate(-32, 78, 0);

        // draw a rectangle here
        rectMode(CENTER);
        //stroke(0, 255, 0);
        noStroke();
        strokeWeight(3);
        noFill();
        rect(0, 0, 10, 10);

        // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
        int xPosLeftButton = (int)screenX(0, 0, 0);
        int yPosLeftButton = (int)screenY(0, 0, 0);
        popMatrix();


        // all done!  time to clean up ...

        // reset to the default perspective
        perspective();

        // restore the 2D transformation matrix
        popMatrix();

        // ok, now we can use our xPos and yPos variables to grab the color value
        video.loadPixels();

        // right button
        int locationRight = xPosRightButton + yPosRightButton*video.width;

        // is this point on the screen?
        if (locationRight < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationRight]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoRight = true;
            println("nothing here!");
          } else if (imageReadyToGoRight == true)
          {
            imageReadyToGoRight = false;

            println("something here!");  
            // increment image index by one each cycle
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look5.length;
          }
        }


        // left button
        int locationLeft = xPosLeftButton + yPosLeftButton*video.width;

        // is this point on the screen?
        if (locationLeft < video.pixels.length)
        {
          color sampleColor = color(video.pixels[locationLeft]);

          // let's look at the color value in terms of how much red it has.
          // remember that black = 0,0,0
          // so if we see a high red value we can probably assume the color here is something
          // different than the high contrast black ink that is on the paper
          float redness = red(sampleColor);

          if (redness < 50)
          {
            imageReadyToGoLeft = true;
            println("nothing here!");
          } else if (imageReadyToGoLeft == true)
          {
            imageReadyToGoLeft = false;

            println("something here!");  
            // decrement image index by one each cycle ???
            // use modulo " % "to return to 0 once the end of the array is reached
            imageIndex = (imageIndex + 1) % look5.length;
          }
        }
      } else if (augmentedRealityMarkers.isExistMarker(9))
      {
        //
      }
    }
    catch (Exception e) {
      println("Issue with AR detection ... resuming regular operation ..");
      println(e.toString());
    }
  }
}




void makeColorButtons() {
  pushMatrix();
  translate(55, -25, 0);
  ellipseMode(CENTER);
  // stroke(255, 0, 0);
  // strokeWeight(3);
  // noFill();
  //  ellipse(0, 0, 15, 15);
  // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
  int xPosTopColor = (int)screenX(0, 0, 0);
  int yPosTopColor = (int)screenY(0, 0, 0);
  popMatrix();
  // do the same for the left button
  //  translate(100, 0, 0);
  pushMatrix();
  // draw a rectangle here
  translate(55, 25, 0);
  ellipseMode(CENTER);
  // stroke(255, 0, 0);
  //  strokeWeight(3);
  //  noFill();
  // ellipse(0, 0, 15, 15);
  // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
  int xPosBottomColor = (int)screenX(0, 0, 0);
  int yPosBottomColor = (int)screenY(0, 0, 0);
  popMatrix();
  checkForTouch(xPosTopColor, yPosTopColor, xPosBottomColor, yPosBottomColor);
}

void makeArrowButtons(int numberToShow) {
  pushMatrix();
  translate(32, 78, 0);
  int noItems = numberToShow;
  // draw a rectangle here
  rectMode(CENTER);
  // stroke(0, 255, 0);
  // strokeWeight(3);
  //  noFill();
  // rect(0, 0, 10, 10);

  // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
  int xPosRightButton = (int)screenX(0, 0, 0);
  int yPosRightButton = (int)screenY(0, 0, 0);
  popMatrix();

  pushMatrix();

  // do the same for the left button
  translate(-32, 78, 0);

  // draw a rectangle here
  rectMode(CENTER);
  //  stroke(0, 255, 0);
  //  strokeWeight(3);
  noFill();
  //  rect(0, 0, 10, 10);
  // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
  int xPosLeftButton = (int)screenX(0, 0, 0);
  int yPosLeftButton = (int)screenY(0, 0, 0);
  popMatrix();
  makeColorButtons();
  checkForTouch(xPosLeftButton, yPosLeftButton, xPosRightButton, yPosRightButton, noItems);
}

void checkForTouch(int xPosLeftButton, int yPosLeftButton, int xPosRightButton, int yPosRightButton, int noItems) {
  video.loadPixels();
  int locationRight = xPosRightButton + yPosRightButton*video.width;
  if (locationRight < video.pixels.length)
  {
    color sampleColor = color(video.pixels[locationRight]);
    float redness = red(sampleColor);

    if (redness < 50)
    {
      println("nothing here!");
    } else
    {
      println("something here!");  
      if (whichToShow == noItems) {
        whichToShow = 1;
      } else {
        whichToShow++;
      }
    }
  }
  int locationLeft = xPosLeftButton + yPosLeftButton*video.width;
  if (locationLeft < video.pixels.length)
  {
    color sampleColor = color(video.pixels[locationLeft]);
    float redness = red(sampleColor);

    if (redness < 50)
    {
      println("nothing here!");
    } else {
      println("something here!");  
      if (whichToShow == 1) {
        whichToShow = noItems;
      } else {
        whichToShow--;
      }
    }
  }
}
void checkForTouch(int xPosTopColor, int yPosTopColor, int xPosBottomColor, int yPosBottomColor) {
  perspective();
  popMatrix();
  int locationTop = xPosTopColor + yPosTopColor*video.width;
  if (locationTop < video.pixels.length)
  {
    color sampleColor = color(video.pixels[locationTop]);
    float redness = red(sampleColor);

    if (redness < 50)
    {
      println("nothing here!");
    } else
    { 
      color1Detected = true;
      color2Detected = false;
    }
  }
  int locationBottom = xPosBottomColor + yPosBottomColor*video.width;
  if (locationBottom < video.pixels.length)
  {
    color sampleColor = color(video.pixels[locationBottom]);
    float redness = red(sampleColor);

    if (redness < 50)
    {
      println("nothing here!");
    } else 
    {
      color2Detected = true;
      color1Detected = false;
    }
  }
}
void displayText(String t) {
  pushMatrix();
  translate(10, 10, 10);
  fill(0, 225, 0);
  textSize(20);
  text(t, 20, 20);
  popMatrix();
}

