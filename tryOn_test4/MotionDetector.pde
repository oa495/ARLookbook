// note - this is a self-contained class that handles pulling
// in new frames of video as well as detecting motion at any
// position on the screen.  feel free to use it in your own projects
// as-is or modify it as necessary
class MotionDetector
{
  // video object (supplied by main program)
  Capture video;

  // previous frame
  PImage previousFrame;

  // "debug" mode
  boolean debug = false;

  // "debug" image - used to display green pixels that show motion
  PImage debugFrame;

  // "debug" color
  color debugColor;

  // mirror mode
  boolean mirror = false;

  // how tolerante should we be?  0.15 means 15% of the pixels
  // need to change before we should qualify a hit
  // higher numbers are less tolerante
  // float tolerance = 0.15;
  float tolerance = 0.15;
  // mirrored frame
  PImage mirroredFrame;

  // constructor
  MotionDetector(Capture video, boolean mirror, boolean debugMode, float tolerance)
  {
    // store the video object form the main program
    this.video = video;

    // store our mirror preferences
    this.mirror = mirror;
    this.mirroredFrame = new PImage(video.width, video.height, ARGB);

    // set up our previousFrame image to be the same size as the video
    this.previousFrame = new PImage(video.width, video.height, ARGB);

    // store tolerance value
    this.tolerance = tolerance;

    // store our debug mode
    this.debug = debugMode;

    if (this.debug)
    {
      // set up our "debug" frame to show green pixels to indicate motion (if we want to see them)
      this.debugFrame = new PImage(video.width, video.height, ARGB);

      // set up debug color
      this.debugColor = color(0, 255, 0);
    }
  }


  // our "run" method - this method gets called in draw every
  // frame and reads in new video frames as needed. it also updates
  // the previous frame image as necessary
  void run()
  {
    if (video.available())
    {
      // copy the current frame of video into the previous frame
      previousFrame.copy(mirroredFrame, 0, 0, mirroredFrame.width, mirroredFrame.height, 0, 0, mirroredFrame.width, mirroredFrame.height);

      // read in the new frame of video      
      video.read();

      // do we need to mirror the video?
      if (mirror)
      {
        mirrorImage(video);
      } else
      {
        mirroredFrame = video;
      }

      // clear the debug frame, if necessary
      if (debug)
      {
        debugFrame = new PImage(video.width, video.height, ARGB);
      }
    }
  }


  // display video to the screen
  void displayVideo()
  {
    image(mirroredFrame, 0, 0);

    if (debug)
    {
      image(debugFrame, 0, 0);
    }
  }  
  


  // check a position on the screen for motion
  boolean checkForMotion(float x1, float y1, float w, float h)
  {
    // first make sure that the region we are looking at actually exists in the video
    // this prevents us from looking at pixels beyond the edge of the current frame
    int startX = int(constrain(x1, 0, mirroredFrame.width));
    int startY = int(constrain(y1, 0, mirroredFrame.height));
    int endX = int(constrain(x1+w, 0, mirroredFrame.width));
    int endY = int(constrain(y1+h, 0, mirroredFrame.height));

    // now let's analyze the video in this region
    int numChanged = 0;
    int numPixels = 0;
    mirroredFrame.loadPixels();
    previousFrame.loadPixels();

    // load debug pixels, if necessary
    if (debug)
    {
      debugFrame.loadPixels();
    }

    for (int x = startX; x < endX; x++) {

      for (int y = startY; y < endY; y++) {

        // get a 1D location
        int location = x + y*mirroredFrame.width;

        // grab color here    
        float vR = red(mirroredFrame.pixels[location]);
        float vG = green(mirroredFrame.pixels[location]);
        float vB = blue(mirroredFrame.pixels[location]);
        float pR = red(previousFrame.pixels[location]);
        float pG = green(previousFrame.pixels[location]);
        float pB = blue(previousFrame.pixels[location]);

        // is there a difference?
        if (dist(vR, vG, vB, pR, pB, pG) > 50) {
          numChanged++;

          // visually indicate the change, if necesary
          if (debug)
          {
            debugFrame.pixels[location] = debugColor;
          }
        } else
        {
          // indicate nothing special here (just use the video's pixel
          if (debug)
          {
            debugFrame.pixels[location] = mirroredFrame.pixels[location];
          }
        }

        // always keep track that we visited this pixel
        numPixels++;
      }
    }

    // update pixels, if necessary
    if (debug)
    {
      debugFrame.updatePixels();
    }

    // see if we have met our tolerance rate
    if (numChanged/float(numPixels) > tolerance)
    {
      return true;
    } else
    {
      return false;
    }
  }





  // generic mirror image function
  void mirrorImage(PImage imageToMirror)
  {
    int swap = 0;
    imageToMirror.loadPixels();
    mirroredFrame.loadPixels();
    for (int x = 0; x < imageToMirror.width/2; x++)
    {
      // compute opposite x position
      int oppositeX = imageToMirror.width-x-1;

      for (int y = 0; y < imageToMirror.height; y++)
      {
        // determine our location
        int location1 = x         + y*imageToMirror.width;
        int location2 = oppositeX + y*imageToMirror.width;

        // swap!
        mirroredFrame.pixels[location1] = imageToMirror.pixels[location2];
        mirroredFrame.pixels[location2] = imageToMirror.pixels[location1];
      }
    }
    mirroredFrame.updatePixels();
  }
}

