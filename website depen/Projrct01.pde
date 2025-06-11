import ddf.minim.*; // Import Minim library

Minim minim; // Declare Minim object
AudioPlayer player; // Declare AudioPlayer object

float buttonY; // Button vertical position
String[] buttonLabels = { "Mute", "Shuffle", "Previous", "Play/Pause", "Next", "Loop", "Vol +" }; // Button labels
float buttonWidth = 100; // Button width
float buttonHeight = 50; // Button height

void setup() {
  size(800, 600); // Set canvas size
  minim = new Minim(this); // Initialize Minim
  player = minim.loadFile("song.mp3"); // Load the song file

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
        ellipse(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2, buttonWidth / 2, buttonHeight / 2); // Circle for mute
        break;
      case "Shuffle":
        beginShape(); // Zigzag shape for shuffle
        vertex(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4);
        vertex(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2);
        vertex(xOffset + buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        vertex(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4);
        vertex(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2);
        vertex(xOffset + 3 * buttonWidth / 4, buttonY + 3 * buttonHeight / 4);
        endShape(CLOSE);
        break;
      case "Previous":
        triangle(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4, xOffset + buttonWidth / 4, buttonY + buttonHeight / 2, xOffset + 3 * buttonWidth / 4, buttonY + 3 * buttonHeight / 4); // Left-facing triangle for previous
        break;
      case "Play/Pause":
        triangle(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4, xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 2, xOffset + buttonWidth / 4, buttonY + 3 * buttonHeight / 4); // Right-facing triangle for play
        rect(xOffset + buttonWidth / 2 - 10, buttonY + buttonHeight / 4, 10, buttonHeight / 2); // Pause bars
        rect(xOffset + buttonWidth / 2 + 10, buttonY + buttonHeight / 4, 10, buttonHeight / 2);
        break;
      case "Next":
        triangle(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4, xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 2, xOffset + buttonWidth / 4, buttonY + 3 * buttonHeight / 4); // Right-facing triangle for next
        rect(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4, 10, buttonHeight / 2); // Vertical bar for next
        break;
      case "Loop":
        arc(xOffset + buttonWidth / 2, buttonY + buttonHeight / 2, buttonWidth / 2, buttonHeight / 2, PI, TWO_PI); // Semi-circle for loop
        triangle(xOffset + buttonWidth / 2, buttonY + buttonHeight / 4, xOffset + buttonWidth / 2 + 10, buttonY + buttonHeight / 2, xOffset + buttonWidth / 2 - 10, buttonY + buttonHeight / 2); // Arrowhead
        break;
      case "Vol +":
        rect(xOffset + buttonWidth / 4, buttonY + buttonHeight / 4, buttonWidth / 2, buttonHeight / 2); // Rectangle for volume
        line(xOffset + 3 * buttonWidth / 4, buttonY + buttonHeight / 4, xOffset + 3 * buttonWidth / 4, buttonY + 3 * buttonHeight / 4); // Vertical line
        line(xOffset + 3 * buttonWidth / 4 - 10, buttonY + buttonHeight / 2, xOffset + 3 * buttonWidth / 4 + 10, buttonY + buttonHeight / 2); // Horizontal line
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
      player.mute(); // Mute the audio
      println("Muted");
      break;
    case "Shuffle":
      println("Shuffle functionality not implemented yet");
      break;
    case "Previous":
      println("Previous functionality not implemented yet");
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
      println("Next functionality not implemented yet");
      break;
    case "Loop":
      player.loop(); // Loop the audio
      println("Looping");
      break;
    case "Vol +":
      player.setGain(player.getGain() + 5); // Increase volume
      println("Volume increased");
      break;
  }
}