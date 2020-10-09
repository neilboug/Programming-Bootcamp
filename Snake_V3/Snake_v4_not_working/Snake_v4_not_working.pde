import java.util.List;
// For movement
int angle = 0;
int speed = 0;
// For the gameplay
PImage grass;
boolean redo = true;
boolean stopGame = false;
// For the actual snake
int snakeLength = 5;
List<Integer> headX = new ArrayList<Integer>();
List<Integer> headY = new ArrayList<Integer>();
// For the apple
int appleX = (round (random (50)) + 1) * 8;
int appleY = (round (random (50)) + 1) * 8;


void setup()
{
  restart ();
  size (400, 400);    // Gameboard size (the smaller, the harder)
  grass = loadImage("grass_snake.png");
  background(grass);
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
  fill (#198301);
  noStroke ();
  rect (0, 0, width, 8);             // Upper
  rect (0, height - 8, width, 8);    // Lower
  rect (0, 0, 8, height);            // Left
  rect (width - 8, 0, 8, height);    // Right
    
  if (( speed % 6) == 0)    // Controls the snake's speed (the lower, the harder)
  {
    move();
    snake();
    death();
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
  
 
void move()
{
  for (int i = snakeLength; i > 0; i --)    // Loops for the creation of the snake
  {
    if (i != 1)    // Auto-forward
    {
     if (!headX.isEmpty() && !headY.isEmpty()) { 
       headX.set(i, headX.get(i-1));
       headY.set(i, headY.get(i-1));
       int lastEl = headX.size()-1;
       headX.remove(lastEl);
      

    }}
    else
    {
      switch (angle)
      {
        case 0:
        if (!headX.isEmpty()) {headX.set(1, headX.get(1)+ 8);}
        break;
        case 90:
        if (!headY.isEmpty()) {headY.set(1, headY.get(1)- 8);}
        break;
        case 180:
        if (!headX.isEmpty()) {headX.set(1, headX.get(1)- 8);}
        break;
        case 270:
        if (!headY.isEmpty()) {headY.set(1, headY.get(1)+ 8);}
        break;
      }
    }
  }

}


void snake()    // Displays the snake
{
  if (!headX.isEmpty() && !headY.isEmpty())
  {
  if (headX.get(1) == appleX && headY.get(1) == appleY)
  {
    snakeLength += round (random (3) + 1);
    redo = true;
    while (redo)
    {
      appleX = (round (random (47)) + 1) * 8;
      appleY = (round (random (47)) + 1) * 8;
      for (int i = 1; i < snakeLength; i ++)
      {
        if (appleX == headX.get(i) && appleY == headY.get(i))
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
    rect (headX.get(1), headY.get(1), 8, 8);
    rect (headX.get(snakeLength), headY.get(snakeLength), 8, 8);
    fill (255);
  
  

  }
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


void death()    // Method to check the snake's statue 
{
  if (!headX.isEmpty() && !headY.isEmpty())
  {
  for (int i = 2; i <= snakeLength; i ++)
  {
    if (headX.get(1) == headX.get(i) && headY.get(1) == headY.get(i))
    {
      gameOver();
    }
    if (headX.get(1) >= (width - 8) || headY.get(1) >= (height - 8) || headX.get(1) <= 0 || headY.get(1) <= 0)
    {
      gameOver();
    }
  }
  }
}
 

void restart ()    // Restart method
{
  grass = loadImage("grass_snake.png");
  background (grass);
  if (!headX.isEmpty() && !headY.isEmpty())
  {
    headX.set(1, 200); 
    headY.set(1, 200);
  }
  for (int i = 2; i < 1000; i ++)
  {
    if (!headX.isEmpty() && !headY.isEmpty()) 
     { 
       headX.set(i, 0);
       headY.set(i, 0);
     }
  }
  stopGame = false;
  appleX = (round (random (47)) + 1) * 8;
  appleY = (round (random (47)) + 1) * 8;
  snakeLength = 5;
  speed = 0;
  angle = 0;
  redo = true;
}
 
