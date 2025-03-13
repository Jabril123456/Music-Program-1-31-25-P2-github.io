// Dynamic not static
//
//Library - Minin
//
//Global Variables 
//
float X, Y, Width, Height;
float y;

void setup() {
   float appwidth = displayWidth;
   float appheight = displayHeight;
   
  X = appwidth = 0.20;
  Y = appheight = 0.20;
  Width = appwidth = 0.20;
  Height = appheight = 0.20;
  
   fullScreen();
   println(displayWidth, displayHeight);
 
   rect(X, Y, Width, Height);
   rect(X, Y, Width, Height);
   rect(X, Y, Width, Height);
   rect(X, Y, Width, Height);
   rect(X, Y, Width, Height);
   rect(X, Y, Width, Height);
   rect(X, Y, Width, Height);
   rect(X, Y, Width, Height);
   //
}
//*
void draw() {}
//
void mousePressed() {}
//
void keyPressed() {}
//
//End MAIN Program
