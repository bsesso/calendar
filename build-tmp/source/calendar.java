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
Calendar calendar;

int activeColor = color(0, 200, 30);
int unactiveColor = color(255);


public void setup() {
	
	
	
	cp5 = new ControlP5(this);
	cp5.setAutoDraw(false);

	calendar = new Calendar(50, 50, 700, 500)
					.configure(3, 30);

}


public void draw() {
	calendar.draw();


	if (keyPressed && key == 'c') {
		calendar.clear();
	}
	if (keyPressed && key == 'a') {
		calendar.selectAll();
	}
}
class Calendar {
	Day[][] calendar = new Day[7][5];
	int x, y, width, height;

	int calX, calY, calWidth, calHeight;

	int wDayX, wDayY, wDayWidth, wDayHeight;

	int titleX, titleY, titleWidth, titleHeight;

	Calendar (int x, int y, int w, int h) {
		this.x = x;
		this.y = y;
		this.width = w;
		this.height = h;

		this.calWidth = w;
		this.calHeight = (int)(0.8f * h);
		this.calX = x;
		this.calY = (int)(y + 0.2f * h);

		this.wDayWidth = w;
		this.wDayHeight = (int)(0.5f * 0.05f * h);
		this.wDayX = x;
		this.wDayY = (int)(y + 0.15f * h);

		this.titleWidth = w;
		this.titleHeight = (int)(0.1f * h);
		this.titleX = x;
		this.titleY = y;

		int dayWidth = calWidth / 7;
		int dayHeight = calHeight / 5;
		for (int i = 0; i < calendar.length; i++) {
			for (int j = 0; j < calendar[i].length; j++) {
				String toggle = "day" + Integer.toString(i) + Integer.toString(j);
				cp5.addToggle(toggle);
				calendar[i][j] = new Day(cp5.getController(toggle))
								.setPosition(calX + i * dayWidth, calY + j * dayHeight)
								.setSize(dayWidth, dayHeight);
			}
		}
	}

	public Calendar configure(int startDay, int nDays) {
		for (int n = 0; n < nDays; n++) {
			int i = (startDay + n) % 7;
			int j = (startDay + n) / 7;
			calendar[i][j].day = n + 1;
		}

		return this;
	}

	public void selectAll() {
		for (Day[] row : calendar) {
			for (Day day : row) {
				if (day.day > 0)
					day.setActive(true);
			}
		}
	}

	public void clear() {
		for (Day[] row : calendar) {
			for (Day day : row) {
				day.setActive(false);
			}
		}
	}

	public void drawWDays() {
		PFont f = createFont("Arial", 18, true); // STEP 2 Create Font
		textFont(f);                  // STEP 3 Specify font to be used
		fill(0);                      // STEP 4 Specify font color
		textAlign(CENTER);
		rectMode(CENTER);

		int dayW = wDayWidth / 7;
		int dayH = wDayHeight;

		text("\u65e5", wDayX + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("\u6708", wDayX + 1 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("\u706b", wDayX + 2 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("\u6c34", wDayX + 3 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("\u6728", wDayX + 4 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("\u91d1", wDayX + 5 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("\u571f", wDayX + 6 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
	}

	public void drawTitle() {
		PFont f = createFont("Arial", 48, true); // STEP 2 Create Font
		textFont(f);                  // STEP 3 Specify font to be used
		fill(0);                      // STEP 4 Specify font color
		textAlign(CENTER);
		rectMode(CENTER);

		text("6\u6708", titleX + titleWidth / 2, 24 + titleY + titleHeight / 2);
	}

	public void draw() {
		drawTitle();
		drawWDays();

		cp5.draw();
		for (Day[] row : calendar) {
			for (Day day : row) {
				day.draw();
			}
		}
	}
}
class Day implements ControlListener {
	int day = -1;
	int x, y, width, height;
	Toggle controller;
	boolean active;

	Day (Controller cont) {
		this.controller = (Toggle)cont;	
		active = false;
		controller.setState(this.active)
			.addListener(this)
			.setLabelVisible(false)
			.setColorBackground(unactiveColor)
			.setColorForeground(unactiveColor)
			.setColorActive(activeColor);	
	}

	public Day setPosition(int x, int y) {
		this.x = x;
		this.y = y;
		controller.setPosition(x, y);

		return this;
	}

	public Day setSize(int w, int h) {
		this.height = h;
		this.width = w;
		controller.setSize(w, h);

		return this;
	}

	public Day setActive(boolean act) {
		this.active = act;
		controller.setState(this.active);

		return this;
	}

	public void draw() {
		stroke(0);
		strokeWeight(1);
		noFill();
		rectMode(CORNER);
		rect(x, y, width, height);

		if (day > 0) {
			drawLabel();
		} else {
			controller.lock();
		}
	}

	public void drawLabel() {
		PFont f = createFont("Arial", 12, true); // STEP 2 Create Font
		textFont(f);                  // STEP 3 Specify font to be used
		fill(0);                      // STEP 4 Specify font color
		textAlign(LEFT);
		rectMode(CORNER);
		text(Integer.toString(day), x + 10, y + 22);
	}

	public void controlEvent(ControlEvent theEvent) {
	    this.active = theEvent.getController().isActive();
	}
}
  public void settings() { 	size(800, 800); 	smooth(); 	pixelDensity(displayDensity()); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "calendar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
