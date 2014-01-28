//GLOBAL
RomanescoTwo romanescoTwo ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoTwo just bellow
/*
ArrayList<YourClass> yourList ;
*/





//SETUP
void romanescoTwoSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 2 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwo = new RomanescoTwo (ID, IDfamilly) ;

  romanescoTwo.setting() ;
}

//DRAW
void romanescoTwoDraw(String [] dataControleur, String [] dataMinim) {
  romanescoTwo.getID() ;
  romanescoTwo.data(dataControleur, dataMinim) ;
  romanescoTwo.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwo() { return romanescoTwo.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwo extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  // class
  CreatureManager creatureManager ;
  boolean useBackdrop = false;
  
  
  
  // END YOUR VARIABLE OBJECT
  ///////////////////////////
  
  
  //CONSTRUCTOR
  RomanescoTwo(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    //class
    creatureManager = new CreatureManager(callingClass);
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    //font
    font[IDobj] = font[0] ;
    //motion
    motion[IDobj] = true ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {
    //starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    
    //DISPLAY OBJECT
    ///////////////
    //DON'T TOUCH
    miroir.pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    
    //color 
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //thickness
    float thickness = valueObj[IDobj][13] *.1 ;
    
    
    creatureManager.loop(colorIn, colorOut, thickness);
     //CHANGE MODE DISPLAY
    /////////////////////
    int whichCreature ; 
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) whichCreature = 8 ; // default is Manta object for the Miroir, because the object with Pmatrix don't work
    else if (modeButton[IDobj] == 1 ) whichCreature = 1 ;
    else if (modeButton[IDobj] == 2 ) whichCreature = 8 ; // default is Manta object for the Miroir, because the object with Pmatrix don't work
    else if (modeButton[IDobj] == 3 ) whichCreature = 3 ;
    else if (modeButton[IDobj] == 4 ) whichCreature = 4 ;
    else if (modeButton[IDobj] == 5 ) whichCreature = 5 ;
    else if (modeButton[IDobj] == 6 ) whichCreature = 6 ;
    else if (modeButton[IDobj] == 7 ) whichCreature = 7 ;
    else if (modeButton[IDobj] == 8 ) whichCreature = 8 ;
    else if (modeButton[IDobj] == 9 ) whichCreature = 9 ;
    else if (modeButton[IDobj] == 10 ) whichCreature = 10 ;
    else if (modeButton[IDobj] == 11 ) whichCreature = 11 ;
    else if (modeButton[IDobj] == 12 ) whichCreature = 12 ;
    else whichCreature = 8 ; // default is Manta object for the Miroir, because the object with Pmatrix don't work
    
    //DON'T TOUCH
    miroir.popMatrix() ;
    //END OF DON'T TOUCH
    //END of MODE DISPLAY
    /////////////////////
    
    
    ////////////////////////////////////////////////
    //add object from keyboard, press "N" for new one
    if(actionButton[IDobj] == 1 ) {
      //if (spaceTouch && frameCount % 4 == 0) creatureManager.addCurrentCreature();
      // if ( nLongTouch && frameCount % 3 == 0) creatureManager.addSpecificCreature(whichCreature);
      if ( nLongTouch && frameCount % 3 == 0) creatureManager.addCurrentCreature(whichCreature);
      // if ( nLongTouch && frameCount % 3 == 0) creatureManager.addCurrentCreature();
      //to cennect the creature to the camera
      if(cLongTouch) {
        if (upTouch )    creatureManager.nextCameraCreature();
        else if (downTouch )  creatureManager.prevCameraCreature();
      }
    }
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) creatureManager.killAll(whichCreature);


    //IT'S THE END FOR YOU
    //////////////////////
    
    
    
    

  }
  //END DRAW

  
  
  //ANNEXE VOID
  void annexe() {}
  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControler, String [] dataMinin) {
    super.data(dataControler, dataMinin) ;
  }
  ////////////
  //Return ID
  int getID() {
    return IDobj ;
  }
  int getIDfamilly() {
    return IDfamilly ;
  }
  ///////////////////////////
  //////////////////////////
}





//CREATURE MANAGER
/**
 * The core class.
 * Takes care of instantiating creatures and makes them live and die.
 */

import java.util.Iterator;
import java.lang.reflect.*; 

class CreatureManager {
  private ArrayList<SuperCreature>creatures;
  private ArrayList<Class>creatureClasses;

  int currentCameraCreature =-1;
  PVector releasePoint;

  SuperCreature previewCreature;  
  PApplet parent;
  String infoText;

  int currentCreature = 5; // the breather object is display when you start this object
  boolean showCreatureInfo = false;
  boolean showCreatureAxis = false;
  boolean showAbyssOrigin  = false;
  boolean showManagerInfo = false;
  //boolean highTextQuality = false;

  CreatureManager(PApplet parent) {
    //PFont fnt = loadFont("Monaco-12.vlw");
    textFont(font[0]);
    textLeading(17);
    this.parent = parent;
    releasePoint = PVector.random3D();
    releasePoint.mult(100);
    creatures = new ArrayList<SuperCreature>();

    creatureClasses = scanClasses(parent, "SuperCreature");
    if (creatureClasses.size() > 0) selectNextCreature();
  }

  private ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
    ArrayList<Class> classes = new ArrayList<Class>();  
    infoText = "";
    Class[] c = parent.getClass().getDeclaredClasses();
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && (c[i].getSuperclass().getSimpleName().equals(superClassName) )) {
        classes.add(c[i]);
        int n = classes.size()-1;
        String numb = str(n);
        if (n < 10) numb = " " + n;
        infoText += numb + "         " + c[i].getSimpleName() + "\n";
      }
    }
    println("------------------------------------------------------");
    println("Classes which extend " + superClassName + ":");  
    println(infoText);
    return classes;
  }

  public void showCreatureInfo() {
    for (SuperCreature c : creatures) {
      c.drawInfo(c.getPos());
    }
  }

  ArrayList<SuperCreature> getCreatures() {
    return creatures;
  }

  public SuperCreature addCreature( int i) {
    if (i < 0 || i >= creatureClasses.size()) return null;

    SuperCreature f = null;
    try {
      Class c = creatureClasses.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (SuperCreature) constructors[0].newInstance(parent);
    } 

    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 

    if (f != null) {
      releasePoint = PVector.random3D();
      releasePoint.mult(100);
      addCreature(f);
    }
    return f;
  }

  private void addCreature(SuperCreature c) {
    c.setManagerReference(this);
    creatures.add(c);
    tellAllThatCreatureHasBeenAdded(c);
  }

  private void tellAllThatCreatureHasBeenAdded(SuperCreature cAdded) {
    for (SuperCreature c : creatures) {
      c.creatureHasBeenAdded(cAdded);
    }
  }

  void killCreature(SuperCreature c) {
    c.kill();
  }

  void killAll(int whichCreature) {
    creatures.clear();
    // TODO:
    // the previewCreature needs to get out from the main array 
    // to avoid code like this:
    currentCreature--;
    selectNextCreature(whichCreature);
  }

  void killCreatureByName(String creatureName) {
    for (SuperCreature c : creatures) {
      String name = c.creatureName;
      if (creatureName.equals(name)) creatures.remove(creatures.indexOf(c));
    }
  }
  
  // main void
  void loop(color colorIn, color colorOut, float thickness) {
    if (showAbyssOrigin) {
      miroir.noFill();
      miroir.stroke(255, 0, 0);
      repere(200) ;
    }
    if (previewCreature != null) {
      previewCreature.setPos(releasePoint);
      previewCreature.energy = 200.0;
    }
    for (SuperCreature c : creatures) { 
      c.preDraw();
      c.move();      
      c.draw(colorIn, colorOut, thickness);
      c.postDraw();
    }
    //
    drawOverlays();
    //
    cleanUp();
  }

  void drawOverlays() {
    //separated from the main draw loop
    if (showCreatureAxis) {
      for (SuperCreature c : creatures) {  
        c.drawAxis();
      }
    }
    
    

    //info
    if (previewCreature != null && showAbyssOrigin) for (SuperCreature c : creatures) previewCreature.drawInfo(c.getPos());

    if (showCreatureInfo) {
      for (SuperCreature c : creatures) {
        //c.getPos() ;      
        if (c != previewCreature) c.drawInfo(c.getPos());
      }
    }
  }
  void cleanUp() {
    //remove dead cratures
    Iterator<SuperCreature> itr = creatures.iterator();
    while (itr.hasNext ()) {
      SuperCreature c = itr.next();
      if (c.getEnergy() <= 0) itr.remove();
    }
  }
  
  //add random creature
  void addRandomCreature() {
    int r = floor(random(creatureClasses.size()));
    addCreature(r);
  }

  
  
  //add creature
  public SuperCreature addCurrentCreature() {
    if (currentCreature != -1) {
      previewCreature = addCreature(currentCreature);
    }
    return previewCreature;
  }
    // add specific creature
  public SuperCreature addCurrentCreature(int which) {
    if (which != -1) {
      previewCreature = addCreature(which);
    }
    return previewCreature;
  }

  public void setCurrentCreature(int i) {
    currentCreature = i;  
    if (currentCreature < -1 || currentCreature > creatureClasses.size()) {
      currentCreature = -1;
    }
    if (currentCreature > -1) {
      if (previewCreature != null) {
        previewCreature.kill();
        previewCreature = null;
      }
      if (currentCreature > -1) {
        previewCreature = addCreature(currentCreature);
      } 
      else {
        if (previewCreature != null) previewCreature.kill();
        previewCreature = null;
      }
    }
    else {
      if (previewCreature != null) {
        previewCreature.kill();
        previewCreature = null;
      }
    }
  }

  public void selectNextCreature() {
    if (creatureClasses.size() > 0) {
      currentCreature = ++currentCreature % creatureClasses.size();     
      setCurrentCreature(currentCreature);
    }
  }
  // we use this function when we kill all creature to show by default the creature select by the dropdown
  public void selectNextCreature(int which) {
    if (creatureClasses.size() > 0) {
      // currentCreature = ++currentCreature % creatureClasses.size();     
      setCurrentCreature(which);
    }
  }

  public void selectPrevCreature() {
    if (creatureClasses.size() > 0) {
      currentCreature--;
      if (currentCreature < 0) currentCreature = creatureClasses.size()-1;
      setCurrentCreature(currentCreature);
    }
  }

  public void toggleManagerInfo() {
    showManagerInfo = !showManagerInfo;
  }

  public void toggleCreatureInfo() {
    showCreatureInfo = !showCreatureInfo;
  }

  public void toggleAbyssOrigin() {
    showAbyssOrigin = !showAbyssOrigin;
  }

  public void toggleCreatureAxis() {
    showCreatureAxis = !showCreatureAxis;
  }

  public void prevCameraCreature() {
    if (creatures.size() > 0) {
      
      currentCameraCreature--;
      //security for the arraylist !
      if (currentCameraCreature < 0) currentCameraCreature = creatures.size()-1;
      travelling(creatures.get(currentCameraCreature).getPos()) ;
    } else {
      currentCameraCreature = -1;
    }
  }


  public void nextCameraCreature() {
    if (creatures.size() > 0) {
      
      currentCameraCreature = ++currentCameraCreature % creatures.size();
      travelling(creatures.get(currentCameraCreature).getPos()) ;
    } else {
      currentCameraCreature = -1;
    }
  }
}
//END CREATURE MANAGER
/////////////////////


//SUPER CREATURE
////////////////
/**
 * The SuperCreature class
 * Every creature will extend this class.
 */
abstract class SuperCreature {
  protected PVector pos, rot, sca;
  private PVector projectedPos;
  public float energy ; 
  private float power;
  String creatureName, creatureAuthor, creatureVersion;
  CreatureDate creatureDate;
  CreatureManager cm;

  public SuperCreature() {
    creatureName = "Unknown";
    creatureAuthor = "Anonymous";
    creatureVersion = "Alpha";
    creatureDate = new CreatureDate(); 

    //energy = 100.0;
    power = 0.02;
    pos = new PVector();
    projectedPos = new PVector();
    rot = new PVector();
    sca = new PVector(1, 1, 1);
  }

  void setManagerReference(CreatureManager cm) {
    this.cm = cm;
  }

  abstract void move();
  abstract void draw(color cIn, color cOut, float t);

  //applies the default transforms... can be used as a shortcut
  void applyTransforms() {
    miroir.translate(pos.x, pos.y, pos.z);
    miroir.rotateX(rot.x);
    miroir.rotateY(rot.y);
    miroir.rotateZ(rot.z);
    miroir.scale(sca.x, sca.y, sca.z);
  }

  private void preDraw() {
    energy = max(0, energy - power); //creatures with energy == 0 will be removed
    pushStyle();
    miroir.strokeWeight(1); //apparently a pushStyle bug?
    miroir.pushMatrix();     
    // transforms are handled by the creature 
    // this allows greater flexibility for example for particle based creatures 
    // which don't use matrix transforms
    // we don't pre-translate, rotate and scale:
    // translate(pos.x, pos.y, pos.z);
    // rotateX(rot.x);
    // rotateY(rot.y);
    // rotateZ(rot.z);
    // scale(sca.x, sca.y, sca.z);
  };  


  private void postDraw() {
    miroir.popMatrix(); 
    popStyle();
    projectedPos.x = screenX(pos.x, pos.y, pos.z);
    projectedPos.y = screenY(pos.x, pos.y, pos.z);
  };

  PVector getPos() {
    return pos.get();
  }

  void setPos(PVector pos) {
    this.pos = pos.get();
  }

  void creatureHasBeenAdded(SuperCreature c) {
  }

  SuperCreature getNearest() {
    return getNearest("");
  }

  SuperCreature getNearest(String creatureName) {
    float d = MAX_FLOAT;
    SuperCreature nearest = null;
    for (SuperCreature c : cm.getCreatures()) {
      if (c != this && (c.creatureName != creatureName)) {
        PVector p = c.getPos();
        PVector m = PVector.sub(pos, p);
        float s = m.x * m.x + m.y * m.y + m.z * m.z;//m.mag();
        if (s < d) {
          d = s; 
          nearest = c;
        }
      }
    }
    return nearest;
  }

  void drawAxis() {
    color noir = color(0,100,0) ;
    miroir.pushMatrix();
    miroir.translate(pos.x, pos.y, pos.z);   
    miroir.rotateX(rot.x);
    miroir.rotateY(rot.y);
    miroir.rotateZ(rot.z);    
    float l = 100;
    miroir.strokeWeight(1);
    miroir.stroke(0,100,0);
    miroir.line(0, 0, 0, l, 0, 0);
    miroir.stroke(noir);
    miroir.line(0, 0, 0, 0, l, 0);
    miroir.stroke(noir);
    miroir.line(0, 0, 0, 0, 0, l);
    miroir.popMatrix();
  }

  void drawInfo(PVector pos) {
    color blanc = color(0,0,100) ;
    pushStyle();
    miroir.pushMatrix() ;
    miroir.fill(blanc);
    miroir.stroke(blanc);
    /*
    float x = projectedPos.x -width/2;
    float y = projectedPos.y -height/2;
    */
    float x = 0;
    float y = 0;
    miroir.translate(pos.x, pos.y, pos.z) ;
    miroir.ellipse(x, y, 6, 6);
    miroir.line(x, y, x+70, y-70);
    String s = creatureName + "\n" + creatureAuthor + "\n" + creatureVersion + "\n";
    s += creatureDate + "\n";
    s += "energy: " + nf(energy, 0, 1);
    miroir.text(s, x+70, y-70);
    miroir.popMatrix() ;
    popStyle();
  }



  float getEnergy() {
    return energy;
  }

  void kill() {
    energy = 0.0;
  }

  void setDate(int y, int m, int d) {
    creatureDate.set(y, m, d);
  }

  //just date object
  class CreatureDate {
    int y, d, m; 

    CreatureDate() {
      this.y = 2000;
      this.d = 1;
      this.m = 1;
    }

    CreatureDate(int y, int m, int d) {
      set(y, m, d);
    }

    public void set(int y, int m, int d) {
      this.y = y;
      this.d = d;
      this.m = m;
    }

    public String toString() {
      return y + "." + d + "." + m;
    }
  }
}
//END SUPERCREATURE





//CREATURE CATALOGUE
//BOXFISH
/**
 * A simple box-like fish.
 * Just swims around following it's heartbeat.
 */
class AGBoxFish extends SuperCreature {
  PMatrix3D mat;
  PVector dimBox, dimR, dimF;
  float fF, fR, aF, aR, fRot, aRot;
  float eye;
  float spd;

  public AGBoxFish() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "BoxFish";
    creatureVersion = "Beta";
    setDate(2012, 4, 26); //Y,M,D
    //energy = 0 ;

    mat = new PMatrix3D();
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(-0.1, 0.1));

    dimR = new PVector(random(10, 30), random(10, 30));
    dimF = new PVector(random(5, 50), random(5, 20));
    dimBox = new PVector(random(20, 80), random(20, 80), random(15, 40));
    fF = random(0.1, 0.3);
    aF = random(0.6, 1.0);
    fR = random(0.8, 0.9);
    aR = random(0.6, 1.0);
    fRot = fF;//random(0.05, 0.1);
    aRot = random(0.02, 0.05);
    spd = fRot * 10;
    eye = random(1, 3);
  }

  void move() {
    float s = sin(frameCount * fRot);
    mat.rotateY(s * aRot + (noise(pos.z * 0.01, frameCount * 0.01) -0.5) * 0.1);
    mat.rotateZ(s * aRot * 0.3);
    mat.translate(-spd, 0, 0);
    mat.mult(new PVector(), pos);
  }

  void setPos(PVector p) {
    float[] a = mat.get(null);
    a[3] = p.x;
    a[7] = p.y;
    a[11] = p.z;
    mat.set(a);
  }

  void draw(color colorIn, color colorOut, float thickness) {
    miroir.applyMatrix(mat);
    miroir.pushMatrix();
    sphereDetail(5);
    scale(min(getEnergy() * 0.1, 1)); //it's possible to animate a dying creature...
    translate(dimBox.x/4, 0, 0);
    float f = sin(frameCount * fF) * aF;  
    float r = sin(frameCount * fR) * aR;
    //float h = sin(frameCount * fF * 0.5 + aF);
    //float a = map(h, -1, 1, 20, 100);  

    //noStroke();
    //fill(255,0,0 a);
    //float hr = dimBox.z * 0.15 + h * dimBox.z * 0.03;
    //sphere(hr/2);
    //sphere(hr);

    fill(colorIn);
    stroke(colorOut);
    strokeWeight(thickness) ;
    
    box(dimBox.x, dimBox.y, dimBox.z);

    miroir.pushMatrix();
    translate(-dimBox.x/2, dimBox.y/2, dimBox.z/2);
    rotateZ(HALF_PI);
    rotateY(f - 1);
    rect(0, 0, dimF.x, dimF.y);
    miroir.popMatrix();

    miroir.pushMatrix();
    translate(-dimBox.x/2, dimBox.y/2, -dimBox.z/2);
    rotateZ(HALF_PI);
    rotateY(-f + 1);
    rect(0, 0, dimF.x, dimF.y);
    miroir.popMatrix();

    miroir.pushMatrix();
    translate(dimBox.x/2, dimBox.y/2, dimBox.z/2);
    rotateY(r);
    rect(0, 0, dimR.x, dimR.y);
    miroir.popMatrix();

    miroir.pushMatrix();
    translate(dimBox.x/2, dimBox.y/2, -dimBox.z/2);
    rotateY(-r);
    rect(0, 0, dimR.x, dimR.y);
    miroir.popMatrix();
    //eye of the fish
    noStroke();
    fill(colorOut);
    miroir.pushMatrix();
    translate(-dimBox.x/2 + eye, dimBox.y/3, -dimBox.z/2);
    sphere(eye);
    translate(0, 0, dimBox.z);
    sphere(eye);
    miroir.popMatrix();

    miroir.popMatrix();
  }
}
//END BOXFISH

/**
 * A creature with four tentacles.
 * Floats it's life away in the Abyss.
 */
class AGCubus extends SuperCreature {
  PVector fPos, fAng;
  float cSize;
  int segments;
  float bLen;
  float aFreq;
  float bOffs;
  float angRange;

  public AGCubus() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "Cubus";
    creatureVersion = "Beta";
    setDate(2012, 4, 22); //Y,M,D

    cSize = random(6, 30);
    fPos = new PVector(random(-0.002, 0.002), random(-0.002, 0.002), random(-0.002, 0.002));
    fAng = new PVector(random(-0.005, 0.005), random(-0.005, 0.005), random(-0.005, 0.005));
    
    segments = int(random(5,9));
    bLen = random(4, 10);
    aFreq = random(0.01, 0.1);
    bOffs = random(5);
    angRange = random(0.3, 0.6);
  }

  void move() {    
    pos.x += sin(frameCount*fPos.x);
    pos.y += sin(frameCount*fPos.y);
    pos.z += cos(frameCount*fPos.y);

    rot.x = sin(frameCount*fAng.x) * TWO_PI;
    rot.y = sin(frameCount*fAng.y) * TWO_PI;
    rot.z = sin(frameCount*fAng.z) * TWO_PI; 
  }

  void draw(color colorIn, color colorOut, float thickness) {    
    applyTransforms(); //shortcut   
    miroir.fill(colorIn) ;
    miroir.stroke(colorOut);

    // the body
    miroir.strokeWeight(thickness);
    miroir.box(cSize); 
    
    //the four tentacles
    miroir.strokeWeight(thickness);
    for (int j=0; j<4; j++) {
      PVector p = new PVector(bLen, 0); 
      PVector pos = new PVector(cSize/2, 0); 
      float ang = sin(frameCount*aFreq + j%2 * bOffs) * angRange;
      float l = bLen;
      miroir.beginShape();
      for (int i=0; i<segments+1; i++) {
        miroir.vertex(pos.x, pos.y);
        pos.x += p.x;
        pos.y += p.y;
        p = rotateVec(p, ang);
        p.limit(l);
        l *= 0.93; //scale a bit, this factor could also be randomized.
      }
      miroir.endShape();
      miroir.rotateY(HALF_PI);
    }
  }

  PVector rotateVec(PVector v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return new PVector(v.x*c - v.y*s, v.x*s + v.y*c);
  }    
}


/**
 * A floating fish.
 * Position is calculated with Perlin noise.
 */
class AGFloater extends SuperCreature {

  PMatrix3D mat;
  float offset;
  float ampBody, ampWing;
  float freqBody, freqWing;
  float wBody, hBody, wWing;
  float noiseScale, noiseOffset;
  float speedMin, speedMax;

  public AGFloater() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "Floater";
    creatureVersion = "Beta";
    setDate(2012, 4, 26); //Y,M,D

    mat = new PMatrix3D();
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(-0.2, 0.2));

    freqBody = random(0.1, 0.2);
    freqWing = freqBody;
    offset = 1.2 + random(-0.1,0.2);
    float s = 0.9;
    ampBody = random(10, 30)*s;
    ampWing = random(0.6, 1.2)*s;
    wBody = random(20, 40)*s;
    hBody = random(30, 90)*s;
    wWing = random(20, 50)*s;
    speedMin = random(2.5,3.5)*s;
    speedMax = random(4.5,5.5)*s;
    
    noiseScale = 0.012;
    noiseOffset = random(1); 
  }

  void move() {
    mat.rotateY(map(noise(frameCount * noiseScale + noiseOffset), 0, 1, -0.1, 0.1));
    float speed = map(sin(frameCount * freqBody), -1, 1, speedMin, speedMax);   
    mat.translate(0 , 0, speed);
    mat.mult(new PVector(), pos); //update the position vector
  }

  void setPos(PVector p) {
    float[] a = mat.get(null);
    a[3] = p.x;
    a[7] = p.y;
    a[11] = p.z;
    mat.set(a);
  }

  void draw(color colorIn, color colorOut, float thickness) {
    miroir.applyMatrix(mat);
    //stroke(255);
    stroke(colorOut);
    fill(colorIn);
    strokeWeight(thickness) ;
    rotateX(-HALF_PI);
    scale(min(getEnergy() * 0.1, 1));

    float h1 = sin(frameCount * freqBody) * ampBody;
    float h2 = sin(frameCount * freqWing + offset) * ampWing;

    translate(0, 0, h1);
    rectMode(CENTER);
    rect(0, 0, wBody, hBody);

    rectMode(CORNER);
    miroir.pushMatrix();
    translate(-wBody/2, -hBody/2, 0);
    rotateY(PI - h2);
    rect(0, 0, wWing, hBody);
    miroir.popMatrix();

    miroir.pushMatrix();
    translate(wBody/2, -hBody/2, 0);
    rotateY(h2);
    rect(0, 0, wWing, hBody);
    miroir.popMatrix();
  }
}



/**
 * An attempt of a radiolaria-like creature.
 * Uses vertex colors for gradients.
 */
class AGRadio extends SuperCreature {

  PVector pVel, rVel;
  int num, spikes;
  float freq;
  float rad, rFact;

  public AGRadio() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "Radio";
    creatureVersion = "Alpha";
    setDate(2012, 7, 27); //Y,M,D

    pVel = new PVector( random(-1, 1), random(-1, 1), random(-1, 1) );
    rVel = new PVector( random(-0.01, 0.01), random(-0.01, 0.01), random(-0.01, 0.01) );
    num = round(random(20, 100));
    spikes = ceil(random(3, 12));
    freq = random(0.02, 0.06);
    rad = random(30, 60);
    rFact = random(0.2, 0.4);
  }

  void move() {
    pos.add(pVel);  
    rot.add(rVel);  
    applyTransforms();
  }

  void draw(color colorIn, color colorOut, float thickness) {  
    miroir.stroke(colorOut);
    miroir.fill(colorIn);
    miroir.strokeWeight(thickness);
    hint(DISABLE_DEPTH_TEST); 
    float arc = TWO_PI / num;    
    float f = frameCount * freq;
    float a = arc * spikes;
    miroir.beginShape(QUAD_STRIP);
    for (int i=0; i<num+1; i++) { 
      int j = i % num;
      float len = (sin(f + a * j)) * 0.2;
      float c = cos(arc * j); 
      float s = sin(arc * j);
      float x = c * (rad + len * rad);
      float y = s * (rad + len * rad);
      float z = len * rad;
      miroir.fill(hue(colorIn), saturation(colorIn), brightness(colorIn), i % 2 * alpha(colorIn)  ); 
      miroir.vertex(x*rFact, y*rFact, z);
      miroir.fill(255, 0); 
      miroir.vertex(x, y, 0);
    }
    miroir.endShape();
    hint(ENABLE_DEPTH_TEST);
  }
}




/**
 * An example creature with simple spring and node classes.
 * Moves randomly trough the deep waters in search for meaning.
 */
class AGWorm extends SuperCreature {
  ArrayList<Node> nodes;
  ArrayList<Spring> springs;

  PVector dest;
  float nervosismo;
  float radius;
  float rSpeed, rDamp;
  float freq1, freq2;

  public AGWorm() {
    creatureAuthor = "Andreas Gysin";
    creatureName = "El Worm";
    creatureVersion = "Alpha";
    setDate(2011, 6, 10); //Y,M,D

    int num = int(random(7,22));
    float len = random(2, 15);
    float damp = random(0.85, 0.95);
    float k = random(0.15,0.3);
    radius = random(1.5, 2.5);   
    rSpeed = random(50,150);
    rDamp = random(0.005, 0.02);
    nervosismo = random(0.01, 0.3);
    freq1 = random(0.05, 0.2);
    freq2 = random(0.08, 1.1);

    nodes = new ArrayList<Node>();

    springs = new ArrayList<Spring>();
    for (int i=0; i<num; i++) {
      PVector p = PVector.add(pos, new PVector(random(-1,1),random(-1,1),random(-1,1)));
      Node n = new Node(p, damp);
      nodes.add(n);
    }
    
    for (int i=0; i<num-1; i++) {
      Spring s = new Spring(nodes.get(i), nodes.get(i+1), len, k);
      springs.add(s);
    }
    
    dest = new PVector();
  }

  void move() {
    if (random(1) < nervosismo) {
      dest.add(new PVector(random(-rSpeed,rSpeed),random(-rSpeed,rSpeed),random(-rSpeed,rSpeed)));
    }
    pos.x += (dest.x - pos.x) * rDamp;
    pos.y += (dest.y - pos.y) * rDamp;
    pos.z += (dest.z - pos.z) * rDamp;
    nodes.get(0).setPos(pos);
    for (Spring s : springs) s.step();
    for (Node n : nodes) n.step();
  }

  void draw(color colorIn, color colorOut, float thickness) {
    miroir.fill(colorIn);
    miroir.stroke(colorOut);
    miroir.strokeWeight(thickness) ;
    for (Spring s : springs) {
      miroir.line(s.a.x, s.a.y, s.a.z, s.b.x, s.b.y, s.b.z);
    }

    int i=0;
    //noStroke();
    sphereDetail(3);
    //fill(colorIn);  
    float baseFreq = frameCount * freq1;
    for (Node n : nodes) {
      float d = map( sin(baseFreq - i*freq2), -1, 1, radius, radius * 2);
      miroir.pushMatrix();
      miroir.translate(n.x, n.y, n.z);
      //if ((i + frameCount/5) % 4 == 0) d *= 0.5;
      miroir.sphere(d);      
      miroir.popMatrix();
      i++;
    }
  }

  class Node extends PVector {

    float damp;
    PVector vel;

    Node(PVector v, float damp) {
      super(v.x, v.y, v.z);
      this.damp = damp;
      vel = new PVector();
    }

    void step() {
      add(vel);
      vel.mult(damp);
    }

    void applyForce(PVector f) {
      vel.add(f);
    }

    void setPos(PVector p) {
      this.x = p.x;
      this.y = p.y;
      this.z = p.z;
      vel = new PVector();
    }
  }
  
  class Spring {
    float len;
    float scaler;
    Node a, b;

    Spring(Node a, Node b, float len, float scaler) {
      this.a = a;
      this.b = b;
      this.len = len;
      this.scaler = scaler;
    }

    void step() {

      PVector v = PVector.sub(b, a);
      float m = (v.mag() - len) / 2 * scaler;
      v.normalize();

      v.mult(m);    
      a.applyForce(v);

      v.mult(-1);    
      b.applyForce(v);
    }
  }
}



//SEA FLY
class EPSeaFly extends SuperCreature {

  PVector freqMulPos, freqMulAng;
  int count;

  public EPSeaFly() {
    creatureName = "EPSeaFly";
    creatureAuthor = "Edoardo Parini";
    creatureVersion = "1.0";
    setDate(2012, 4, 25);

    freqMulPos = new PVector();
    freqMulPos.x = random(-0.002, 0.002); 
    freqMulPos.y = random(-0.002, 0.002); 
    freqMulPos.z = random(-0.002, 0.002);

    freqMulAng = new PVector();
    freqMulAng.x = random(-0.005, 0.005); 
    freqMulAng.y = random(-0.005, 0.005); 
    freqMulAng.z = random(-0.005, 0.005);
  }

  void move() {
    count++;
    pos.x += sin(count*freqMulPos.x);
    pos.y += sin(count*freqMulPos.y);
    pos.z += cos(count*freqMulPos.y);

    rot.x = sin(count*freqMulAng.x) * TWO_PI;
    rot.y = sin(count*freqMulAng.y) * TWO_PI;
    rot.z = sin(count*freqMulAng.z) * TWO_PI;
    
    applyTransforms();
  }

  void draw(color colorIn, color colorOut, float thickness) {

    miroir.stroke(colorOut);
    miroir.fill(colorIn); 
    miroir.strokeWeight(thickness) ; 
    // float dimR = 20;
    // float dimF = 10;  

    miroir.scale(0.2);
    miroir.translate(count * 0.018, count * 0.008); 
    miroir.rotateX(count * 0.008);

    PVector dim = new PVector(100, 60, 30);
    sphereDetail(3); 
    miroir.sphere(25);

    float aF = sin(count * 0.15) * 0.8;  
    float aR = sin(count * 0.25) * 0.8;

    miroir.pushMatrix();                            
    miroir.translate(-dim.x/2, dim.y/2, dim.z/2);
    miroir.rotateZ(aF/2 + 1.2);
    miroir.rotateY(aF - 1);
    miroir.fill(hue(colorIn), saturation(colorIn), brightness(colorIn),alpha(colorIn)*.3);
    miroir.quad(0, 0, 86, 20, 69, 63, 30, 76);
    miroir.noFill();
    miroir.quad(0, 0, 96, 23, 79, 73, 40, 86);
    miroir.popMatrix();

    miroir.pushMatrix();                          
    miroir.translate(-dim.x/2, dim.y/2, -dim.z/2);
    miroir.rotateZ(aF/2 + 1.2);
    miroir.rotateY(-aF + 1);
    miroir.fill(hue(colorIn), saturation(colorIn), brightness(colorIn),alpha(colorIn)*.3);
    miroir.quad(0, 0, 86, 20, 69, 63, 30, 76);
    miroir.noFill();
    miroir.quad(0, 0, 96, 23, 79, 73, 40, 86);
    miroir.popMatrix();

    miroir.pushMatrix();                          
    miroir.translate(dim.x/2, dim.y/2, dim.z/2);
    miroir.rotateY(aR);
    miroir.quad(0, 0, 96, 23, 79, 73, 40, 86);
    miroir.fill(hue(colorIn), saturation(colorIn), brightness(colorIn),alpha(colorIn)*.3);
    miroir.quad(0, 0, 86, 20, 69, 63, 30, 76);
    miroir.popMatrix();

    miroir.pushMatrix();                  
    miroir.translate(dim.x/2, dim.y/2, -dim.z/2);
    miroir.rotateY(-aR);
    miroir.quad(0, 0, 86, 20, 69, 63, 30, 76);
    miroir.noFill();
    miroir.quad(0, 0, 96, 23, 79, 73, 40, 86);
    miroir.popMatrix();
  }
}






//BREATHER
class FFBreather extends SuperCreature {

  PVector oldPosition;
  PVector acc = new PVector(0,0);
  float xoff = 0.1, yoff = 10.45;
  float xadd = 0.001, yadd = 0.005;
  float xNoise = 0, yNoise = 0;
  PVector inside = new PVector(0,0);
  PVector center = new PVector(0,0);
  float sizeIt = 0, addSizeIt = 00.01;
  float sizeItCos, breath, breathoff, breathadd;
  PVector one,two,three, len, newCenter;
  ArrayList<PVector >points  = new ArrayList <PVector>();
  float start = 0.0;
  
  PVector rVel, pVel;

  int creatureSize, creatureWidth, realCreatureSize;
  float moveAroundCircle;

  public FFBreather() {
    creatureName = "The Breather";
    creatureAuthor = "Fabian Frei";
    creatureVersion = "1";
    setDate(2011, 5, 7); //Y,M,D
    
    randomStart();

    // math the shit out of it
    for(int i = 0;i < realCreatureSize;i++)
    {
      points.add(new PVector(cos(start)*creatureWidth,sin(start)*creatureWidth) );
      start += moveAroundCircle;
    }
    //println(points);
  }

  void randomStart() 
  {
    creatureSize = (int)random(3,11);
    if(creatureSize%2 != 0)
    {
      creatureSize++;
    }
    //println("creatureSize = " + creatureSize);
    realCreatureSize = 3*creatureSize;
    //println("realCreatureSize = " + realCreatureSize);
    creatureWidth = (int)random(10,100);
    moveAroundCircle = TWO_PI/realCreatureSize;

    pos = new PVector(random(0,width),random(0,height));
    oldPosition = pos;

    sizeIt = 0;
    addSizeIt = random(0.001,0.1);
    breathoff = random(0.001,0.01);
    breathadd = random(0.0001,0.001);
    xoff = random(0.001,0.1);
    yoff = random(10,100);
    xadd = random(0.00001,0.01);
    yadd = random(0.00001, 0.01);

     pVel = PVector.random3D();
    rVel = PVector.random3D();
    rVel.mult(random(0.01, 0.03));
    float s = random(0.5, 1);
    sca.set(s,s,s);
  }


  void move() {
    breath = noise(breathoff);
    breathoff += breathadd;

    sizeItCos = map(cos(sizeIt),-1,1,breath,1);
    sizeIt = sizeIt + addSizeIt;

    pos.add(pVel);  
    rot.add(rVel);  
    applyTransforms();
  }


  void draw(color colorIn, color colorOut, float thickness) {
    miroir.stroke(colorOut);
    miroir.fill(colorIn);
    miroir.strokeWeight(thickness) ;

    for(int i = 0; i < points.size()-1;i+=2)
    {
      one = points.get(i);
      two =  points.get(i+1);

      if( i+2 < points.size() )
      {
        three = points.get(i+2);
      } 
      else {
        three = points.get(0);
      }

      len = PVector.sub(center,two);
      newCenter = PVector.add(PVector.mult(len,sizeItCos),two);

      miroir.beginShape(); 
      miroir.vertex(one.x,one.y,0);
      miroir.vertex(newCenter.x,newCenter.y,15+breath*75);
      miroir.vertex(three.x,three.y,0);
      miroir.endShape(CLOSE);
    }
  }
}




//HUBERT alias Spider
class LPHubert extends SuperCreature {

  PVector freqMulPos, freqMulAng;
  int num;
  int count;
  
  float cSize;
  float bLen;
  float aFreq;
  float bOffs;
  float angRange;
  float angT, scaR;

  int numberT, numberSeg, elSize, val2div;

  boolean isAngry = false;

  public LPHubert() {
    creatureAuthor ="Laura Perrenoud";
    creatureName ="Hubert";
    creatureVersion ="1.0";
    setDate(2012, 4, 26);

    //////////////Mouvement alétoire
    freqMulPos = new PVector();
    freqMulPos.x = random(-0.002, 0.002); 
    freqMulPos.y = random(-0.002, 0.002); 
    freqMulPos.z = random(-0.002, 0.002);

    freqMulAng = new PVector();
    freqMulAng.x = random(-0.005, 0.005); 
    freqMulAng.y = random(-0.005, 0.005); 
    freqMulAng.z = random(-0.005, 0.005);
    /////////////////

    ///////////////Créature random
    num = 10;
    cSize = random(6, 30);
    bLen = random(5, 15);
    aFreq = random(0.01, 0.02);
    bOffs = random(5);
    angRange = random(0.3, 0.6);
    numberT = int(random(3, 20));
    numberSeg = int(random(3, 7));
    elSize = 5;
    val2div = int(random(1, 3));
    scaR = (random(0.3, 1.52));
    sca.x = scaR;
    sca.y = scaR;
    sca.z = scaR;
    ////////////////
  }

  void move() {
    count++;
    ////////////////
    pos.x += sin(count*freqMulPos.x);
    pos.y += sin(count*freqMulPos.y);
    pos.z += sin(count*freqMulPos.z);

    rot.x = sin(count*freqMulAng.x) * TWO_PI;
    rot.y = sin(count*freqMulAng.y) * TWO_PI;
    rot.z = sin(count*freqMulAng.z) * TWO_PI;

    applyTransforms();

  }

  void draw(color colorIn, color colorOut, float thickness) {

    miroir.strokeWeight(thickness);
    miroir.fill(colorIn);
    miroir.stroke(colorOut);
    float val2 = sin(count*aFreq*3)*2;
    
    float a1 = sin(count*aFreq + bOffs) * angRange;
    float a2 = sin(count*aFreq) * angRange;

    for (int j=0; j<numberT; j++) {

      PVector p = new PVector(bLen, 0); 
      PVector pos = new PVector(cSize/6, 0); 
      float ang = (j % 2 == 0) ? a1 : a2;
      float l = bLen;

      for (int i=0; i<numberSeg; i++) {
        if (i<numberSeg-2) {
          miroir.pushMatrix();
          miroir.translate(pos.x + p.x, pos.y + p.y, 0);
          miroir.box(3+val2);
          miroir.popMatrix();
        }

        miroir.line(pos.x, pos.y, pos.x + p.x, pos.y + p.y);
        pos.x += p.x;
        pos.y += p.y;
        p = rotateVec(p, ang+(val2 * 0.1));
        p.limit(l);
        l *= 0.99;
        //l *= 0.93;
      }
      miroir.rotateY(PI*2/numberT);
    }
  }

  PVector rotateVec(PVector v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return new PVector(v.x*c - v.y*s, v.x*s + v.y*c);
  }
}


//MANTA
class MCManta extends SuperCreature {

  int sz, lgth, nb;
  float ang;
  float vel, freqY, ampY;
  //PVector colorF;
  PVector wingsAmp;
  int count;

  public MCManta() {
    creatureAuthor  = "Maxime Castelli";
    creatureName    = "Manta";
    creatureVersion = "Beta";
    setDate(2012, 4, 22); //Y,M,D

    freqY = random(0.01, 0.03);
    ampY = random(30, 90);
    //    colorF = new PVector();
    //    colorF.x = random(0.001, 0.004); 
    //    colorF.y = random(0.001, 0.004); 
    //    colorF.z = random(0.001, 0.004);

    ang = random(TWO_PI);
    vel = random(1, 2);

    wingsAmp = new PVector();
    wingsAmp.x = random(0.01, 0.15);
    wingsAmp.y = random(0.01, 0.15);
  }

  void move() {
    count++;
    pos.x += cos(ang) * vel;
    pos.y = cos(count*freqY) * ampY;
    pos.z += sin(ang) * vel;
    rot.y = -ang;
    applyTransforms();
  }

  void draw(color colorIn, color colorOut, float thickness) {

    sz = 25;
    lgth = 300;
    nb = lgth /sz ;

    miroir.fill(colorIn);
    miroir.stroke(colorOut);
    miroir.strokeWeight(thickness);
    miroir.rotateY(PI);

    //TETE
    sphereDetail(2);
    for (int i=0; i<2; i++) {
      miroir.pushMatrix();
      miroir.translate(40 +i*15, 0 +(sin(i+count*0.1)));
      miroir.scale(2, i*0.8);
      miroir.sphere(15);
      miroir.popMatrix();
    }

    //AILE 1
    miroir.pushMatrix();
    miroir.rotateX(0.6*sin(count * wingsAmp.x) + radians(90));
    miroir.beginShape(TRIANGLE_STRIP);
    for (int l1=0; l1<10; l1++) {
      miroir.vertex(pow(l1, 2), l1*10, sin(count*wingsAmp.y)*5);
      miroir.vertex(75, 25, cos(count*wingsAmp.x)*10);
    }
    miroir.vertex(120, 0);
    miroir.endShape(CLOSE);  
    miroir.popMatrix();

    //AILE 2
    miroir.pushMatrix();
    miroir.rotateX(-0.6*sin(count * wingsAmp.x) - radians(90));
    miroir.beginShape(TRIANGLE_STRIP);
    miroir.vertex(0, 0);
    for (int l2=0; l2<10; l2++) {
      miroir.vertex(pow(l2, 2), l2*10, sin(count*wingsAmp.y)*5);
      miroir.vertex(75, 25, -cos(count*wingsAmp.x)*10);
    }
    miroir.vertex(120, 0);
    miroir.endShape(CLOSE);
    miroir.popMatrix();

    //QUEUE
    miroir.translate(80, 0);
    miroir.beginShape(TRIANGLE_STRIP); 
    for (int j=0; j<15;j++) {
      miroir.vertex(j*10, sin(j-(count* wingsAmp.x))*(j), cos(j-(count* wingsAmp.y))*(j));
    }
    miroir.endShape();
  }
}



//SONAR
class PXPSonar extends SuperCreature {

  int time;
  int count;
  int bold = 2;
  int freq = 300;
  float fadeSpeed = 5;
  PVector freqMulRot, freqMulSca, freqMulPos;

  public PXPSonar() {
    creatureAuthor  = "Pierre-Xavier Puissant";
    creatureName    = "Sonar";
    creatureVersion = "1.0";
    setDate(2012, 4, 25); //Y,M,D

    freqMulRot = new PVector();
    freqMulRot.x = random(-0.0005, 0.0005);
    freqMulRot.y = random(-0.001, 0.001);
    freqMulRot.z = random(-0.0015, 0.0015);

    freqMulPos = new PVector();
    freqMulPos.x = random(-0.002, 0.002); 
    freqMulPos.y = random(-0.002, 0.002); 
    freqMulPos.z = random(-0.002, 0.002);

    /*freqMulSca = new PVector();
     freqMulSca.x = random(-0.005, 0.005);
     freqMulSca.y = random(-0.005, 0.005);
     freqMulSca.z = random(-0.005, 0.005);*/
  }

  void move() {
    rot.x = sin(frameCount*freqMulRot.x) * TWO_PI;
    rot.y = sin(frameCount*freqMulRot.y) * TWO_PI;
    rot.z = sin(frameCount*freqMulRot.z) * TWO_PI;

    pos.x += sin(frameCount*freqMulPos.x);
    pos.y += sin(frameCount*freqMulPos.y);
    pos.z += cos(frameCount*freqMulPos.z);

    applyTransforms();
  }

  void draw(color colorIn, color colorOut, float thickness) {
    time++;
    count++;
    float changeWH;
    float changeAL;
    float changeSca = map(sin(count*0.15), -1,1, 1, 1.5);
    
    miroir.fill(colorIn);
    for (int i = 0; i < bold; i++) { 
      changeAL = (freq-time*fadeSpeed)*(sin((PI/bold)*i));
      miroir.stroke(hue(colorOut), saturation(colorOut), brightness(colorOut), changeAL*2);
      changeWH = exp(sqrt(time*0.75))+i;
      miroir.ellipse (0, 0, changeWH, changeWH);
    }
    if (time > freq) {
      time = 0;
    }

    miroir.rotateX(count*0.011);
    miroir.rotateX(count*0.012);
    miroir.rotateZ(count*0.013);

    miroir.stroke (colorOut, alpha(colorOut) *.3);    
    sphereDetail(6);
    miroir.sphere(30);    
    miroir.scale(changeSca, changeSca, changeSca);
    miroir.stroke (colorOut);
    sphereDetail(1);
    miroir.sphere(10);
  }
}


//FATHER
class OTFather extends SuperCreature {
  int count;
  int numSegmenti;
  int numTentacoli;
  int numPinne;
  float distPinne;
  float l;

  //TRIGO
  float sm1, sm2;
  float rx, ry;
  PVector pVel, rVel, noiseVel;

  public OTFather() {
    creatureName = "Father";
    creatureAuthor = "Oliviero Tavaglione";
    creatureVersion = "Beta";
    setDate(2011, 5, 7); //Y,M,D


    numSegmenti = floor(random(10, 20));
    numTentacoli = 1;
    numPinne = floor(random(2, 6));
    distPinne = random(0.2, 0.5);
    l = random(20, 40);

    sm1 = random(-0.005, 0.005);
    sm2 = random(-0.005, 0.005);    


    pVel = PVector.random3D();
    rVel = PVector.random3D();
    rVel.mult(random(0.01, 0.03));
    noiseVel =PVector.random3D();
    noiseVel.mult(random(0.005, 0.03));
    float s = random(0.5, 1);
    sca.set(s,s,s);
  }

  void move() {
    count++;
    pos.add(pVel);  
    rot.add(rVel);  
    applyTransforms();
  }


  void draw(color colorIn, color colorOut, float thickness) {
    sphereDetail(8);

    //TESTA
    miroir.fill(colorIn);
    miroir.stroke(colorOut);
    miroir.strokeWeight(thickness) ;
    miroir.sphere(l);

    //ANTENNE
/*
    //float ly = sin(frameCount * 0.01) * 30;
    //float lz = -sin(frameCount * 0.01) * 30;
    float ly = random(l/2, sin(count * 0.01) * l);
    float lz = random(l, l + (l/1.5));
*/

    miroir.line(0, 0, 0, -l*2, 10, 30);
    miroir.line(0, 0, 0, -l*2, 10, -30);

    //PINNE  
    miroir.rotateY(-(numPinne-1) * distPinne / 2);
    //rotateY(-(numPinne-1) * distPinne / (distPinne - TWO_PI));
    for (int k=0; k<numPinne; k++) {

      float s = (cos(TWO_PI / (numPinne-1) * k));
      s = map(s, 1, -1, 0.9, 1);
      // println(k + "   " + s);
      miroir.pushMatrix();
      miroir.scale(s);


      for (int j=0; j<numTentacoli; j++) {
        miroir.pushMatrix();
        float a = (noise(count*noiseVel.x + j+k+1)-0.4)*0.782; 
        float b = (noise(count*noiseVel.y + j+k+1)-0.5)*0.582; 
        float c = (noise(count*noiseVel.z + j+k+1)-0.6)*0.682;

        for (int i=0; i<numSegmenti; i++) {
          miroir.rotateZ(a);
          miroir.rotateY(b);
          miroir.rotateX(c);
          miroir.translate(l*0.9, 0, 0);
          miroir.scale(0.85, 0.85, 0.85);
          miroir.box(l, l/2, l); 
          //ellipse(l/2, l, l, l);
        }


        miroir.popMatrix();


        //rotateY(TWO_PI/numTentacoli);
      }
      miroir.popMatrix();
      miroir.rotateY(distPinne);
    }
  }
}

//END CATALOGUE
