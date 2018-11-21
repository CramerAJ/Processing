float rotate = 0; // incremental position of second minute / earth
float mRotate = 0;  // incremental position of millisecond clock / moon
float x, y; // float values for position of earth

float earthMoonX, earthMoonY; 
float marsMoonX, marsMoonY;
float jupiterMoonX,jupiterMoonY;

float startingEnergy = 190;

int numPlanets = 8;

float lowerPlanetBound = 200;
float upperPlanetBound = 820;

int numJupiterMoons = 20;
float outerOrbit = 115;
float innerOrbit = 25;

///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////

class starSun{
  //Num of particles made per frame;
  float particlesMade = 100;
 //Setting the amount of particles it can have
  float sunCurrentEnergy;
  //Constructor for the class
  starSun(){
    //Setting the global to the current energy, and only changing the Current variable
     this.sunCurrentEnergy = startingEnergy;
  }
  void update(){
   //CONDITIONS
   //Capturing radius as the starting energy
 
  if (mousePressed){
    if (pow(mouseX-width/2,2)+pow(mouseY-height/2,2) <= pow(this.sunCurrentEnergy, 2)/4);
     //starting at 0, but adding a size of +1 to start at 1, when moving though, need to change indexes after that in the list
     for (int i = 0; i < particlesMade; i++) emitterList.add(new emitter(width/2, height/2, this.sunCurrentEnergy/2));
     // check to see if hit by emitters for Super(tm) sun punish!
     for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if (pow(tmp.x, 2) + pow(tmp.y, 2) <= pow(this.sunCurrentEnergy, 2)) {
        emitterList.remove(i);
      }
     }
  }
  //Solar Wave
  else if (random(10000) < 25){
    
  for (int i = 0; i < 4500; i++) emitterList.add(new emitter(width/2, height/2, this.sunCurrentEnergy/4));
     // check to see if hit by emitters for Super(tm) sun punish!
     for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
     }
    }
  }
  void draw(){
    //color change
    //starting color is black
    fill(255, 175, 0);
    ellipse(width/2,height/2,this.sunCurrentEnergy,this.sunCurrentEnergy);
    
  } 
}

float arctan(float x, float y) {
  if (x > 0 && y < 0) return atan(y/x);
  if (x > 0 && y > 0) return 2*PI - atan(-y/x);
  if (x < 0 && y < 0) return PI + atan(y/x);
  else return PI + atan(y/x);
}
ArrayList<planetAgent> planetList = new ArrayList();
class planetAgent{
  
  float radius;
  float planetSize;
  float planetSpeed;
  float x;
  float y;
  float moonX;
  float moonY;
  color colOR;
  int planNumber;
  
  //This Will all be done with a moonAgent in the future, for now i'm lazy
  boolean moonEarth;
  boolean jupiterMoon;
  
  planetAgent(int index, float lowerPlanetBound, float upperPlanetBound){
    this.planNumber = index;
    this.colOR = color(random(50,200), random(50,200), random(50,200));
    float angle = random(2*PI);
    float CX = cos(angle);
    float SX = sin(angle);
    this.radius = (upperPlanetBound - lowerPlanetBound)*index/numPlanets + lowerPlanetBound;
    this.planetSize = random(5,20);
    this.x = this.radius*CX;
    this.y = this.radius*SX;
    
  }
  void update(){
    float angle = arctan(this.x, this.y);
    this.x = this.radius*cos(angle + planetSpeed);
    this.y = this.radius*sin(angle + planetSpeed);
    //Mercury
    if (this.planNumber == 0){
      this.planetSpeed = -0.008;
      this.planetSize = 3.85231;
      this.colOR = color(105,42,42);

    }
    //Venus
    else if (this.planNumber == 1){
      this.planetSpeed = -0.0006;
      this.planetSize = 4.1231;
      this.colOR = color(225,252,250);
    }
    //Earth
    else if (this.planNumber == 2){
      this.planetSpeed = -0.0009;
      this.planetSize = 8.64231;
      this.colOR = color(70, 150, 200);
      moonEarth = true;
    }
    //Mars
    else if (this.planNumber == 3){
      this.planetSpeed = -0.00065;
      this.planetSize = 4.54231;
      this.colOR = color(165,42,42);
      
    }
    //Jupiter
    else if (this.planNumber == 4){
      jupiterMoon = true;
      float jupX = this.x + width/2;
      float jupY = this.y + height/2;
      for (int i = 0; i < numJupiterMoons; i++) moonList.add(new moonAgent(i, innerOrbit, outerOrbit, jupX,jupY));
      this.planetSpeed = -0.00065;
      this.planetSize = 50;
      this.colOR = color(245,242,200);
      
    }
    //Saturn
    else if (this.planNumber == 5){
      this.planetSpeed = -0.00068;
      this.planetSize = 41;
      this.colOR = color(225,222,220);
      
    }
    //Uranus
    else if (this.planNumber == 6){
      this.planetSpeed = -0.00079;
      this.planetSize = 16;
      this.colOR = color(70, 150, 250);
      
    }
    //Neptune
    else if (this.planNumber == 7){
      this.planetSpeed = -0.0005;
      this.planetSize = 14;
      this.colOR = color(150, 150, 200);
      
    }
   for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if (pow(tmp.x - this.x - width/2, 2) + pow(tmp.y - this.y - height/2, 2) <= pow(this.planetSize/2, 2)) {
        emitterList.remove(i);
        this.planetSize += 0.000005;
      }
    }
    
    
  }
  void draw(){
    fill(this.colOR);
    ellipse(this.x + width/2,this.y + height/2,this.planetSize,this.planetSize);
   mRotate += TWO_PI/600;
   if (moonEarth ==true){
    fill(100); // defines fill color for shape
    ellipse(this.x + width/2 + sin(mRotate) * 10,this.y + height/2 + cos(mRotate) * 10  , 2.5, 2.5); 
   }
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////

ArrayList<moonAgent> moonList = new ArrayList();

class moonAgent{
  float radius;
  float moonSize;
  float moonSpeed;
  float moonX;
  float moonY;
  color colOR;
  float moonRotate;
  float planetX,planetY;
  
  moonAgent(int index, float outerOrbit, float innerOrbit, float jupX, float jupY){
    this.radius = (outerOrbit - innerOrbit)*index/numJupiterMoons + innerOrbit;
    this.planetX = jupX;
    this.planetY = jupY;
    this.moonX = radius*(jupX + sin(mRotate) * 10);
    this.moonY = radius*(jupY +cos(mRotate) * 10);
    
  }
  void update(){
    moonRotate += TWO_PI/600;
    this.moonX = radius*(planetX + sin(mRotate) * 10);
    this.moonY = radius*(planetY +cos(mRotate) * 10); 
  }
  void draw(){
    fill(255); // defines fill color for shape
    ellipse(moonX,moonY, 100.5, 100.5); // draws ellipse / moon
  }
  
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////

//Casting an Arraylist as the class, calling emits to create new list
ArrayList<emitter> emitterList = new ArrayList();

class emitter {
    //declaring variables of the particle to be emitted
    float Vx,Vy,x,y,rad;
    //Constructor for a new instance of a new particle
    emitter(float xCenter, float yCenter, float radius) {
      float speedMag = 3;
      float angle = random(2*PI);
      float CX = cos(angle);
      float SX = sin(angle);
      x = radius*CX + xCenter;
      y = radius*SX + yCenter;
      Vx = speedMag*CX;
      Vy = speedMag*SX;
      rad = 1.5;
    }
    
    int search(float X, float Y, float Vx, float Vy) {
      for (int i = 0; i < emitterList.size(); i++) {
       emitter tmp = emitterList.get(i);
       if (tmp.x == X && tmp.y == Y && tmp.Vx == Vx && tmp.Vy == Vy) return i;
      }
      // This case should never get called, throw a sentinel value
      return -1;
    }
    
    //changing the position of the emitted particle, based on velocity
    void update() {
      x += Vx;
      y += Vy;
      fill(255, 175, 0);
      //checking if the particle is offscreen
      if (x < 0 || x > width || y < 0 || y > height) {
        //Find index of this instance (its index)
        //adjust the arrays if the particle is gone
        int index = this.search(this.x, this.y, this.Vx, this.Vy);
        // emitter.remove(index) to remove this element from the list (since it is out of view)
        emitterList.remove(index);
        } 
      } 
    
    // drawing the particle
    void draw() {
      noFill();     
      fill(255, 175, 0);
      ellipse(x,y,rad,rad);
      
   }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////
starSun sun;

void setup() {
  noStroke();
  frameRate(60);
  sun = new starSun();
  fullScreen();
  
  for (int i = 0; i < numPlanets; i++) planetList.add(new planetAgent(i, lowerPlanetBound, upperPlanetBound));

}

float aBelt;
float aX;
float aY;
void draw () {
  background(0,13,71); 

  for (int i = 0; i < emitterList.size(); i++){
           //drawing a particle and updating
           emitter tmp = emitterList.get(i);
           tmp.update();
           tmp.draw();
  }  
 
  for (int i = 0; i < planetList.size(); i++ ) {
    planetAgent tmp = planetList.get(i);
    tmp.update();
    tmp.draw();
  }
  sun.update();
  sun.draw();
  
  for (int i = 0; i < moonList.size(); i++ ) {
    moonAgent tmp = moonList.get(i);
    tmp.update();
    tmp.draw();
  }
  
  x = width/2 + (sin(aBelt) * 450);
  y = height/2 + (cos(aBelt) * 450);
  //Asteroid Belt, will make it it's own class in the futre, but im lazy
  fill(120);
  ellipse(x,y,10,10);
  
  aBelt += TWO_PI/360; 
  
}
