import processing.sound.*;

import com.mpatric.mp3agic.*;



void setup() {
  try {
    Mp3File mp3 = new Mp3File(dataPath("song.mp3"));
    if (mp3.hasId3v2Tag()) {
      ID3v2 tag = mp3.getId3v2Tag();
      println("Title: " + tag.getTitle());
    }
  } catch (Exception e) {
    println("Error reading MP3: " + e.getMessage());
  }
}
