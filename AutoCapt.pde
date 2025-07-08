import processing.video.*;

Capture cam;
PFont font;

float intvTime = 1.f; // minutes
int lastTime;

int counter = 1;
boolean recording = false;

void setup() {
  size(640, 480);
  
  font = createFont("whitrabt.ttf", 20);
  
  String[] cams = Capture.list();
  println(cams.length);
  if(cams.length == 0) {
    println("No cam installed");
    exit();
  } else {
    for(int i = 0; i < cams.length; i++) {
      println(i + "\t" + cams[i]);
    }
  }
  
  //cam = new Capture(this, 640, 480);
  cam = new Capture(this, cams[2]);
  cam.start();
  println(cam.width + ", " + cam.height);
  lastTime = millis();
}

void draw() {  
 if(cam.available()) {
   cam.read();
 }
 
 image(cam, 0, 0);
 fill(0, 180);
 rect(0, height - 40, width, 40);
 textFont(font);
 
 if(recording) {
   if(millis() - lastTime >= intvTime * 60000) {
     lastTime = millis();
     String frName = nf(counter, 5);
     counter++;
     saveFrame("frames/" + frName +".jpg");
   }
   
   fill(#FF0000);
   textSize(20);
   text("Rec.", width - 75, height - 15); 
 }
 
 fill(255);
 textSize(15);
 text("Interval", 10, height - 15);
 text("minutes", 130, height - 15);
 if(!recording) {
   fill(#00FF00);
 }
 text(str(intvTime), 85, height - 15);
}

void keyPressed() {
  if(!recording) {
    if(keyCode == UP && intvTime < 60) {
      intvTime += 0.5f;
    } else if(keyCode == DOWN && intvTime > 0.5f) {
      intvTime -= 0.5f;
    } else if(key == 32) {
      recording = true;
    }
  } else {
    if(key == 32) {
      recording = false;
    }
  }
}
