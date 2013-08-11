// THIS IS GAME DESIGN!
// "Pong"
// J Matthew Griffis
// K Anthony Marefat

//NOTE: This game was made quick and dirty.
//The code is sloppy, and yours should be better.

//Game States are set with this variable
int level;  

//Ball Stuff
float ballX;
float ballY;
float ballXVel;
float ballYVel;
float ballSize;
float offScreenMargin;
float ballMaxSpeed;

//Our makeshift clock (Unorthodox)
float timeCount=0;

//Paddle Stats
int paddleWidth = 20;
int paddleHeight = 100;
int paddleSpeed = 5;

int score = 0;

int p1X;     //Left Paddle
int p1Y;

int p2X;      // Right Paddle
int p2Y;

int p3X;
int p3Y;        // Top Paddle  

int p4X;
int p4Y;        //Bottom Paddle

boolean p1UP = false;
boolean p1DOWN = false;

boolean p2UP = false;
boolean p2DOWN = false;

boolean p3LEFT = false;
boolean p3RIGHT = false;

boolean p4LEFT = false;
boolean p4RIGHT = false;

void setup() {
  size(600, 600);
  frameRate(60);
  smooth();
  p1X = 10;                         //Left Side
  p1Y = height/2-paddleHeight/2;    //Halfway Down

  p2X = width-paddleWidth-10;        //Right Side
  p2Y = height/2-paddleHeight/2;     //Halfway Down

  p3X = width/2;                    //Halfway Across
  p3Y = 10;                        //Top

  p4X = width/2;                    //Halfway Across
  p4Y = height-paddleWidth-10;      //Bottom

  ballX=width/2;
  ballY=height/2;
  //ballXVel=random(-5, 5);
  ballXVel= 1;
  ballYVel = 2;
  //ballYVel=random(-5, 5);
  ballSize=10;
  offScreenMargin = 500;
  ballMaxSpeed = 15;
}

void draw() {

  //TITLE SCREEN
  if (level==0) {
    background(0);
    textSize(40);
    text("Ready Player One", width/2-160, height/2+200);
    text("Press any key to start", width/2-200, height/2);
    if (keyPressed)level=1;
  }

  //GAME ON
  if (level==1) {
    background(0);

    //"Score"
    textSize(32);
    text(timeCount/60, 0, 30);
    text(score, 10, 70);
    timeCount++;


    //Draw the Paddles + Ball
    rect(p1X, p1Y, paddleWidth, paddleHeight);
    rect(p2X, p2Y, paddleWidth, paddleHeight);
    rect(p3X, p3Y, paddleHeight, paddleWidth);
    rect(p4X, p4Y, paddleHeight, paddleWidth);

    ellipse(ballX, ballY, ballSize, ballSize);

    //Update Ball
    ballX+=ballXVel;
    ballY+=ballYVel;

    if (ballX>width+offScreenMargin || ballX<-offScreenMargin || ballY<-offScreenMargin || ballY>height+offScreenMargin) {
      ballX=width/2;
      ballY=height/2;
      ballXVel=random(-5, 5);
      ballYVel=random(-5, 5);
      timeCount=0;
      score=0;
    }

    // PADDLE 1
    if (ballX-ballSize/2 <= p1X+paddleWidth &&    //If the left side of the ball hits the right edge of the paddle
    ballX+ballSize/2 >= p1X &&                  //From the Right 
    ballY+ballSize/2 >= p1Y &&                  //and the ball is beneath the top of the paddle
    ballY-ballSize/2 <= p1Y+paddleHeight) {     //and above the bottom of the paddle
      ballXVel *= -1.2;      //change direction and accelerate
      score++;                //add one to score
      //    ballYVel *= -1;
    }

    // PADDLE 2
    if (ballX+ballSize/2 >= p2X &&    //If the right end of the ball hits the left edge of the paddle
    ballX+ballSize/2 >= p2X &&      // From the left
    ballY+ballSize/2 >= p2Y &&      //and the ball is beneath the top of the paddle
    ballY-ballSize/2 <= p2Y+paddleHeight) {    //and above the bottom of the paddle
      ballXVel *= -1.2;
      score++;
    }

    // PADDLE 3
    if (ballX-ballSize/2 <= p3X+paddleHeight &&    //If the left end of the ball hits the left of the right end of the paddle
    ballX+ballSize/2 >= p3X &&                  //If the right end of the ball is to the right of the left end of the paddle
    ballY+ballSize/2 >= p3Y &&                  //From underneath the paddle
    ballY-ballSize/2 <= p3Y+paddleWidth) {      //and underneath the bottom of the paddle
      ballYVel *= -1.2;
      score++;
    }

    // PADDLE 4
    if (ballX-ballSize/2 <= p4X+paddleHeight &&    //If the left end of the ball is to the left of the right end of the paddle
    ballX+ballSize/2 >= p4X &&                    //If the right end of the ball is to the right of the left end of the paddle
    ballY+ballSize/2 >= p4Y &&                    //The bottom of the ball is past the top of the paddle
    ballY-ballSize/2 <= p4Y+paddleWidth) {      //The top of the ball is above the top edge of the paddle
      ballYVel *= -1.2;
      score++;
    }

    // Limit the ball speed so it doesn't get too fast
    // for the collision detection:
    if (ballXVel > ballMaxSpeed) ballXVel = ballMaxSpeed;
    if (ballYVel > ballMaxSpeed) ballYVel = ballMaxSpeed;
    if (ballXVel < -ballMaxSpeed) ballXVel = -ballMaxSpeed;
    if (ballYVel < -ballMaxSpeed) ballYVel = -ballMaxSpeed;


    //MOVEMENT!!!!
    if (p1UP==true) {
      p1Y -= paddleSpeed;
    }

    if (p1DOWN==true) {
      p1Y += paddleSpeed;
    }

    if (p2UP==true) {
      p2Y -= paddleSpeed;
    }
    if (p2DOWN==true) {
      p2Y += paddleSpeed;
    }

    if (p3LEFT==true) {
      p3X -= paddleSpeed;
    }
    if (p3RIGHT==true) {
      p3X += paddleSpeed;
    }

    if (p4LEFT==true) {
      p4X -= paddleSpeed;
    }
    if (p4RIGHT==true) {
      p4X += paddleSpeed;
    }
  }
}

void keyPressed() {

  //PADDLE ONE (LEFT)
  if (key=='w' || key=='W') {
    p1UP = true;
  }
  if (key=='s' || key=='S') {
    p1DOWN = true;
  } 


  //PADDLE TWO(RIGHT)
  if (key==CODED) {
    if (keyCode==UP) {
      p2UP = true;
    }
    if (keyCode==DOWN) {
      p2DOWN = true;
    }
  }

  //PADDLE THREE (TOP)
  if (key=='a' || key=='A') {
    p3LEFT = true;
  }
  if (key=='d' || key=='D') {
    p3RIGHT = true;
  }

  //PADDLE FOUR (DOWN)

  if (key==CODED) {
    if (keyCode==LEFT) {
      p4LEFT = true;
    }
    if (keyCode==RIGHT) {
      p4RIGHT = true;
    }
  }
}

void keyReleased() {

  //PADDLE ONE (Left)
  if (key=='w' || key=='W') {
    p1UP = false;
  }
  if (key=='s' || key=='S') {
    p1DOWN = false;
  }  


  //PADDLE TWO(RIGHT)
  if (key==CODED) {

    if (keyCode==UP) {
      p2UP = false;
    }
    if (keyCode==DOWN) {
      p2DOWN = false;
    }
  }

  //PADDLE THREE (TOP)
  if (key=='a' || key=='A') {
    p3LEFT = false;
  }
  if (key=='d' || key=='D') {
    p3RIGHT = false;
  }

  //PADDLE FOUR (DOWN)

  if (key==CODED) {
    if (keyCode==LEFT) {
      p4LEFT = false;
    }
    if (keyCode==RIGHT) {
      p4RIGHT = false;
    }
  }
}

