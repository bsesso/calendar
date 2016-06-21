// Calendar(x, y, width, height)
//     | Class representing the whole calendar, including the days and upper titles.
class Calendar {

  Day[][] calendar = new Day[7][5];
  int x, y, width, height;

  int calX, calY, calWidth, calHeight;

  int wDayX, wDayY, wDayWidth, wDayHeight;

  int titleX, titleY, titleWidth, titleHeight;

  ControlP5 cont;

  Calendar (int x, int y, int w, int h, ControlP5 cont) {
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

    this.cont = cont;

    int dayWidth = calWidth / 7;
    int dayHeight = calHeight / 5;

    // Set each day of the calendar.
    for (int i = 0; i < calendar.length; i++) {
      for (int j = 0; j < calendar[i].length; j++) {
        // Set the name and add to the controller each toggle button
        String toggle = "day" + Integer.toString(i) + Integer.toString(j);
        cont.addToggle(toggle);
        // add to the matrix of days (calendar) the created and configurated day
        calendar[i][j] = new Day(cont.getController(toggle))
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
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 7; j++) {
        if (calendar[j][i].day > 0) {
          calendar[j][i].setActive(true);

          //println(calendar[j][i].active);
        }
      }
    }
  }
  
  void selectAll(int selectableDays[]) {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 7; j++) {
        if (selectableDaysContainsDay(selectableDays, calendar[j][i].day)) {
          calendar[j][i].setActive(true);

          println(calendar[j][i].active);
        }
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

  int[] selectedDays() {

    int count = 0;

    for (Day[] row : calendar) {
      for (Day day : row) {
        if (day.active) {
          count++;
        }
      }
    }

    int days[] = new int[count];

    int i = 0;
    for (int j = 0; j < 5; j++) {
      for (int k = 0; k < 7; k++) {
        if (calendar[k][j].active) {
          days[i++] = calendar[k][j].day;
        }
      }
    }

    return days;
  }
  
  void keepSelectableOnlyDays(int[] selectableDays) {
    for (Day[] row : calendar) {
      for (Day day : row) {
        if (selectableDaysContainsDay(selectableDays, day.day)) {

          
        } else {
          day.controller.setColorBackground(unselectableColor);
          day.controller.setColorForeground(unselectableColor);
          day.controller.lock(); 
        }
      }
    }
  }
  
  boolean selectableDaysContainsDay(int[] selectableDays, int day) {
    for (int i : selectableDays) {
      if (i == day) {
        return true;
      }
    }
    return false;
  }

  void draw() {
    drawTitle();
    drawWDays();

    cont.draw();
    for (Day[] row : calendar) {
      for (Day day : row) {
        day.draw();
      }
    }
  }
}