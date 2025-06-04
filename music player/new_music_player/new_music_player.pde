// Library - Minim
import ddf.minim.*;

// Global Variables
Minim minim;
AudioPlayer song;

float divX, divY, divWidth, divHeight;
float musicButtonX, musicButtonY, musicButtonWidth, musicButtonHeight;

void setup() {
  fullScreen(); // Set to full screen

  // Initialize Minim and load the audio file
  minim = new Minim(this);
  song = minim.loadFile("song.mp3"); // Ensure "song.mp3" is in the "data" folder

  int appWidth = displayWidth;
  int appHeight = displayHeight;

  // Calculate dimensions for the main container
  divX = appWidth * 0.25;
  divY = appHeight * 0.25;
  divWidth = appWidth * 0.5;
  divHeight = appHeight * 0.5;

  float smallerSide = min(divWidth, divHeight);

  // Music button area dimensions
  musicButtonX = divX;
  musicButtonY = divY;
  musicButtonWidth = smallerSide;
  musicButtonHeight = smallerSide;
}

void draw() {
  background(255); // White background

  // Draw main container
  fill(230);
  rect(divX, divY, divWidth, divHeight);

  // Calculate spacing
  int numButtons = 11;
  float buttonSpacing = musicButtonWidth / numButtons;

  // Loop to draw 11 button pairs
  for (int i = 0; i < numButtons; i++) {
    float xOffset = musicButtonX + i * buttonSpacing;

    // Draw button background area
    fill(200);
    rect(xOffset, musicButtonY, buttonSpacing, musicButtonHeight);

    // Smaller play button
    float thisPlayX = xOffset + buttonSpacing * 0.15;
    float thisPlayY = musicButtonY + musicButtonHeight * 0.7;
    float thisPlayW = buttonSpacing * 0.25;
    float thisPlayH = musicButtonHeight * 0.15;

    fill(0, 255, 0);
    rect(thisPlayX, thisPlayY, thisPlayW, thisPlayH);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(12);
    text("Play", thisPlayX + thisPlayW / 2, thisPlayY + thisPlayH / 2);

    // Smaller stop button
    float thisStopX = thisPlayX + buttonSpacing * 0.35;
    float thisStopY = thisPlayY;
    float thisStopW = thisPlayW;
    float thisStopH = thisPlayH;

    fill(255, 0, 0);
   float thisPauseX = thisStopX + buttonSpacing * 0.35;
float thisPauseY = thisPlayY;
float thisPauseW = thisPlayW;
float thisPauseH = thisPlayH;

// Insert this new code at line 77:
fill(255, 255, 0); // Yellow background
rect(thisPauseX, thisPauseY, thisPauseW, thisPauseH);

// Draw pause icon (two bars)
float barWidth = thisPauseW * 0.2;
float gap = thisPauseW * 0.1;
float barHeight = thisPauseH * 0.6;
float barY = thisPauseY + (thisPauseH - barHeight) / 2;

fill(0);
rect(thisPauseX + thisPauseW * 0.25, barY, barWidth, barHeight);
rect(thisPauseX + thisPauseW * 0.55, barY, barWidth, barHeight);

  }
}

void mousePressed() {
  int numButtons = 11;
  float buttonSpacing = musicButtonWidth / numButtons;

  for (int i = 0; i < numButtons; i++) {
    float xOffset = musicButtonX + i * buttonSpacing;

    float thisPlayX = xOffset + buttonSpacing * 0.15;
    float thisPlayY = musicButtonY + musicButtonHeight * 0.7;
    float thisPlayW = buttonSpacing * 0.25;
    float thisPlayH = musicButtonHeight * 0.15;

    float thisStopX = thisPlayX + buttonSpacing * 0.35;
    float thisStopY = thisPlayY;
    float thisStopW = thisPlayW;
    float thisStopH = thisPlayH;

    // Check play button click
    if (mouseX > thisPlayX && mouseX < thisPlayX + thisPlayW &&
        mouseY > thisPlayY && mouseY < thisPlayY + thisPlayH) {
      if (!song.isPlaying()) {
        song.rewind();
        song.play();
      }
    }

    // Check stop button click
    if (mouseX > thisStopX && mouseX < thisStopX + thisStopW &&
        mouseY > thisStopY && mouseY < thisStopY + thisStopH) {
      if (song.isPlaying()) {
        song.pause();
        song.rewind();
      }
    }
  }
}

void stop() {
  // Close audio resources
  song.close();
  minim.stop();
  super.stop();
}
