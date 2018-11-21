float rotate = 0; // incremental position of second minute / earth
float mRotate = 0;  // incremental position of millisecond clock / moon
float x, y; // float values for position of earth

float earthMoonX, earthMoonY; 
float marsMoonX, marsMoonY;
float jupiterMoonX,jupiterMoonY;

float startingEnergy = 55;

float numPlanets = random(10,15);

float lowerPlanetBound = 75;
float upperPlanetBound = 300;

///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////

class starSun{
  //Num of particles made per frame;
  float particlesMade = 4000;
 //Setting the amount of particles it can have
  float sunCurrentEnergy;
  //Constructor for the class
  float xPosi;
  float yPosi;
  color colOR;
  starSun(int index, float xPos,float yPos,color sunColor){
    //Setting the global to the current energy, and only changing the Current variable
     this.colOR = sunColor;
     this.sunCurrentEnergy = startingEnergy;
     this.xPosi = xPos;
     this.yPosi = yPos;
  }
  void update(){
  

    if(random(1000) < 10){
     for (int i = 0; i < particlesMade; i++) {
     emitterList.add(new emitter(xPosi, yPosi, this.sunCurrentEnergy/2,this.colOR));
   }
    }
    for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if ((pow(tmp.x - this.xPosi, 2) + pow(tmp.y - this.yPosi, 2) <= pow(this.sunCurrentEnergy/2, 2))) {
        emitterList.remove(i);

      } 
    }
   
    
  }
  void draw(){
    //color change
    //starting color is black
    fill(colOR);
    ellipse(xPosi,yPosi,this.sunCurrentEnergy,this.sunCurrentEnergy);
    
  }
}

float arctan(float x, float y) {
  if (x > 0 && y < 0) return atan(y/x);
  if (x > 0 && y > 0) return 2*PI - atan(-y/x);
  if (x < 0 && y < 0) return PI + atan(y/x);
  else return PI + atan(y/x);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////



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
  
  
  planetAgent(int index, float lowerPlanetBound, float upperPlanetBound){
    this.planNumber = index;
    this.colOR = color(150);
    float angle = random(2*PI);
    float CX = cos(angle);
    float SX = sin(angle);
    this.radius = (upperPlanetBound - lowerPlanetBound)*index/numPlanets + lowerPlanetBound;
    this.planetSize = random(5,20);
    this.x = this.radius*CX;
    this.y = this.radius*SX;
    this.planetSpeed = random(0.01,0.05);

    
  }
  void update(){
    
    
    float angle = arctan(this.x, this.y);
    this.x = this.radius*cos(angle + planetSpeed);
    this.y = this.radius*sin(angle + planetSpeed);
    
   for (int i = 0; i < emitterList.size(); i++) {
      emitter tmp = emitterList.get(i);
      if ((pow(tmp.x - this.x - width/2, 2) + pow(tmp.y - this.y - height/2, 2) <= pow(this.planetSize/2, 2))) {
        emitterList.remove(i);
        this.planetSize += 0.00025;
      } 
    }
    

  }
  void draw(){
   fill(this.colOR);
   ellipse(this.x +width/2,this.y+height/2, this.planetSize,this.planetSize);
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
    color cOLOR;
    //Constructor for a new instance of a new particle
    emitter(float xCenter, float yCenter, float radius,color colOR) {
      this.cOLOR = colOR;
      float speedMag = 3;
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
      fill(this.cOLOR);
      ellipse(x,y,rad,rad);
      
   }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////
starSun sun1;
starSun sun2;
starSun sun3;
starSun sun4;
starSun sun5;

void setup() {
  noStroke();

  
  sun1 = new starSun(1, width/2,height/2,color(255,0,0));

  sun3 = new starSun(1, width/4,height/2+height/4,color(0,255,0));

  sun5 = new starSun(1, width/2+width/4,height/4,color(0,0,255));
  
  fullScreen();
  for (int i = 0; i < numPlanets; i++) planetList.add(new planetAgent(i, lowerPlanetBound, upperPlanetBound));

}

float aBelt;
float aX;
float aY;
void draw () {
  background(255); 

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

  sun1.update();
  sun1.draw();
  

  
  sun3.update();
  sun3.draw();
  
 
  
  sun5.update();
  sun5.draw();

  
}
