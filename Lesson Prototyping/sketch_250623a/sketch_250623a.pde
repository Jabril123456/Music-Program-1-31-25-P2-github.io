import ddf.minim.*;

Minim minim;
AudioPlayer song;

boolean isLooping = false;
boolean isMuted = false;
float lastVolume = 0;

float barX, barY, barW, barH;
ArrayList<ButtonDiv> buttons = new ArrayList<ButtonDiv>();

void setup() {
  size(1000, 600);
  noStroke();
  
  minim = new Minim(this);
  song = minim.loadFile("Cipher.mp3");

  buttons.add(new ButtonDiv(92.2, 97, 9.5, 16.6, "Quit"));
  buttons.add(new ButtonDiv(3.8, 14, 70.4, 83, "Play"));
  buttons.add(new ButtonDiv(15.2, 23, 74.7, 85, "Pause"));
  buttons.add(new ButtonDiv(27.3, 34, 78, 83, "Play/Pause"));
  buttons.add(new ButtonDiv(37, 41, 73, 82.8, "2x Forward"));
  buttons.add(new ButtonDiv(45.0, 50.8, 73.3, 82.8, "2x Backward"));
  buttons.add(new ButtonDiv(53, 62.3, 70, 83.8, "Loop"));
  buttons.add(new ButtonDiv(65.5, 76.4, 70.4, 82.8, "Loop Infinite"));
  buttons.add(new ButtonDiv(77, 85.8, 73.3, 82.8, "Mute"));
  buttons.add(new ButtonDiv(88, 98.1, 70, 81.9, "Shuffle"));
  buttons.add(new ButtonDiv(3.0, 26.7, 90.4, 98.0, "Previous"));
  buttons.add(new ButtonDiv(60.0, 94.7, 87.6, 98, "Next"));
}

void draw() {
  background(30);
  
  for (ButtonDiv b : buttons) {
    b.hovered = b.isMouseOver();
    b.draw();
  }

  drawDiv(35.2, 58.8, 7.9, 17.1, "Title");
  drawDiv(20, 74.7, 19, 46, "Album Art");
  drawDiv(17, 23, 50, 55, "Start Time");
  drawDiv(69, 75, 49.5, 54, "End Time");
  drawProgressBar(18.8, 68.8, 57, 60.4);
}

void drawProgressBar(float x1Percent, float x2Percent, float y1Percent, float y2Percent) {
  barX = width * (x1Percent / 100.0);
  barY = height * (y1Percent / 100.0);
  barW = width * ((x2Percent - x1Percent) / 100.0);
  barH = height * ((y2Percent - y1Percent) / 100.0);

  fill(80);
  rect(barX, barY, barW, barH, 6);

  if (song != null && song.length() > 0) {
    float progress = map(song.position(), 0, song.length(), 0, barW);
    fill(0, 200, 255);
    rect(barX, barY, progress, barH, 6);

    fill(255);
    textSize(12);
    textAlign(LEFT, CENTER);
    text(formatTime(song.position()), barX + 5, barY + barH / 2);
    textAlign(RIGHT, CENTER);
    text(formatTime(song.length()), barX + barW - 5, barY + barH / 2);
  }
}

String formatTime(int ms) {
  int sec = ms / 1000;
  int min = sec / 60;
  sec = sec % 60;
  return nf(min, 2) + ":" + nf(sec, 2);
}

void mousePressed() {
  for (ButtonDiv b : buttons) {
    if (b.isMouseOver()) {
      handleSoundButton(b.label);
    }
  }

  if (mouseX > barX && mouseX < barX + barW && mouseY > barY && mouseY < barY + barH) {
    float pct = (mouseX - barX) / barW;
    int newPos = int(pct * song.length());
    song.cue(newPos);
    if (!song.isPlaying()) song.play();
  }
}

void handleSoundButton(String label) {
  switch(label) {
    case "Quit":
      exit();
      break;
    case "Play":
      if (!song.isPlaying()) song.play();
      break;
    case "Pause":
      if (song.isPlaying()) song.pause();
      break;
    case "Play/Pause":
      if (song.isPlaying()) song.pause();
      else song.play();
      break;
    case "2x Forward":
      song.cue(min(song.position() + 2000, song.length()));
      break;
    case "2x Backward":
      song.cue(max(song.position() - 2000, 0));
      break;
    case "Loop":
      isLooping = !isLooping;
      if (isLooping) song.loop();
      else {
        song.pause();
        song.rewind();
      }
      break;
    case "Loop Infinite":
      song.loop();
      isLooping = true;
      break;
    case "Mute":
      if (!isMuted) {
        lastVolume = song.getGain();
        song.setGain(-80);
        isMuted = true;
      } else {
        song.setGain(lastVolume);
        isMuted = false;
      }
      break;
    case "Shuffle":
      println("Shuffle clicked (not implemented).");
      break;
    case "Previous":
      song.cue(max(song.position() - 5000, 0));
      break;
    case "Next":
      song.cue(min(song.position() + 5000, song.length()));
      break;
  }
}

void drawDiv(float x1Percent, float x2Percent, float y1Percent, float y2Percent, String label) {
  float x = width * (x1Percent / 100.0);
  float y = height * (y1Percent / 100.0);
  float w = width * ((x2Percent - x1Percent) / 100.0);
  float h = height * ((y2Percent - y1Percent) / 100.0);

  fill(100, 100, 100);
  rect(x, y, w, h, 8);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(14);
  text(label, x + w / 2, y + h / 2);
}

// -------------------------------------------------------
// Moved class and icon functions outside of drawDiv below
// -------------------------------------------------------

class ButtonDiv {
  float x1p, x2p, y1p, y2p;
  String label;
  boolean hovered = false;

  ButtonDiv(float x1p, float x2p, float y1p, float y2p, String label) {
    this.x1p = x1p;
    this.x2p = x2p;
    this.y1p = y1p;
    this.y2p = y2p;
    this.label = label;
  }

  void draw() {
    float x = width * (x1p / 100.0);
    float y = height * (y1p / 100.0);
    float w = width * ((x2p - x1p) / 100.0);
    float h = height * ((y2p - y1p) / 100.0);

    if (hovered) {
      fill(180, 200, 255);
    } else {
      fill(80, 150, 220);
    }
    rect(x, y, w, h, 8);

    pushMatrix();
    translate(x + w / 2, y + h / 2);
    float size = min(w, h) * 0.5;
    stroke(255);
    strokeWeight(2);
    noFill();

    switch(label) {
      case "Quit": drawIconQuit(size); break;
      case "Play": drawIconPlay(size); break;
      case "Pause": drawIconPause(size); break;
      case "Play/Pause": drawIconPlayPause(size); break;
      case "2x Forward": drawIconFastForward(size); break;
      case "2x Backward": drawIconRewind(size); break;
      case "Loop": drawIconLoop(size); break;
      case "Loop Infinite": drawIconLoopInfinite(size); break;
      case "Mute": drawIconMute(size); break;
      case "Shuffle": drawIconShuffle(size); break;
      case "Previous": drawIconPrevious(size); break;
      case "Next": drawIconNext(size); break;
    }
    popMatrix();
  }

  boolean isMouseOver() {
    float x = width * (x1p / 100.0);
    float y = height * (y1p / 100.0);
    float w = width * ((x2p - x1p) / 100.0);
    float h = height * ((y2p - y1p) / 100.0);
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}

// ------------------------
// Icon drawing functions
// ------------------------

void drawIconQuit(float s) {
  line(-s/2, -s/2, s/2, s/2);
  line(s/2, -s/2, -s/2, s/2);
}

void drawIconPlay(float s) {
  noStroke(); fill(255);
  beginShape(); vertex(-s/3, -s/2); vertex(s/2, 0); vertex(-s/3, s/2); endShape(CLOSE);
}

void drawIconPause(float s) {
  noStroke(); fill(255);
  float barW = s / 4;
  rect(-barW * 1.5, -s/2, barW, s);
  rect(barW * 0.5, -s/2, barW, s);
}

void drawIconPlayPause(float s) {
  noStroke(); fill(255);
  beginShape(); vertex(-s/3, -s/2); vertex(0, 0); vertex(-s/3, s/2); endShape(CLOSE);
  float barW = s / 8;
  rect(barW * 0.5, -s/3, barW, s * 2/3);
  rect(barW * 2, -s/3, barW, s * 2/3);
}

void drawIconFastForward(float s) {
  noStroke(); fill(255);
  beginShape(); vertex(-s/3, -s/2); vertex(s/6, 0); vertex(-s/3, s/2); endShape(CLOSE);
  beginShape(); vertex(s/6, -s/2); vertex(s/2, 0); vertex(s/6, s/2); endShape(CLOSE);
}

void drawIconRewind(float s) {
  noStroke(); fill(255);
  beginShape(); vertex(s/3, -s/2); vertex(-s/6, 0); vertex(s/3, s/2); endShape(CLOSE);
  beginShape(); vertex(-s/6, -s/2); vertex(-s/2, 0); vertex(-s/6, s/2); endShape(CLOSE);
}

void drawIconLoop(float s) {
  noFill(); stroke(255); strokeWeight(2);
  arc(0, 0, s, s, PI/2, 2.8);
  line(s/3, -s/6, s/2, 0);
  line(s/3, s/6, s/2, 0);
}

void drawIconLoopInfinite(float s) {
  noFill(); stroke(255); strokeWeight(2);
  ellipse(-s/4, 0, s/2, s);
  ellipse(s/4, 0, s/2, s);
}

void drawIconMute(float s) {
  noFill(); stroke(255); strokeWeight(2);
  rect(-s/3, -s/4, s/4, s/2);
  triangle(-s/12, -s/2, s/6, -s/2, s/6, s/2);
  line(s/3, -s/3, s/2, s/3);
  line(s/3, s/3, s/2, -s/3);
}

void drawIconShuffle(float s) {
  noFill(); stroke(255); strokeWeight(2);
  line(-s/2, s/3, -s/6, -s/3);
  line(-s/6, -s/3, s/2, s/3);
  line(-s/6, s/3, s/2, -s/3);
  line(-s/2, -s/3, -s/6, s/3);
}

void drawIconPrevious(float s) {
  noStroke(); fill(255);
  beginShape(); vertex(s/3, -s/2); vertex(-s/6, 0); vertex(s/3, s/2); endShape(CLOSE);
  rect(-s/3, -s/2, s/12, s);
}

void drawIconNext(float s) {
  noStroke(); fill(255);
  beginShape(); vertex(-s/3, -s/2); vertex(s/6, 0); vertex(-s/3, s/2); endShape(CLOSE);
  rect(s/12, -s/2, s/12, s);
}
