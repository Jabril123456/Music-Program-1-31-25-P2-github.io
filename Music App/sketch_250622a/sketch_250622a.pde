import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*;

Minim minim;
AudioPlayer song1, song2, song3;
AudioPlayer currentSong;

void setup() {
  size(400, 200);
  minim = new Minim(this);
  
  // Load all songs
  song1 = minim.loadFile("Cipher.mp3");
  song2 = minim.loadFile("Local Forecast - Elevator.mp3");
  song3 = minim.loadFile("Look Busy.mp3");
  
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);
  fill(255);
  text("Press 1, 2, or 3 to play songs", width/2, height/2);
}

void keyPressed() {
  if (key == '1') {
    playSong(song1);
  } else if (key == '2') {
    playSong(song2);
  } else if (key == '3') {
    playSong(song3);
  } else if (key == 's') {
    stopCurrentSong();
  }
}

void playSong(AudioPlayer song) {
  stopCurrentSong();  // Stop currently playing song
  song.rewind();      // Rewind to start
  song.play();        // Play the selected song
  currentSong = song; // Remember what’s playing
}

void stopCurrentSong() {
  if (currentSong != null && currentSong.isPlaying()) {
    currentSong.pause(); // or use currentSong.close() if you want to release it
  }
}

void stop() {
  // Clean up
  song1.close();
  song2.close();
  song3.close();
  minim.stop();
  super.stop();
}
