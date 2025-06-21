import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*;

Minim minim;
AudioPlayer song;

void setup() {
  size(400, 200);
  
  // Initialize Minim
  minim = new Minim(this);
  
  // Load the audio file
  song = minim.loadFile("Local Forecast - Elevator.mp3"); // 
  
  // Play the song
  song.play();
}

void draw() {
  background(0);
  fill(255);
  text("Playing music...", 20, 100);
}

void stop() {
  // Always close audio resources
  song.close();
  minim.stop();
  
  super.stop();
}
