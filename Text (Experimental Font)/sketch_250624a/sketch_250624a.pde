PFont font;

void setup() {
  size(800, 600);
  font = createFont("Courier", 32); // You can replace with any available font
  textFont(font);
  textAlign(CENTER, CENTER);
  noLoop();
}

void draw() {
  background(30);

  // Box to fit text into
  float boxX = 100;
  float boxY = 200;
  float boxW = 600;
  float boxH = 200;
  String label = "Music Player Program with Font Aspect Ratio";

  // Draw border for the box
  noFill();
  stroke(200);
  rect(boxX, boxY, boxW, boxH);

  // Draw the text inside the box
  drawTextWithAspect(label, boxX, boxY, boxW, boxH);
}

/**
 * Draws text scaled to fit inside a box while preserving the font's aspect ratio.
 */
void drawTextWithAspect(String txt, float x, float y, float boxW, float boxH) {
  pushMatrix();

  // Measure text width at base size
  float testSize = 100;
  textSize(testSize);
  float tw = textWidth(txt);
  float th = testSize * 0.7; // Approximate text height as 70% of textSize

  // Compute scale to fit inside box
  float scaleX = boxW / tw;
  float scaleY = boxH / th;
  float scaleFinal = min(scaleX, scaleY);

  float finalW = tw * scaleFinal;
  float finalH = th * scaleFinal;

  // Translate to center of box
  translate(x + boxW/2, y + boxH/2);
  scale(scaleFinal);

  fill(255);
  textSize(testSize);
  text(txt, 0, 0);

  popMatrix();
}
