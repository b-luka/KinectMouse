/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/

 KinectPV2, Kinect for Windows v2 library for processing
xpos = lastXPos + (abs(lastXpos - xpos) * ratioOfSimilarity * xDir);
 Skeleton color map example.
 Skeleton (x,y) positions are mapped to match the color Frame
 */
 
 
import java.awt.*;
import java.awt.event.InputEvent;
import KinectPV2.KJoint;
import KinectPV2.*;
import java.io.*;

//public class InputHandler {
  public native void toggleOSK();
  public native void leftClickUp();
  public native void leftClickDown();
  public native void rightClickUp();
  public native void rightClickDown();
  public native void middleClickUp();
  public native void middleClickDown();
  public native void scrollUp();
  public native void scrollDown();
  
  
//}

static
  {
    try {
    System.loadLibrary("InputHandler");
    } catch(Exception e) {
      e.printStackTrace();
    } finally {
      println("Uspelo");
    }
  }


KinectPV2 kinect;


float lastXPos = 0;
float lastYPos = 0;
DStateController dominantHand;
NStateController nondominantHand;

final float MIN_SCREEN_WIDTH = 0;
final float MAX_SCREEN_WIDTH = displayWidth;
final float MIN_SCREEN_HEIGHT = 0;
final float MAX_SCREEN_HEIGHT = displayHeight;

final float SKETCH_WIDTH = displayWidth / 4;
final float SKETCH_HEIGHT = displayHeight / 4;

int MAX_WIDTH = 2560;
int MAX_HEIGHT = 1440;

int DOMINANT_HAND = KinectPV2.JointType_HandLeft;
int NONDOMINANT_HAND = KinectPV2.JointType_HandRight;

int MIN_MAP_WIDTH = 400;    // TODO: citanje iz fajla, poseban sketch za konfiguraciju i kalibraciju
int MAX_MAP_WIDTH = 1520;
int MIN_MAP_HEIGHT = 200;
int MAX_MAP_HEIGHT = 480;

String configPath;


//final float MAX_MOUSE_DISTANCE = 50;

float lastXPosR = 0;
float lastYPosR = 0;
float currentXPosR = 0;
float currentYPosR = 0;

void settings() {
  MAX_WIDTH = displayWidth;
  MAX_HEIGHT = displayHeight;
  size(displayWidth / 2, displayHeight / 2, P3D);
}

void setup() {
  kinect = new KinectPV2(this);
  
  dominantHand = new DStateController();
  nondominantHand = new NStateController();
  
 
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  
  
  //String[] lines = loadStrings("C:\\Users\\lukao\\github\\kinectMouse\\config.txt");
  
  /*File file = new File("InputHandler.pde");
  println(file.getAbsolutePath());
  testSt =file.getAbsolutePath();*/
  configPath = sketchPath() + "\\config.txt";
  String[] lines = loadStrings(configPath);
  
  DOMINANT_HAND = Integer.valueOf(lines[0].split(": ")[1]);
  NONDOMINANT_HAND = Integer.valueOf(lines[1].split(": ")[1]);
  MIN_MAP_WIDTH = Integer.valueOf(lines[2].split(": ")[1]);
  MAX_MAP_WIDTH = Integer.valueOf(lines[3].split(": ")[1]);
  MIN_MAP_HEIGHT = Integer.valueOf(lines[4].split(": ")[1]);
  MAX_MAP_HEIGHT = Integer.valueOf(lines[5].split(": ")[1]);
  
       
  for(String line : lines) {
    println(line);
  }
  

  println(MIN_MAP_WIDTH);
  println(MAX_MAP_WIDTH);
  println(MIN_MAP_HEIGHT);
  println(MAX_MAP_HEIGHT);
  println(DOMINANT_HAND);
  println(NONDOMINANT_HAND);

  kinect.init();
}

void draw() {
  background(0);

  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray = kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      drawBody(joints);
      
      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
      //printXY(joints, KinectPV2.JointType_HandLeft);
      moveMouse(joints);
      pressKeys(joints[DOMINANT_HAND], joints[NONDOMINANT_HAND]);
      
      currentXPosR = joints[NONDOMINANT_HAND].getX();
      currentYPosR = joints[DOMINANT_HAND].getY();
      nondominantHand.mouseScroll();
    }
  }
  
  

  fill(255, 0, 0);
  text(frameRate, 50, 50);
  
  
}


// Print the X & Y positions next of a particular joint
    void printXY(KJoint[] joints, int jointType) { 
      float xpos = joints[jointType].getX();
      float ypos = joints[jointType].getY();
      textSize(20);
      fill(0, 255, 0);
      text("X = " + xpos, xpos+50, ypos);
      text("Y = " + ypos, xpos+50, ypos+50);
    } 

// Print the X & Y positions of all the skeleton, next to each joint
    void printSkeleton(KJoint[] joints) { 
      for(int i = 0; i <= 25; i++) {
        printXY(joints, i);
      } 
    }

void moveMouse(KJoint[] joints) {
  try {
    Robot robot = new Robot();
    float xpos = joints[DOMINANT_HAND].getX();
    float ypos = joints[DOMINANT_HAND].getY();
    
    //ypos += 270;
    
    //xpos = map(xpos, 240, 1680, 0, 2560);
    //ypos = map(ypos, 240, 840, 0, 1440);
    
        // TODO: mis se zaglavi u (0, 0)
    xpos = map(joints[DOMINANT_HAND].getX(), MIN_MAP_WIDTH, MAX_MAP_WIDTH, 0, MAX_WIDTH);    // mapiranje koordinata kamere
    ypos = map(joints[DOMINANT_HAND].getY(), MIN_MAP_HEIGHT, MAX_MAP_HEIGHT, 0, MAX_HEIGHT);// (1080p slika) na ekran promenljive rezolucije
    
    
    /*
    if (xpos > MAX_SCREEN_WIDTH) xpos = MAX_SCREEN_WIDTH;    // odrzavanje u granicama ekrana
    if (xpos < MIN_SCREEN_WIDTH) xpos = MIN_SCREEN_WIDTH;
    if (ypos > MAX_SCREEN_HEIGHT) ypos = MAX_SCREEN_HEIGHT;
    if (ypos < MIN_SCREEN_HEIGHT) ypos = MIN_SCREEN_HEIGHT;
    */
    
    
    /*
    xpos = map(xpos, 240, 1680, 0, 2560);
    ypos = map(ypos, 240, 840, 0, 1440);
    
    if (xpos > 2560) xpos = 2560;
    if (xpos < 0) xpos = 0;
    if (ypos > 1440) ypos = 1440;
    if (ypos < 0) ypos = 0;
    */
  
    //float mouseDistance = sqrt(((xpos - lastXPos) * (xpos - lastXPos)) + ((ypos - lastYPos) * (ypos * lastYPos)));
    /*
    if (mouseDistance > MAX_MOUSE_DISTANCE) {
      float ratioOfSimilarity = MAX_MOUSE_DISTANCE / mouseDistance;
      
      float xDir = xpos > lastXPos ? 1 : -1;
      float yDir = ypos > lastYPos ? 1 : -1;
      
      xpos = lastXPos + (abs(lastXPos - xpos) * ratioOfSimilarity * xDir);
      ypos = lastYPos + (abs(lastYPos - ypos) * ratioOfSimilarity * yDir);
    }*/
    
    lastXPos = xpos;
    lastYPos = ypos;
    
    robot.mouseMove((int)xpos, (int)ypos);
    
    
  } catch (Exception e) {
    e.printStackTrace();
  }
}

void pressKeys(KJoint dom, KJoint non) {

  try {
    Robot robot = new Robot();
    int domHandState = dom.getState();
    int nonHandState = non.getState();
    
    /*
    if (leftHandState == KinectPV2.HandState_Closed) {
      toggleOSK();
    }
    */
    
    switch (domHandState) {            // proverava stanje ruke i u odnosu na dato stanje
      case KinectPV2.HandState_Open:    // i poziva funkciju, prelaz stanja i poziv funkcija misa iz C++ - a
        dominantHand.open();
        break;
      
      case KinectPV2.HandState_Closed:
        dominantHand.closed();
        break;
        
      case KinectPV2.HandState_Lasso:
        dominantHand.lasso();
        break;
    }
    
    switch (nonHandState) {
      case KinectPV2.HandState_Open:
        nondominantHand.open();
        break;
      
      case KinectPV2.HandState_Closed:
        nondominantHand.closed();
        break;
        
      case KinectPV2.HandState_Lasso:
        nondominantHand.lasso();
        break;
    }
    
    /*
    if (leftHandState == KinectPV2.HandState_Open) {
      leftHandController.open();
    }
    
    else if (leftHandState == KinectPV2.HandState_Closed) {
      leftHandController.closed();
    } 
    
    else if (leftHandState == KinectPV2.HandState_Lasso) {
      leftHandController.lasso();
    }
    */
    
    
    
    /*
    if (leftHandState == KinectPV2.HandState_Open && rightHandState == KinectPV2.HandState_Open) {
      robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
        
    }
    else if (leftHandState == KinectPV2.HandState_Closed && rightHandState == KinectPV2.HandState_Open) {
      robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
    }
    else if (leftHandState == KinectPV2.HandState_Open && rightHandState == KinectPV2.HandState_Closed) {
        
      robot.mousePress(InputEvent.BUTTON3_DOWN_MASK);
      robot.mouseRelease(InputEvent.BUTTON3_DOWN_MASK);
    }*/
  } catch (Exception e) {
    e.printStackTrace();
  }
  
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(map(joints[jointType].getX(), 0, 1920, 0, width), map(joints[jointType].getY(), 0, 1080, 0, height), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(map(joints[jointType1].getX(), 0, 1920, 0, width), map(joints[jointType1].getY(), 0, 1080, 0, height), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(map(joints[jointType1].getX(), 0, 1920, 0, width), map(joints[jointType1].getY(), 0, 1080, 0, height)/*, joints[jointType1].getZ()*/, map(joints[jointType2].getX(), 0, 1920, 0, width), map(joints[jointType2].getY(), 0, 1080, 0, height)/*, joints[jointType2].getZ()*/);
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(map(joint.getX(), 0, 1920, 0, width), map(joint.getY(), 0, 1080, 0, height), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}

void keyPressed() {
  try {
  if (key == ' ') {
    System.exit(0);
    
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
}
