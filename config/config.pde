/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/

 KinectPV2, Kinect for Windows v2 library for processing

 Skeleton color map example.
 Skeleton (x,y) positions are mapped to match the color Frame
 */

import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;
PrintWriter writer;

final int WINDOW_WIDTH = displayWidth / 2;
final int WINDOW_HEIGHT = displayHeight / 2;
int configPhase = 0;

int minWidth, maxWidth, minHeight, maxHeight;


void settings() {
  size(displayWidth / 2, displayHeight / 2, P3D);
}

void setup() {

  writer = createWriter("config.txt");
  
  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
  
  
}

void draw() {
  
  if (configPhase == 0) {
  
  background(0);

  image(kinect.getColorImage(), 0, 0, width, height);
  
  fill(0, 0, 0, 200);
  rectMode(CORNER);
  noStroke();
  rect(0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
    }
  }

  fill(255, 0, 0);
  text(frameRate, 50, 50);
  
  fill(255, 255, 255);
  textSize(width / 50);
  text("Click the button below to begin configuring KinectMouse", width / 2 * 0.55, height / 3 * 1.4);
  fill(0, 102, 255);
  stroke(255, 255, 255);
  strokeWeight(4);
  rectMode(CORNERS);
  rect(width / 2 * 0.9, height / 2 * 0.95 + height/50, width / 2 * 1.1, height / 2 * 1.05 + height/50);
  fill(255, 255, 255);
  text("Start", width/2 * 0.96, height/2 * 1.06);
}

  else if (configPhase == 1) {    // setovanje granica za pracenje
  background(0);

  image(kinect.getColorImage(), 0, 0, width, height);
  
  fill(0, 0, 0, 200);
  rectMode(CORNER);
  noStroke();
  rect(0, 0, width, height);
  

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);
      
      fill(255, 255, 255, 200);
      int leftX = (int)joints[KinectPV2.JointType_HandLeft].getX();
      int leftY = (int)joints[KinectPV2.JointType_HandLeft].getY();
      int rightX = (int)joints[KinectPV2.JointType_HandRight].getX();
      int rightY = (int)joints[KinectPV2.JointType_HandRight].getY();
      leftX = (int)map(leftX, 0, 1920, 0, width);
      leftY = (int)map(leftY, 0, 1920, 0, width);
      rightX = (int)map(rightX, 0, 1080, 0, height);
      rightY = (int)map(rightY, 0, 1080, 0, height);
      
      rectMode(CORNERS);
      noStroke();
      rect(leftX, leftY, rightX, rightY);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
      setTrackingLimits(joints[KinectPV2.JointType_HandLeft], joints[KinectPV2.JointType_HandRight]);
    }
  }
  
  
  

  fill(255, 0, 0);
  text(frameRate, 50, 50);
  }
  
  
  else if (configPhase == 2) {  // gotov setup, zapisivanje u fajl i izlaz
    
    println("writing . . .");
    try {
      writer.println("MIN_TRACKING_WIDTH: " + minWidth);
      writer.println("MIN_TRACKING_WIDTH: " + maxWidth);
      writer.println("MIN_TRACKING_HEIGHT: " + minHeight);
      writer.println("MIN_TRACKING_HEIGHT: " + maxHeight);
      writer.flush();
      writer.close();
      println("finished !");
      exit();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
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

void setTrackingLimits(KJoint left, KJoint right) {
  if (left.getState() == KinectPV2.HandState_Closed && right.getState() == KinectPV2.HandState_Closed) {
      //minWidth, maxWidth, minHeight, maxHeight;
      
      int leftX = (int)left.getX();
      int leftY = (int)left.getY();
      int rightX = (int)right.getX();
      int rightY = (int)right.getY();
      minWidth = leftX <= rightX ? leftX : rightX;
      maxWidth = leftX > rightX ? leftX : rightX;
      minHeight = leftY <= rightY ? leftY : rightY;
      maxHeight = leftY > rightY ? leftY : rightY;
      println(minWidth + " " + maxWidth + " " + minHeight + " " + maxHeight);
      configPhase = 2;
  }
}

void mousePressed() {
  // Kliknuto dugme za pocetak setup-a
  // koord. dugmeta: width / 2 * 0.9, height / 2 * 0.95 + height/50, width / 2 * 1.1, height / 2 * 1.05 + height/50
  if (configPhase == 0 && mouseX >= width / 2 * 0.9 && mouseX <=  width / 2 * 1.1 && mouseY >= height / 2 * 0.95 + height/50 && mouseY <= height / 2 * 1.05 + height/50) {
    configPhase = 1;  // pocet setup
  }
}
