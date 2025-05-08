import ddf.minim.*; // Import the Minim library

Minim minim;
AudioPlayer player;

void setup() {
  size(800, 600); // Set the window size
  minim = new Minim(this); // Initialize Minim
  player = minim.loadFile("song.mp3"); // Load a song file
  player.play(); // Play the song
}

void draw() {
  background(0); // Set background color
  fill(255);
  text("Playing song: song.mp3", 20, 30); // Display song info
}

void stop() {
  player.close(); // Close the player
  minim.stop(); // Stop Minim
  super.stop();
}

