import controlP5.*;

ControlP5 cp5, cp5_extra;
Calendar calendar;

color activeColor = color(0, 200, 30);
color unactiveColor = color(255);


void setup() {
	// pixelDensity(displayDensity());
	size(800, 800);

	cp5 = new ControlP5(this);

	// Disable the auto draw for cp5 controller. With this we can draw cp5 manually and so
	// draw things over the controlP5 elements. 
	cp5.setAutoDraw(false);

	// cp5_extra contains the buttons on the upper right corner 
	cp5_extra = new ControlP5(this);

	cp5_extra.addButton("selectAll")
			.setPosition(490, 70)
			.setSize(70, 30)
			.setCaptionLabel("All");

	cp5_extra.addButton("reset")
			.setPosition(580, 70)
			.setSize(70, 30)
			.setCaptionLabel("Reset");

	cp5_extra.addButton("ok")
			.setPosition(670, 70)
			.setSize(70, 30)
			.setCaptionLabel("OK");

	Textfield t = cp5_extra.addTextfield("eventName")
		    .setPosition(180,70)
		    .setSize(130,40)
		    .setFont(createFont("arial", 20))
		    .setColor(color(255))
		    .setAutoClear(false);

	t.getCaptionLabel()
		.setText("イベント名")
	  	.align(ControlP5.LEFT_OUTSIDE, CENTER)
		.getStyle().setPaddingLeft(-10);

	// Calendar(x, y, width, height)
	//     | Class representing the whole calendar, including the days and upper titles.
	//
	// configure(startDay, nDays)
	//	   | Method of Calendar class.
	//	   | 	startDay - Represents which column day 1 is. (index start from 0)
	//	   |    nDays - number of days on month
	calendar = new Calendar(50, 50, 700, 500)
					.configure(3, 30);

}


void draw() {
	calendar.draw();
}

void selectAll() {
	calendar.selectAll();
}

void reset() {
	calendar.clear();
}

void ok() {

}