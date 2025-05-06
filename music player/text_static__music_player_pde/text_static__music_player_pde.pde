// Text: Static
String title = "Earearearearbuds"; 
PFont titleFont; 
float fontSize;

void setup() {
  size(700, 500);
  int appWidth = width; 
  int appHeight = height; 
  int shorterSide = (appWidth > appHeight) ? appHeight : appWidth;

  // List available fonts (optional)
  // String[] fontList = PFont.list();
  // printArray(fontList);

  fontSize = shorterSide / 10.0; // Initial guess for font size
  titleFont = createFont("Harrington", fontSize);
}

void draw() {
  background(255); // Clear screen to white

  int appWidth = width; 
  int appHeight = height; 
  int shorterSide = (appWidth > appHeight) ? appHeight : appWidth;

  float titleX = appWidth * 1/4.0;
  float titleY = appHeight * 1/4.0;
  float titleWidth = appWidth * 1/2.0;
  float titleHeight = appHeight * 1/10.0;

  // Draw a rectangle for the title
  noFill();
  stroke(0);
  rect(titleX, titleY, titleWidth, titleHeight);

  // Adjust font size to fit inside the rectangle
  float harringtonAspectRatio = 1.04;
  fontSize = titleHeight * harringtonAspectRatio;
  titleFont = createFont("Harrington", fontSize);
  textFont(titleFont, fontSize);

  // Shrink font if needed
  while (textWidth(title) > titleWidth) {
    fontSize *= 0.9; // shrink a little each time
    titleFont = createFont("Harrington", fontSize);
    textFont(titleFont, fontSize);
    println("Shrinking font, width:", textWidth(title), "allowed:", titleWidth);
  }

  // Set text settings
  color purpleInk = color(44, 8, 255); // #2C08FF
  fill(purpleInk);
  textAlign(CENTER, CENTER);

  // Draw the title
  text(title, titleX + titleWidth/2, titleY + titleHeight/2);
}
