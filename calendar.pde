import controlP5.*;

ControlP5 cp5;
Calendar calendar;

color activeColor = color(0, 200, 30);
color unactiveColor = color(255);


void setup() {
	smooth();
	pixelDensity(displayDensity());
	size(800, 800);
	cp5 = new ControlP5(this);
	cp5.setAutoDraw(false);

	calendar = new Calendar(50, 50, 700, 500)
					.configure(3, 30);

}


void draw() {
	calendar.draw();


	if (keyPressed && key == 'c') {
		calendar.clear();
	}
	if (keyPressed && key == 'a') {
		calendar.selectAll();
	}
}