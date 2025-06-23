void setup() {
  size(1000, 600); // Required to define the drawing canvas
  noStroke();
  background(30);
  drawDivs();
}

void drawDivs() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(12);

  // Each UI "div" is drawn with rect()
  drawDiv(92.2, 97, 9.5, 16.6, "Btn 1");
  drawDiv(3.8, 14, 70.4, 83, "Btn 2");
  drawDiv(15.2, 23, 74.7, 85, "Btn 3");
  drawDiv(27.3, 34, 78, 83, "Btn 4");
  drawDiv(37, 41, 73, 82.8, "Btn 5");
  drawDiv(45.0, 50.8, 73.3, 82.8, "Btn 6");
  drawDiv(53, 62.3, 70, 83.8, "Btn 7");
  drawDiv(65.5, 76.4, 70.4, 82.8, "Btn 8");
  drawDiv(77, 85.8, 73.3, 82.8, "Btn 9");
  drawDiv(88, 98.1, 70, 81.9, "Btn 10");
  drawDiv(3.0, 26.7, 90.4, 98.0, "Btn 11");
  drawDiv(60.0, 94.7, 87.6, 98, "Btn 12");

  drawDiv(35.2, 58.8, 7.9, 17.1, "Title");
  drawDiv(20, 74.7, 19, 46, "Album Art");
  drawDiv(18.8, 68.8, 57, 60.4, "Playbar");
  drawDiv(17, 23, 50, 55, "Start Time");
  drawDiv(69, 75, 49.5, 54, "End Time");
}

void drawDiv(float x1Percent, float x2Percent, float y1Percent, float y2Percent, String label) {
  float x = width * (x1Percent / 100.0);
  float w = width * ((x2Percent - x1Percent) / 100.0);
  float y = height * (y1Percent / 100.0);
  float h = height * ((y2Percent - y1Percent) / 100.0);

  fill(80, 150, 220); // Draw each div as a rectangle
  rect(x, y, w, h);

  fill(255);
  text(label, x + w / 2, y + h / 2);
}
