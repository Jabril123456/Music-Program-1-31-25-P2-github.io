import ddf.minim.*;  // Import the Minim library

Minim minim;
AudioPlayer song;

void setup() {
  size(400, 200);
  minim = new Minim(this);                      // Initialize Minim
  song = minim.loadFile("your_song.mp3");       // Load an MP3 or WAV file
  song.play();                                   // Play the song
}

void draw() {
  background(0);
  fill(255);
  text("Playing song...", 20, height/2);
}
