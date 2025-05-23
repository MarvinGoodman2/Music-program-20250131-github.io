// Library - Minim
import ddf.minim.*;

// Global Variables
Minim minim;
AudioPlayer song;

float divX, divY, divWidth, divHeight;
float musicButtonX, musicButtonY, musicButtonWidth, musicButtonHeight;
float playX, playY, playWidth, playHeight;
float stopX, stopY, stopWidth, stopHeight;

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

  // Music button dimensions
  musicButtonX = divX;
  musicButtonY = divY;
  musicButtonWidth = smallerSide;
  musicButtonHeight = smallerSide;

  // Play button dimensions
  playX = musicButtonX + musicButtonWidth * 0.15;
  playY = musicButtonY + musicButtonHeight * 0.25;
  playWidth = musicButtonWidth * 0.3;
  playHeight = musicButtonHeight * 0.5;

  // Stop button dimensions
  stopX = musicButtonX + musicButtonWidth * 0.55;
  stopY = musicButtonY + musicButtonHeight * 0.25;
  stopWidth = musicButtonWidth * 0.3;
  stopHeight = musicButtonHeight * 0.5;
}

void draw() {
  background(255); // White background

  // Draw main container
  fill(230);
  rect(divX, divY, divWidth, divHeight);

  // Draw music button area
  fill(200);
  rect(musicButtonX, musicButtonY, musicButtonWidth, musicButtonHeight);

  // Draw Play button
  fill(0, 255, 0); // Green color
  rect(playX, playY, playWidth, playHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Play", playX + playWidth / 2, playY + playHeight / 2);

  // Draw Stop button
  fill(255, 0, 0); // Red color
  rect(stopX, stopY, stopWidth, stopHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Stop", stopX + stopWidth / 2, stopY + stopHeight / 2);
}

void mousePressed() {
  // Check if Play button is clicked
  if (mouseX > playX && mouseX < playX + playWidth &&
      mouseY > playY && mouseY < playY + playHeight) {
    if (!song.isPlaying()) {
      song.rewind();
      song.play();
    }
  }

  // Check if Stop button is clicked
  if (mouseX > stopX && mouseX < stopX + stopWidth &&
      mouseY > stopY && mouseY < stopY + stopHeight) {
    if (song.isPlaying()) {
      song.pause();
      song.rewind();
    }
  }
}

void stop() {
  // Close audio resources
  song.close();
  minim.stop();
  super.stop();
}
