// Calendar(x, y, width, height)
//     | Class representing the whole calendar, including the days and upper titles.
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
		this.calHeight = (int)(0.8 * h);
		this.calX = x;
		this.calY = (int)(y + 0.2 * h);

		this.wDayWidth = w;
		this.wDayHeight = (int)(0.5 * 0.05 * h);
		this.wDayX = x;
		this.wDayY = (int)(y + 0.15 * h);

		this.titleWidth = w;
		this.titleHeight = (int)(0.1 * h);
		this.titleX = x;
		this.titleY = y;

		int dayWidth = calWidth / 7;
		int dayHeight = calHeight / 5;

		// Set each day of the calendar.
		for (int i = 0; i < calendar.length; i++) {
			for (int j = 0; j < calendar[i].length; j++) {
				// Set the name and add to the controller each toggle button
				String toggle = "day" + Integer.toString(i) + Integer.toString(j);
				cp5.addToggle(toggle);
				// add to the matrix of days (calendar) the created and configurated day
				calendar[i][j] = new Day(cp5.getController(toggle))
								.setPosition(calX + i * dayWidth, calY + j * dayHeight)
								.setSize(dayWidth, dayHeight);
			}
		}
	}


	// configure(startDay, nDays)
	//	   | Method of Calendar class.
	//	   | 	startDay - Represents which column day 1 is. (index start from 0)
	//	   |    nDays - number of days on month
	Calendar configure(int startDay, int nDays) {
		for (int n = 0; n < nDays; n++) {
			int i = (startDay + n) % 7;
			int j = (startDay + n) / 7;
			calendar[i][j].day = n + 1;
		}

		return this;
	}

	void selectAll() {
		for (Day[] row : calendar) {
			for (Day day : row) {
				if (day.day > 0)
					day.setActive(true);
			}
		}
	}

	void clear() {
		for (Day[] row : calendar) {
			for (Day day : row) {
				day.setActive(false);
			}
		}
	}

	void drawWDays() {
		PFont f = createFont("Arial", 18, true); // STEP 2 Create Font
		textFont(f);                  // STEP 3 Specify font to be used
		fill(0);                      // STEP 4 Specify font color
		textAlign(CENTER);
		rectMode(CENTER);

		int dayW = wDayWidth / 7;
		int dayH = wDayHeight;

		text("日", wDayX + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("月", wDayX + 1 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("火", wDayX + 2 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("水", wDayX + 3 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("木", wDayX + 4 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("金", wDayX + 5 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
		text("土", wDayX + 6 * dayW + ((float)dayW / 2), 10 + wDayY + ((float)dayH / 2));
	}

	void drawTitle() {
		PFont f = createFont("Arial", 48, true); // STEP 2 Create Font
		textFont(f);                  // STEP 3 Specify font to be used
		fill(0);                      // STEP 4 Specify font color
		textAlign(CENTER);
		rectMode(CENTER);

		text("6月", titleX + titleWidth / 2, 24 + titleY + titleHeight / 2);
	}

	void draw() {
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