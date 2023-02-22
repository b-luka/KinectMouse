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

//public class InputHandler {
  public native void toggleOSK();
  public native void leftClickUp();
  public native void leftClickDown();
  public native void rightClickUp();
  public native void rightClickDown();
  public native void middleClickUp();
  public native void middleClickDown();
  
  
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
LStateController leftHandController;
RStateController rightHandController;

final float MIN_SCREEN_WIDTH = 0;
final float MAX_SCREEN_WIDTH = displayWidth;
final float MIN_SCREEN_HEIGHT = 0;
final float MAX_SCREEN_HEIGHT = displayHeight;

final float SKETCH_WIDTH = displayWidth / 4;
final float SKETCH_HEIGHT = displayHeight / 4;

float MIN_MAP_WIDTH = 400;    // TODO: citanje iz fajla, poseban sketch za konfiguraciju i kalibraciju
float MAX_MAP_WIDTH = 1520;
float MIN_MAP_HEIGHT = 200;
float MAX_MAP_HEIGHT = 480;


final float MAX_MOUSE_DISTANCE = 50;

void setup() {
  size(800, 600, P3D);

  kinect = new KinectPV2(this);
  
  leftHandController = new LStateController();
  rightHandController = new RStateController();
  
 
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
}

void draw() {
  background(0);

  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      //  drawBody(joints);
      
      //draw different color for each hand state
      //  drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
      printXY(joints, KinectPV2.JointType_HandLeft);
      moveMouse(joints);
      pressKeys(joints[KinectPV2.JointType_HandLeft], joints[KinectPV2.JointType_HandRight]);
      
      
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
    float xpos = joints[KinectPV2.JointType_HandLeft].getX();
    float ypos = joints[KinectPV2.JointType_HandLeft].getY();
    
    //ypos += 270;
    
    //xpos = map(xpos, 240, 1680, 0, 2560);
    //ypos = map(ypos, 240, 840, 0, 1440);
    
    /*    // TODO: mis se zaglavi u (0, 0)
    xpos = map(xpos, MIN_MAP_WIDTH, MAX_MAP_WIDTH, MIN_SCREEN_WIDTH, MAX_SCREEN_WIDTH);    // mapiranje koordinata kamere
    ypos = map(ypos, MIN_MAP_HEIGHT, MAX_MAP_HEIGHT, MIN_SCREEN_HEIGHT, MAX_SCREEN_HEIGHT);// (1080p slika) na ekran promenljive rezolucije
    
    
    
    if (xpos > MAX_SCREEN_WIDTH) xpos = MAX_SCREEN_WIDTH;    // odrzavanje u granicama ekrana
    if (xpos < MIN_SCREEN_WIDTH) xpos = MIN_SCREEN_WIDTH;
    if (ypos > MAX_SCREEN_HEIGHT) ypos = MAX_SCREEN_HEIGHT;
    if (ypos < MIN_SCREEN_HEIGHT) ypos = MIN_SCREEN_HEIGHT;
    */
    
    xpos = map(xpos, 240, 1680, 0, 2560);
    ypos = map(ypos, 240, 840, 0, 1440);
    
    if (xpos > 2560) xpos = 2560;
    if (xpos < 0) xpos = 0;
    if (ypos > 1440) ypos = 1440;
    if (ypos < 0) ypos = 0;
  
    float mouseDistance = sqrt(((xpos - lastXPos) * (xpos - lastXPos)) + ((ypos - lastYPos) * (ypos * lastYPos)));
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

void pressKeys(KJoint left, KJoint right) {

  try {
    Robot robot = new Robot();
    int leftHandState = left.getState();
    int rightHandState = right.getState();
    
    /*
    if (leftHandState == KinectPV2.HandState_Closed) {
      toggleOSK();
    }
    */
    
    switch (leftHandState) {            // proverava stanje ruke i u odnosu na dato stanje
      case KinectPV2.HandState_Open:    // i poziva funkciju, prelaz stanja i poziv funkcija misa iz C++ - a
        leftHandController.open();
        break;
      
      case KinectPV2.HandState_Closed:
        leftHandController.closed();
        break;
        
      case KinectPV2.HandState_Lasso:
        leftHandController.lasso();
        break;
    }
    
    switch (rightHandState) {
      case KinectPV2.HandState_Open:
        rightHandController.open();
        break;
      
      case KinectPV2.HandState_Closed:
        rightHandController.closed();
        break;
        
      case KinectPV2.HandState_Lasso:
        rightHandController.lasso();
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
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
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
    throw new Exception("Shutting down . . .");
    
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
}
