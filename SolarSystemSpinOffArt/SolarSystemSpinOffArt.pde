//Set Color Values: fill(r,g,b)
float white = 255;
float black = 0;

//Sun Energy
float startingEnergy = 50;
float maxSunEnergy = 75;
float solarWave = 1200;

//Smaller planet's energy
float planetDefault = 10;

// NEW
float planetsToStart = random(30,60);
float lowerPlanetRadius = 150;
float upperPlanetRadius = 500;

//Casting an Arraylist as the class, calling emits to create new list
ArrayList<emitter> emitterList = new ArrayList();
// NEW

ArrayList<planetAgent> planetList = new ArrayList();

// Custom arctan function
float arctan(float x, float y) {
  if (x > 0 && y < 0) return atan(y/x);
  if (x > 0 && y > 0) return 2*PI - atan(-y/x);
  if (x < 0 && y < 0) return PI + atan(y/x);
  else return PI + atan(y/x);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

//SunAgent
class sunAgent{
  
  //Setting the amount of particles it can have
  float sunCurrentEnergy;
  boolean goodColor;
 
  //Constructor for the class
  sunAgent(){
    //Setting the global to the current energy, and only changing the Current variable
     this.sunCurrentEnergy = startingEnergy;
     this.goodColor = false;
  }
    
  void update(){
   //CONDITIONS
   //Capturing radius as the starting energy
   if (mousePressed && goodColor){
     
     // grow condition is when mouse is pressed and inside
     if (pow(mouseX-width/2,2)+pow(mouseY-height/2,2) <= pow(this.sunCurrentEnergy, 2)/4) this.sunCurrentEnergy /= 1.03;
     else this.sunCurrentEnergy += 0.01;
     int numToEmit = floor(sunCurrentEnergy / 4);
     //new instance of emitter added to list
     //starting at 0, but adding a size of +1 to start at 1, when moving though, need to change indexes after that in the list
     for (int i = 0; i < numToEmit; i++) emitterList.add(new emitter(width/2, height/2, this.sunCurrentEnergy/2));
     
     // check to see if hit by emitters for Super(tm) sun punish!
     for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if (pow(tmp.x, 2) + pow(tmp.y, 2) <= pow(this.sunCurrentEnergy, 2)) {
        emitterList.remove(i);
        this.sunCurrentEnergy += .01;
      }
     }
   }
   
   // Lets punish when the sun isnt a good color
   else if (goodColor) {
     // flag to seeing if sun is hit while good color (multiplicity is ignored)
     boolean tmpFlag = false;
     for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if (pow(tmp.x, 2) + pow(tmp.y, 2) <= pow(this.sunCurrentEnergy,2)) {
        emitterList.remove(i);
        tmpFlag = true;
      }
     }
     
     // if sun was hit then grow quick
     //if (tmpFlag) this.sunCurrentEnergy += 0.5;
     // otherwise just do normal growth
     //this.sunCurrentEnergy += .35;
   }
   
   else if(random(100) < 2){
     for (int i = 0; i < solarWave; i++) emitterList.add(new emitter(width/2, height/2, 10));
   }
   
   else {
     this.sunCurrentEnergy += .15;
     if (this.sunCurrentEnergy >=maxSunEnergy){
       this.sunCurrentEnergy -= 5;
     }
   }
   //random choose a number 2% of the time and allow the user to click on the sun
   //if (random(100) < 10 && !mousePressed) goodColor = !goodColor;
  }
  void draw(){
    //color change
    if (goodColor) fill(white,white,white,white);
    //starting color is black
    else fill(black,black,black);
    
    //slightOrbit(vals,vals);
    
    ellipse(width/2,height/2,this.sunCurrentEnergy,this.sunCurrentEnergy);
      
    fill(white,white,white);
    
    //A Few Text Stats
    //textSize(10);
    //SunEnergySize
    //text(sunCurrentEnergy,width/16,height/16);
    //Amount of particles
    //text(emitterList.size(), width/16, height/13);

  }  
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

//PlanetAgent

class planetAgent{
  //set to default planet size
  float planetRadius = planetDefault;
  float radius;
  float planetSpeed;
  float x;
  float y;
  color colOR;
  
  planetAgent(int index, float lowBound, float uppBound) {
    // y = mx + b
    this.colOR = color(random(75,225), random(75,225), random(75,225));
    float angle = random(2*PI);
    float CX = cos(angle);
    float SX = sin(angle);
    this.radius = (uppBound - lowBound)*index/planetsToStart + lowBound;
    this.x = this.radius*CX;
    this.y = this.radius*SX;
    this.planetSpeed = random(0.001,0.015);
  } 

  void update() {
    float angle = arctan(this.x, this.y);
    this.x = this.radius*cos(angle + planetSpeed);
    this.y = this.radius*sin(angle + planetSpeed);
    
    // emitter collisions
    for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if (pow(tmp.x - this.x - width/2, 2) + pow(tmp.y - this.y - height/2, 2) <= pow(this.planetRadius/2, 2)) {
        emitterList.remove(i);
        this.planetRadius += 0.05;
        this.planetSpeed += 0.0001;
      }
    }
    
    // Lets check for planet collisions ;)
    for (int i = 0; i < planetList.size(); i++) {
      planetAgent tmp = planetList.get(i);
      // check to make sure planet doesnt collide with itself
      if (tmp.planetRadius >= 65){
        planetList.remove(tmp);
        for (int j = 0; j < floor(this.planetRadius*2); j++) 
          emitterList.add(new emitter(this.x + width/2, this.y + height/2, this.planetRadius/2));
      }
      else if (tmp.x != this.x && tmp.y != this.y) {
        // check to see if other planet is in radius
        if (pow(tmp.x - this.x, 2) + pow(tmp.y - this.y, 2) <= pow(this.planetRadius + tmp.planetRadius, 2)/4) {
          // destroy planet and explode
          planetList.remove(i);
          for (int j = 0; j < floor(this.planetRadius*2); j++) 
          emitterList.add(new emitter(this.x + width/2, this.y + height/2, this.planetRadius/2));
        }
      }
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

  void draw(){
    fill(this.colOR);
    ellipse(this.x + width/2,this.y + height/2,planetRadius,this.planetRadius);

  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

class emitter {
    //declaring variables of the particle to be emitted
    float Vx,Vy,x,y,rad;
    //Constructor for a new instance of a new particle
    emitter(float xCenter, float yCenter, float radius) {
      float speedMag = random(2);
      float angle = random(2*PI);
      float CX = cos(angle);
      float SX = sin(angle);
      x = radius*CX + xCenter;
      y = radius*SX + yCenter;
      Vx = speedMag*CX;
      Vy = speedMag*SX;
      rad = 2;
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
      //fill(random(255),random(255),random(255));
      fill(black,black,black);
      ellipse(x,y,rad,rad);
      
   }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

sunAgent sun;
void setup(){
  //Deleteing the line around the ellipses
  noStroke();
  size(1080,675);
  fill(white,white,white);
  frameRate(30);
  sun = new sunAgent();
  background(255);
  
  // NEW
  for (int i = 0; i < planetsToStart; i++) planetList.add(new planetAgent(i, lowerPlanetRadius, upperPlanetRadius));
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

void draw(){
  
  for (int i = 0; i < emitterList.size(); i++){
           //drawing a particle and updating
           emitter tmp = emitterList.get(i);
           tmp.update();
           tmp.draw();
  }
 
  // NEW
  for (int i = 0; i < planetList.size(); i++ ) {
    planetAgent tmp = planetList.get(i);
    tmp.update();
    tmp.draw();
  }
  if (planetList.size()<=40){
    for (int i = 0; i < planetsToStart/2; i++) planetList.add(new planetAgent(i, lowerPlanetRadius, upperPlanetRadius));
    
  }
    
  
  sun.update();
  sun.draw();
}
