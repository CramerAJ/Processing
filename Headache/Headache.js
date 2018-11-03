// Project #2: WTF is this?
// Setup for Project #2...
// I don't do code comments. Figure it out.

var angle = 0.0;
var scalar = 30;
var speed = 0.1;

function setup()
{
  //width & height (as variables)
  createCanvas(1466,868);
  background(0,0,0);
}


function draw()
{
  var time = millis();
  var one = 100;
  var two = 200;
  //var fast = 50;
  var rngred = random(0,255);
  var rnggreen = random(0,255);
  var rngblue = random(0,255);
  var rngredd = random(0,255);
  var rnggreenn = random(0,255);
  var rngbluee = random(0,255);
  
  if (time > one)
  {
    if (speed >= 25)
    {
      speed == 0;
      angle += 5;
      scalar += 0;
    }
    else if (speed <= 25)
    {
      angle += 10;
      scalar += 1;
      speed += 0.1;
    }
    else //if something fails, this should freeze it.
    {
      angle += 0;
      scalar += 0;
      speed += 0;
    }
  }
  for (var i = 0; i <=80; i += 0.5)
  {
    if (speed <= 24.5)
    {
    var x = mouseX + cos(angle) * scalar;
    var y = mouseY + sin(angle) * scalar;
    fill(255,0,0);
    stroke(0,255,255);
    ellipse(x, y, 40, 40);
    ellipse(x+i, y+i, 40, 40);
    ellipse(x-i, y-i, 40, 40);
    }
    else if (speed >= 24.5)
    {
    var x = mouseX + cos(angle) * scalar;
    var y = mouseY + sin(angle) * scalar;
    fill(rngred,rnggreen,rngblue);
    stroke(rngredd,rnggreenn,rngbluee);
    ellipse(x, y, 40, 40);
    ellipse(x+i, y+i, 40, 40);
    ellipse(x-i, y-i, 40, 40);
    }
    if (mouseIsPressed)
    {
    if (speed >= 25)
    {
      speed == 0;
      angle += -2;
      scalar += -0;
    }
    else if (speed <= 25)
    {
      angle += -1;
      scalar += -1.1;
      speed += 0.1;
    }
    else // it must continue no matter what.
    {
      angle += -5;
      scalar += -0.1;
      speed += 0;
    }
      
    var x = mouseX + cos(angle) * scalar;
    var y = mouseY + sin(angle) * scalar;
    fill(rngred,rnggreen,rngblue);
    stroke(rngredd,rnggreenn,rngbluee);
    ellipse(x, y, 40, 40);
    ellipse(x+i, y+i, 40, 40);
    ellipse(x-i, y-i, 40, 40);
      
    }
  }
}
