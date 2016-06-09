import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class calendar extends PApplet {



ControlP5 cp5;

int activeColor = color(0, 200, 30);
int unactiveColor = color(255);

public void setup() {
	
	
	cp5 = new ControlP5(this);
	cp5.setAutoDraw(false);
	
	cp5.addToggle("toogle1")
	   .setPosition(40,100)
	   .setSize(100,100)
	   .setColorForeground(unactiveColor)
	   .setColorActive(activeColor)
	   .setColorBackground(unactiveColor);

   cp5.addToggle("toogle2")
      .setPosition(140, 100)
      .setSize(100,100)
      .setColorForeground(unactiveColor)
      .setColorActive(activeColor)
      .setColorBackground(unactiveColor);	   


}


public void draw() {
	cp5.draw();
	stroke(0);
	strokeWeight(1);
	noFill();
	rect(40, 100, 100, 100);
	rect(140, 100, 100, 100);


}
  public void settings() { 	size(800, 800); 	smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "calendar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
