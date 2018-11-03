var mass = [];
var positionX = [];
var positionY = [];
var velocityX = [];
var velocityY = [];

//ArrayList<> particleList = new ArrayList();

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

function setup() {
  createCanvas(windowWidth, windowHeight);
  noStroke();
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

function draw() {
  //Random Color Background
  /*if(random(1000)< 5){
    background(random(0,255));
  }*/
  
  //Random Color Filler, does some cool shit when paired with the random background cooler
  /*if(random(1000)< 12){ 
    fill(random(70,255),random(70,255),random(70,255),random(55,2505));
  }*/
  
  
  background(40);
  fill(100,175,200,150);
  
  for (var particleA = 0; particleA < mass.length; particleA++) {
    var accelerationX = 0, accelerationY = 0;
    
    for (var particleB = 0; particleB < mass.length; particleB++) {
      if (particleA != particleB) {
        var distanceX = positionX[particleB] - positionX[particleA];
        var distanceY = positionY[particleB] - positionY[particleA];

        var distance = sqrt(distanceX * distanceX + distanceY * distanceY);
        if (distance < 1) distance = 1;

        var force = (distance - 320) * mass[particleB] / distance;
        accelerationX += force * distanceX;
        accelerationY += force * distanceY;
      }
    }
    
    velocityX[particleA] = velocityX[particleA] * 0.99 + accelerationX * mass[particleA];
    velocityY[particleA] = velocityY[particleA] * 0.99 + accelerationY * mass[particleA];
  }
  
  for (var particle = 0; particle < mass.length; particle++) {
    positionX[particle] += velocityX[particle];
    positionY[particle] += velocityY[particle];
    
    ellipse(positionX[particle], positionY[particle], mass[particle] * 1000, mass[particle] * 1000);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

function addNewParticle() {
  mass.push(random(0.006, 0.06));
  positionX.push(mouseX);
  positionY.push(mouseY);
  velocityX.push(0);
  velocityY.push(0);
  
  
  
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

function mouseClicked() {
  addNewParticle();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////

function mouseDragged() {
  addNewParticle();
}
