
/* Button Template: all buttons
 - TBA
 */
//
//Library - minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
float divX, divY, divWidth, divHeight;
float musicButtonX, musicButtonY, musicButtonWidth, musicButtonHeight;
float stopX, stopY, stopWidth, stopHeight;
//
void setup() {
  //Display
  fullScreen(); //displayWidth, displayHeight
  int appWidth = displayWidth;
  int appHeight = displayHeight;
  //
  //Population
  divX = appWidth*1/4;
  divY = appHeight*1/4;
  divWidth = appWidth*1/2;
  divHeight = appHeight*1/2;
  float smallerSide = ( divWidth < divHeight ) ? divWidth : divHeight ; //Ternary Operator
  musicButtonX = divX;
  musicButtonY = divY;
  musicButtonWidth = smallerSide;
  musicButtonHeight = smallerSide;
  stopX = musicButtonX + musicButtonWidth*1/4;
  stopY = musicButtonY + musicButtonHeight*1/4;
  stopWidth = musicButtonWidth*1/2;
  stopHeight = musicButtonHeight*1/2;
  //
  //DIV: musicButtonDIV
  //rect(X, Y, Width, Height);
  //rect(x, Y, Width, Height);
  rect(divX, divY, divWidth, divHeight);
  rect(musicButtonX, musicButtonY, musicButtonWidth, musicButtonHeight);
  //Shapes to turn off
  rect(stopX, stopY, stopWidth, stopHeight);
  //PLAY
  //FAST FORWARD
  //PAUSE
  rect(stopX, stopY, stopWidth, stopHeight);
  //triangle(PlayX1 0.25,PlayY1 0.25, PlayX2 0.25,Play Y2 0.75,Play X3 0.75,Play Y3 0.50);
  //triangle(fastForwardX1, fastForwardY1, fastForwardX2, fastForwardY2, fastForwardX3, fastForwardY3);
  //triangle(fastForwardX4, fastForwardY4, fastForwardX5, fastForwardY5, fastForwardX6, fastForwardY6);
  //rect(pauseX1, pauseY1, pauseWidth1, pauseHeight1);
  //rect(pauseX2, pauseY2, pauseWidth2, pauseHeight2);
} //End setup
//
void draw() {
} //End draw
//
void mousePressed() {
} //End mousePressed
//
void keyPressed() {
} //End keyPressed
//
//End MAIN Program
