PImage img;

void setup() {
  size(800, 600);
  img = loadImage("istockphoto-1307657911-612x612.jpg");  // Replace with your image filename
  imageMode(CORNER);
  noLoop();
}

void draw() {
  background(50);

  // Define the box to fit image into
  float boxX = 100;
  float boxY = 100;
  float boxW = 600;
  float boxH = 400;

  // Draw a border for the box
  noFill();
  stroke(255);
  rect(boxX, boxY, boxW, boxH);

  // Draw the image inside the box with preserved aspect ratio
  drawImageAspect(img, boxX, boxY, boxW, boxH);
}

/**
 * Draws the image scaled to fit inside the given box while preserving aspect ratio.
 *
 * @param img The PImage to draw.
 * @param x The x coordinate of the top-left corner of the box.
 * @param y The y coordinate of the top-left corner of the box.
 * @param boxWidth The width of the box.
 * @param boxHeight The height of the box.
 */
void drawImageAspect(PImage img, float x, float y, float boxWidth, float boxHeight) {
  float imgAspect = (float) img.width / img.height;
  float boxAspect = boxWidth / boxHeight;

  float drawWidth, drawHeight;
  if (imgAspect > boxAspect) {
    // Image is wider relative to the box
    drawWidth = boxWidth;
    drawHeight = boxWidth / imgAspect;
  } else {
    // Image is taller relative to the box
    drawHeight = boxHeight;
    drawWidth = boxHeight * imgAspect;
  }

  // Center image inside the box
  float drawX = x + (boxWidth - drawWidth) / 2;
  float drawY = y + (boxHeight - drawHeight) / 2;

  image(img, drawX, drawY, drawWidth, drawHeight);
}
