/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////
void setup(){
  noStroke();
  size(1080,775);
  frameRate(40);
  background(150);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////
void draw(){
  
  if (mousePressed){
     confettiList.add(new confetti(mouseX, mouseY,5));
  }
  background(250);
    
  ellipse(mouseX,mouseY,20,20);
  fill(255,255,255);
  
  for (int i = 0; i < confettiList.size(); i++){
           //drawing a particle and updating
           confetti tmp = confettiList.get(i);
           tmp.update();
           tmp.draw();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

class catcher{
   float Vx,Vy,x,y,rad;
     
   catcher(float xCenter, float yCenter, float radius) {
     float speedMag = 6;
     //We use PI to have the illusion they are falling
     float angle = random(PI/2);
     float CX = cos(angle);
     float SX = sin(angle);
     x = radius*CX + xCenter;
     y = radius*SX + yCenter;
     Vx = speedMag*CX;
     Vy = speedMag*SX;
      
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

ArrayList<confetti> confettiList = new ArrayList();

class confetti {
    float Vx,Vy,x,y,rad;
    
    confetti(float xCenter, float yCenter, float radius) {
      float speedMag = random(2);
      //We use PI to have the illusion they are falling
      float angle = random(PI);
      float CX = cos(angle);
      float SX = sin(angle);
      x = radius*CX + xCenter;
      y = radius*SX + yCenter;
      Vx = speedMag*CX;
      Vy = speedMag*SX;
      
    }
    
    int search(float X, float Y, float Vx, float Vy) {
      for (int i = 0; i < confettiList.size(); i++) {
       confetti tmp = confettiList.get(i);
       if (tmp.x == X && tmp.y == Y && tmp.Vx == Vx && tmp.Vy == Vy) return i;
      }
      return -1;
    }
    void update() {
      x += Vx;
      y += Vy;
      
      if (x < 0 || x > width || y < 0 || y > height) {
        int index = this.search(this.x, this.y, this.Vx, this.Vy);
        confettiList.remove(index);
      }
    }
    void draw() {
      fill(random(255),random(255),random(255));
      ellipse(x,y,random(2,6),random(2,6));
      
   }
}
