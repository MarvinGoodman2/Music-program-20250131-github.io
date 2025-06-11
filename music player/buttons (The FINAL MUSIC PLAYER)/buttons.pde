import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*; // Import Minim library

Minim minim; // Declare Minim object
AudioPlayer player; // Declare AudioPlayer object
AudioPlayer[] playlist; // Array for playlist
int currentTrack = 0; // Index for the current track

boolean isMuted = false; // Mute toggle
float lastGain = 0; // Store last gain for unmuting
String[] trackNames = { "song1.mp3", "song2.mp3", "song3.mp3" };

float buttonY; // Button vertical position
String[] buttonLabels = { "Mute", "Shuffle", "Previous", "Play/Pause", "Next", "Loop", "Vol +", "Vol -" }; // Button labels
float buttonWidth = 100; // Button width
float buttonHeight = 50; // Button height

void setup() {
  size(800, 600); // Set canvas size
  minim = new Minim(this); // Initialize Minim

  // Load playlist
  playlist = new AudioPlayer[3];
  playlist[0] = minim.loadFile("song1.mp3");
  playlist[1] = minim.loadFile("song2.mp3");
  playlist[2] = minim.loadFile("song3.mp3");
  background(255); // White background
  // Draw banner
  fill(180, 220, 255); // Light blue banner
  noStroke();
  rect(0, 0, width, 60); // Top banner

  // Draw centered track name
  fill(0); // Black text
  textAlign(CENTER, CENTER);
  textSize(24);
  text("Now Playing: " + trackNames[currentTrack], width / 2, 30);




  player = playlist[currentTrack]; // Start with the first track
  buttonY = height - 100; // Position buttons near the bottom
}

void draw() {
  background(255); // White background

  int numButtons = buttonLabels.length;
  float buttonSpacing = (width - buttonWidth * numButtons) / (numButtons + 1);

  for (int i = 0; i < numButtons; i++) {
    float xOffset = buttonSpacing + i * (buttonWidth + buttonSpacing);

    // Draw button background
    fill(200); // Button color
    rect(xOffset, buttonY, buttonWidth, buttonHeight);

    // Draw button shape based on functionality
    fill(0); // Shape color
    switch (buttonLabels[i]) {
      case "Mute":
        ellipse(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2, buttonWidth / 2, buttonHeight / 2);
        break;
      case "Shuffle":
        beginShape();
        vertex(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4);
        vertex(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2);
        vertex(xOffset + buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        vertex(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4);
        vertex(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2);
        vertex(xOffset + 3 * buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        endShape(CLOSE);
        break;
      case "Previous":
        triangle(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4,
                 xOffset + buttonWidth / 4, buttonY + buttonHeight / 2,
                 xOffset + 3 * buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        break;
      case "Play/Pause":
        triangle(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4,
                 xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 2,
                 xOffset + buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        rect(xOffset + buttonWidth / 2 - 10, buttonY + buttonHeight / 4, 10, buttonHeight / 2);
        rect(xOffset + buttonWidth / 2 + 10, buttonY + buttonHeight / 4, 10, buttonHeight / 2);
        break;
      case "Next":
        triangle(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4,
                 xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 2,
                 xOffset + buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        rect(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4, 10, buttonHeight / 2);
        break;
      case "Loop":
        arc(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2,
            buttonWidth / 2, buttonHeight / 2, PI, TWO_PI);
        triangle(xOffset + buttonWidth / 2, buttonY + buttonHeight / 4,
                 xOffset + buttonWidth / 2 + 10, buttonY + buttonHeight / 2,
                 xOffset + buttonWidth / 2 - 10, buttonY + buttonHeight / 2);
        break;
      case "Vol +":
        rect(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4,
             buttonWidth / 2, buttonHeight / 2);
        line(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4,
             xOffset + 3 * buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        line(xOffset + 3 * buttonWidth / 4 - 10, buttonY + buttonHeight / 2,
             xOffset + 3 * buttonWidth / 4 + 10, buttonY + buttonHeight / 2);
        break;
      case "Vol -":
        rect(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4,
             buttonWidth / 2, buttonHeight / 2);
        line(xOffset + 3 * buttonWidth / 4 - 10, buttonY + buttonHeight / 2,
             xOffset + 3 * buttonWidth / 4 + 10, buttonY + buttonHeight / 2);
        break;
    }
  }
}

void mousePressed() {
  int numButtons = buttonLabels.length;
  float buttonSpacing = (width - buttonWidth * numButtons) / (numButtons + 1);

  for (int i = 0; i < numButtons; i++) {
    float xOffset = buttonSpacing + i * (buttonWidth + buttonSpacing);

    if (mouseX > xOffset && mouseX < xOffset + buttonWidth &&
        mouseY > buttonY && mouseY < buttonY + buttonHeight) {
      handleButtonClick(buttonLabels[i]);
    }
  }
}

void handleButtonClick(String buttonLabel) {
  switch (buttonLabel) {
    case "Mute":
      if (!isMuted) {
        lastGain = player.getGain();
        player.setGain(-80); // Mute
        isMuted = true;
        println("Muted");
      } else {
        player.setGain(lastGain);
        isMuted = false;
        println("Unmuted");
      }
      break;
    case "Shuffle":
      currentTrack = int(random(playlist.length));
      player.pause();
      player = playlist[currentTrack];
      player.play();
      println("Shuffled to track: " + currentTrack);
      break;
    case "Previous":
      currentTrack = (currentTrack - 1 + playlist.length) % playlist.length;
      player.pause();
      player = playlist[currentTrack];
      player.play();  // Start playing the first track

      println("Playing previous track: " + currentTrack);
      break;
    case "Play/Pause":
      if (player.isPlaying()) {
        player.pause();
        println("Paused");
      } else {
        player.play();
        println("Playing");
      }
      break;
    case "Next":
      currentTrack = (currentTrack + 1) % playlist.length;
      player.pause();
      player = playlist[currentTrack];
      player.play();
      println("Playing next track: " + currentTrack);
      break;
    case "Loop":
      player.loop();
      println("Looping");
      break;
    case "Vol +":
      float increasedGain = min(player.getGain() + 5, 0);
      player.setGain(increasedGain);
      println("Volume increased to: " + increasedGain);
      break;
    case "Vol -":
      float decreasedGain = max(player.getGain() - 5, -80);
      player.setGain(decreasedGain);
      println("Volume decreased to: " + decreasedGain);
      break;
  }
}
