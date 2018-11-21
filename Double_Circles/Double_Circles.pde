//Set Color Values: fill(r,g,b)
float white = 255;
float black = 0;

//Smaller planet's energy
float planetDefault = 10;

// NEW
float planetsToStart = random(35,60);
float lowerPlanetRadius = 250;
float upperPlanetRadius = 450;

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

//PlanetAgent

class planetAgent{
  //set to default planet size
  float planetRadius = planetDefault;
  float radius;
  float planetSpeed;
  float x;
  float y;
  color colOR;
  boolean leftOrRight;
  
  planetAgent(int index, float lowBound, float uppBound) {
    // y = mx + b
    this.colOR = color(random(75,225), random(75,225), random(75,225));
    float angle = random(2*PI);
    float CX = cos(angle);
    float SX = sin(angle);
    this.radius = (uppBound - lowBound)*index/planetsToStart + lowBound;
    this.x = this.radius*CX;
    this.y = this.radius*SX;
    this.planetSpeed = random(0.01,0.1);
    
  } 

  void update() {
    float angle = arctan(this.x, this.y);
    this.x = this.radius*cos(angle + planetSpeed);
    this.y = this.radius*sin(angle + planetSpeed);
    
    // emitter collisions
    for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if (pow(tmp.x - this.x - width/4, 2) + pow(tmp.y - this.y - height/2, 2) <= pow(this.planetRadius/2, 2)) {
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
          emitterList.add(new emitter(this.x + width/4, this.y + height/2, this.planetRadius/2));
      }
      else if (tmp.x != this.x && tmp.y != this.y) {
        // check to see if other planet is in radius
        if (pow(tmp.x - this.x, 2) + pow(tmp.y - this.y, 2) <= pow(this.planetRadius + tmp.planetRadius, 2)/4) {
          // destroy planet and explode
          planetList.remove(i);
          for (int j = 0; j < floor(this.planetRadius*2); j++) 
          emitterList.add(new emitter(this.x + width/4, this.y + height/2, this.planetRadius/2));
        }
      }
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

  void draw(){
    fill(this.colOR);
    ellipse(this.x + width/4,this.y + height/2,planetRadius,this.planetRadius);
    ellipse(this.x + width/2+width/4,this.y + height/2,planetRadius,this.planetRadius);

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
      fill(100,100,100);
      ellipse(x,y,rad,rad);
      
   }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////


void setup(){
  //Deleteing the line around the ellipses
  noStroke();
  fullScreen();
  fill(white,white,white);
  frameRate(30);

  background(255);
  
  // NEW
  for (int i = 0; i < planetsToStart; i++) planetList.add(new planetAgent(i, lowerPlanetRadius, upperPlanetRadius));
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

void draw(){
  
  //background(255);
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
    for (int i = 0; i < planetsToStart; i++) planetList.add(new planetAgent(i, lowerPlanetRadius, upperPlanetRadius));
    }
    
}
