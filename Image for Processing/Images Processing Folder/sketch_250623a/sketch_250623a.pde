PImage img;

void setup() {
  size(800, 600);  // Normal canvas size
  imageMode(CORNER);
  
  // Load large image (must be in 'data/' folder)
  img = loadImage("istockphoto-685846788-612x612.jpg");

  if (img == null) {
    println("❌ Failed to load image!");
  } else {
    println("✅ Loaded image: " + img.width + " × " + img.height);
  }
}

void draw() {
  background(30);

  // Define DIV rectangle
  float divX = 100;
  float divY = 100;
  float divW = 400;
  float divH = 300;

  // Draw blue rectangle as the DIV
  fill(80, 120, 200);
  rect(divX, divY, divW, divH);

  // Draw image inside the DIV (scaled down to fit)
  if (img != null) {
    image(img, divX, divY, divW, divH);
  }
}
