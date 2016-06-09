import controlP5.*;

ControlP5 cp5;

color activeColor = color(0, 200, 30);
color unactiveColor = color(255);

class Day implements ControlListener {
	int day = -1;
	int x, y, width, height;
	Controller controller;

	Day (ControlP5 cont) {
		this.controller = cont;	
		controller.addListener(this);	
	}

	Day setPosition(int x, int y) {
		this.x = x;
		this.y = y;
		controller.setPosition(x, y);

		return this;
	}

	Day setSize(int w, int h) {
		this.height = h;
		this.width = w;
		controller.setSize(w, h);

		return this;
	}

	public void controlEvent(ControlEvent theEvent) {
	    println("i got an event from mySlider, " +
	            "changing background color to "+
	            theEvent.getController().getValue());
	    // col = (int)theEvent.getController().getValue();
	  }
}

class Calendar {


	Calendar () {

	}

	void draw() {

	}


}



void setup() {
	smooth();
	size(800, 800);
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


void draw() {
	cp5.draw();
	stroke(0);
	strokeWeight(1);
	noFill();
	rect(40, 100, 100, 100);
	rect(140, 100, 100, 100);


}