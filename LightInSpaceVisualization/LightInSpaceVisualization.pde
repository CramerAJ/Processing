float arctan(float x, float y) {
  if (x > 0 && y < 0) return atan(y/x);
  if (x > 0 && y > 0) return 2*PI - atan(-y/x);
  if (x < 0 && y < 0) return PI + atan(y/x);
  else return PI + atan(y/x);
}

class emitElipse{
 
  //Num of particles made per frame;
  float particlesMade = 1000;
  //Setting the amount of particles it can have
  float sunCurrentEnergy;
  float startingEnergy = 25;
  //Constructor for the class
  float xPosi;
  float yPosi;
  float xPosiUp;
  float yPosiUp;
  color colOR;
  float emitSpeed;
  float orbitBound;
  float lowerBound = 100;
  float upperBound = 150;
  float angle;
  
  
  emitElipse(float xPos,float yPos,color emitColor){
    //Setting the global to the current energy, and only changing the Current variable
     this.colOR = emitColor;
     this.angle = TWO_PI/360;
     float CX = cos(angle);
     float SX = sin(angle);
     this.sunCurrentEnergy = startingEnergy;
     this.emitSpeed = 0.1;
     this.orbitBound = (upperBound - lowerBound) + lowerBound;   
     this.xPosi = xPos;
     this.yPosi = yPos;
     this.xPosiUp = this.orbitBound*CX;
     this.yPosiUp = this.orbitBound*SX;
  
}
  
  void update(){
    this.angle += TWO_PI/360;
    this.xPosiUp = (cos(this.angle)*upperBound) +this.xPosi;
    this.yPosiUp = (sin(this.angle)*upperBound) +this.yPosi;
    
    if(random(1000) < 10){
     for (int i = 0; i < particlesMade; i++) {
     particleList.add(new particle(xPosiUp, yPosiUp, this.sunCurrentEnergy/2,this.colOR));
   }
    }
    for (int i = 0; i < particleList.size(); i++) {
      particle tmp = particleList.get(i);
      if ((pow(tmp.x - this.xPosiUp, 2) + pow(tmp.y - this.yPosiUp, 2) <= pow(this.sunCurrentEnergy/2, 2))) {
        particleList.remove(i);
      } 
    }   
  }
  void draw(){
    //color change
    //starting color is black
    fill(colOR);
    ellipse(xPosiUp,yPosiUp,this.sunCurrentEnergy,this.sunCurrentEnergy);
    
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////////




//Casting an Arraylist as the class, calling emits to create new list
ArrayList<particle> particleList = new ArrayList();

class particle {
    //declaring variables of the particle to be emitted
    float Vx,Vy,x,y,rad;
    color cOLOR;
    //Constructor for a new instance of a new particle
    particle(float xCenter, float yCenter, float radius,color colOR) {
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
      for (int i = 0; i < particleList.size(); i++) {
       particle tmp = particleList.get(i);
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

        int index = this.search(this.x, this.y, this.Vx, this.Vy);
        particleList.remove(index);
       
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

emitElipse emit1;
emitElipse emit2;
emitElipse emit3;

void setup() {
  noStroke();
  fullScreen();

  emit1 = new emitElipse(width/2,height/2, color(255,0,0));
  emit2 = new emitElipse(width/4,height/2+height/4, color(0,255,0));
  emit3 = new emitElipse(width/2+width/4,height/4, color(0,0,255));
}

void draw () {
  background(255); 

  for (int i = 0; i < particleList.size(); i++){
           //drawing a particle and updating
           particle tmp = particleList.get(i);
           tmp.update();
           tmp.draw();
  }  
 
  emit1.update();
  emit1.draw();
  
  emit2.update();
  emit2.draw();
  
  emit3.update();
  emit3.draw();

  
}
