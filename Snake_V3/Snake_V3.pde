// For movement
int angle = 0;
int speed = 0;
// For the gameplay
boolean redo = true;
boolean stopGame = false;
// For the actual snake
int snakeLength = 5;
int [] headX = new int [2500];
int [] headY = new int [2500];
// For the apple

int appleX = (round (random (47)) + 1) * 8;
int appleY = (round (random (47)) + 1) * 8;


void setup()
{
  restart ();
  size (400, 400);    // Gameboard size (the smaller, the harder)
  background(255);
  textAlign (CENTER);
}

void draw()
{
  if (stopGame)
  {
  }
  
  else
  {
  speed += 1;
// Parameters for the apple
  fill (#FF0000);
  noStroke ();
  rect (appleX, appleY, 8, 8);    // Size
  
// Parameters for the gameboard limits  
  fill (#1A9300);
  noStroke ();
  rect (0, 0, width, 8);             // Upper
  rect (0, height - 8, width, 8);    // Lower
  rect (0, 0, 8, height);            // Left
  rect (width - 8, 0, 8, height);    // Right
    
  if (( speed % 6) == 0)    // Controls the snake's speed (the lower, the harder)
  {
    travel();
    snake();
    checkDead();
  }
  }  
}


 void keyPressed()    // Game keyboard keys
{
  if (keyPressed)
  {
    if ((key == 'w' || key == 'W') && angle != 270)  {         // Go forward
      angle = 90;
    } 
    else if ((key == 's' || key == 'S') && angle != 90)  {     // Go downward
      angle = 270;
    }
    else if ((key == 'a' || key == 'A') && angle != 0)  {      // Go left
      angle = 180;
    }
    else if ((key == 'd' || key == 'D') && angle != 180)  {    // Go right
      angle = 0;
    }
    else if (key == 'n' || key == 'N')  {                      // Restart the game
      restart();
    }
  }
} 
  
 
 
void travel()
{
  for (int i = snakeLength; i > 0; i --)    // Loops for the creation of the snake
  {
    if (i != 1)
    {
      headX [i] = headX [i - 1];
      headY [i] = headY [i - 1];
    }
    else
    {
      switch (angle)
      {
        case 0:
        headX [1] += 8;
        break;
        case 90:
        headY [1] -= 8;
        break;
        case 180:
        headX [1] -= 8;
        break;
        case 270:
        headY [1] += 8;
        break;
      }
    }
  }
}


void snake()    // Displays the snake
{
  if (headX [1] == appleX && headY[1] == appleY)
  {
    snakeLength += round (random (3) + 1);
    redo = true;
    while (redo)
    {
      appleX = (round (random (47)) + 1) * 8;
      appleY = (round (random (47)) + 1) * 8;
      for (int i = 1; i < snakeLength; i ++)
      {
        if (appleX == headX [i] && appleY == headY [i])
        {
          redo = true;
        }
        else
        {
          redo = false;
          i = 1000;
        }
      }
    }
  }
  noStroke ();
  fill (0);
  rect (headX [1], headY [1], 8, 8);
  fill (255);
  rect (headX [snakeLength], headY [snakeLength], 8, 8);
}

void gameOver() 
{
  fill (255);
  rect (125, 125, 160, 100);
  fill (0);
  textSize (20);
  text ("GAME OVER", width/2, height/2);
  text ("SCORE:  " + str (snakeLength - 1), width/2, height/4);
  text ("PRESS 'N' TO TRY AGAIN", width/2, height/6);
  stopGame = true;
}


void checkDead()    // Method to check the snake's statue 
{
  for (int i = 2; i <= snakeLength; i ++)
  {
    if (headX [1] == headX [i] && headY [1] == headY [i])
    {
      gameOver();
    }
    if (headX[1] >= (width - 8) || headY[1] >= (height - 8) || headX[1] <= 0 || headY[1] <= 0)
    {
      gameOver();
    }
  }
}
 

void restart ()    // Restart method
{
  background(255);
  headX [1] = 200;
  headY [1] = 200;
  for (int i = 2; i < 1000; i ++)
  {
    headX [i] = 0;
    headY [i] = 0;
  }
  stopGame = false;
  appleX = (round (random (47)) + 1) * 8;
  appleY = (round (random (47)) + 1) * 8;
  snakeLength = 5;
  speed = 0;
  angle = 0;
  redo = true;
}
 
