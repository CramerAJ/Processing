float numBalls = random(45,60);
float ballSize = random(15,25);
float ballLowBound = 15;
float ballUpBound = 250;

ArrayList<ballAgent> ballList = new ArrayList();


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
class ballAgent{
  //set to default planet size
  float ballRadius = random(25,50);
  float radius;
  float ballSpeed;
  float x;
  float y;
  float startX;
  float startY;
  color colOR;
  color startColor=color(random(75,225), random(75,225), random(75,225));
  
  
  ballAgent(int index,float lowBound, float upBound){
    this.colOR = color(random(75,225), random(75,225), random(75,225));
    float angle = random(2*PI);
    float CX = cos(angle);
    float SX = sin(angle);
    this.radius = (upBound - lowBound)*index/ballSize + lowBound;
    this.startX = this.radius*CX;
    this.startY = this.radius*SX;
    this.x = this.radius*CX;
    this.y = this.radius*SX;
    this.ballSpeed = 0.0004;
  } 
  
    void update() {
    float angle = arctan(this.x, this.y);
    this.x = this.radius*cos(angle + ballSpeed);
    this.y = this.radius*sin(angle + ballSpeed);
    this.colOR = startColor;
    this.ballSpeed += 0.00002;
    
   for (int i = 0; i < ballList.size(); i++) {
      ballAgent tmp = ballList.get(i);
      if(tmp.x != this.x && tmp.y != this.y){
        if (pow(tmp.x - this.x, 2) + pow(tmp.y - this.y, 2) <= pow(this.ballRadius + tmp.ballRadius, 2)/4) {
          this.colOR = color(25,25,25);
          this.ballSpeed -= 0.0001;
      }
    }
      else if(tmp.ballSpeed >=5){
        this.ballSpeed = random(0.00001,0.0001);
      }
      else if(tmp.ballSpeed >= 1.1){
        this.colOR = color(random(75,225), random(75,225), random(75,225));
   }
 }
 }
  
  
  void draw(){
    fill(this.colOR);
    ellipse(this.x + width/4,this.y + height/4,ballRadius,this.ballRadius);
    
    //Made three more instances, but they arn't unique
    ellipse(this.x + width/2+width/4,this.y + height/4,ballRadius,this.ballRadius);
    ellipse(this.x + width/4,this.y + height/2+height/4,ballRadius,this.ballRadius);
    ellipse(this.x + width/2+width/4,this.y + height/2+height/4,ballRadius,this.ballRadius);
  }
}

float lineLength = 25;
float lineWidth = 15;
float lineHeight = 10;
  
 
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////
void setup(){
  fullScreen();
  background(0);
  noStroke();
  for (int i = 0; i < numBalls; i++) ballList.add(new ballAgent(i , ballLowBound, ballUpBound));
  
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////
void draw(){

  stroke(255,255,255);
  //line(mouseX, mouseY, pmouseX, pmouseY);
    
    
  //Drawing Balls
  for (int i = 0; i < ballList.size(); i++ ) {
    ballAgent tmp = ballList.get(i);
    tmp.update();
    tmp.draw();
  }
  
 
}
