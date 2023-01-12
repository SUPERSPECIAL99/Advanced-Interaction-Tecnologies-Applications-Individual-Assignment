 //<>//
import TUIO.*;
// declare a TuioProcessing client
TuioProcessing tuioClient;

// these are some helper variables which are used
// to create scalable graphical feedback

float scale_factor = 1;
PFont font;
PImage img;

int imageWidth, imageHeigth;
float zoom = 100;
float red= 255;
float blue= 0;
float green= 0;


float bright;

boolean loadimage= false;

boolean verbose = true; // print console debug messages
boolean callback = true; // updates only after callbacks

void setup()
{
  // GUI setup
  //noCursor();
  size(640, 480);
  //noStroke();
  //fill(0);
  img = loadImage("SHARK.jpg");
  
  imageWidth = img.width;
  imageHeigth = img.height;

  // periodic updates
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); // or callback updates 

  font = createFont("Arial", 18);



  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  background(255);
  textFont(font, 18*scale_factor);



  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);
    if (tobj.getSymbolID()==0)
    
    {
      translate (tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      image(img, 0, 0, imageWidth, imageHeigth);
    }
    
    if (tobj.getSymbolID()==2)
    {
      translate (tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      image(img, 0, 0, 180, 180);
    }
        if (loadimage)
        if (tobj.getSymbolID()==1)
    {
     zoom = constrain(zoom+tobj.getRotationSpeed()*3,10 ,300);
     imageWidth= int(img.width*zoom/100);
     imageHeigth= int(img.height*zoom/100);

    }
    if (loadimage)
        if (tobj.getSymbolID()==4)
    {
     red = constrain(red+tobj.getRotationAccel(), 0 ,255);
           tint (red, 255, 255); 

     

    }
     if (loadimage)
        if (tobj.getSymbolID()==3)
    {
     bright = constrain(bright+tobj.getRotationAccel(), 0 ,255);
           tint (red, green , blue); 
      red *= bright;
      green *= bright;
      blue *= bright;

      // The RGB values are constrained between 0 and 255 before being set as a new color.      
      //red = constrain(red, 0, 255); 
      //green = constrain(green, 0, 255);
      //blue = constrain(blue, 0, 255);
       color c = color(red, green, blue);
       bright= c;


     

    }
    
    
    
    
  }
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
   if (tobj.getSymbolID()==0)
    loadimage= true;
    if (tobj.getSymbolID()==1)
    loadimage= true;
    
    
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
  if (loadimage){
     if (tobj.getSymbolID()==3)
    {
     red = 255;
           tint (red, 255, 255); 

     

    }
    if (tobj.getSymbolID()==4)
    {
     bright = 255;
           tint (255, 255, 255); 

     

    }
    
  }
  
    
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
