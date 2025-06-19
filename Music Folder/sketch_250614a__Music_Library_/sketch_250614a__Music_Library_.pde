import ddf.minim.*;

Minim minim;
AudioPlayer song;

void setup() {
  size(400, 200);
  minim = new Minim(this);
  song = minim.loadFile("yourfile.mp3");
  song.play();
