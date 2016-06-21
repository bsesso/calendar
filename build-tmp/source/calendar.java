import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class calendar extends PApplet {



ControlP5 cp5_create, cp5_entry, cp5_extra, cp5_rs, cp5_event, cp5_name;
Calendar calendar, entryCalendar;
Textfield t_event, t_name;
String eventName;
int startX = 80;
int lineWidth = 60;
int[] days;
int screen;

ResultScreen rs;

int activeColor = color(0, 200, 30);
int unselectableColor = color(200);
int unactiveColor = color(255);


public void setup() {
  // pixelDensity(displayDensity());
  

  screen = 0;

  cp5_create = new ControlP5(this);
  cp5_entry = new ControlP5(this);
  // cp5_extra contains the buttons on the upper right corner 
  cp5_extra = new ControlP5(this);
  cp5_rs = new ControlP5(this);
  cp5_event = new ControlP5(this);
  cp5_name = new ControlP5(this);


  // Disable the auto draw for cp5 controller. With this we can draw cp5 manually and so
  // draw things over the controlP5 elements. 
  cp5_create.setAutoDraw(false);
  cp5_entry.setAutoDraw(false);
  cp5_extra.setAutoDraw(false);
  cp5_rs.setAutoDraw(false);
  cp5_event.setAutoDraw(false);
  cp5_name.setAutoDraw(false);

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

  t_event = cp5_event.addTextfield("eventName")
    .setPosition(180, 70)
    .setSize(130, 40)
    .setFont(createFont("arial", 20))
    .setColor(color(255))
    .setAutoClear(false)
    .setColorCaptionLabel(0);

  t_event.getCaptionLabel()
    .setText("\u30a4\u30d9\u30f3\u30c8\u540d")
    .align(ControlP5.LEFT_OUTSIDE, CENTER)
    .getStyle().setPaddingLeft(-10);

  t_name = cp5_name.addTextfield("name")
    .setPosition(180, 70)
    .setSize(130, 40)
    .setFont(createFont("arial", 20))
    .setColor(color(255))
    .setAutoClear(false)
    .setColorCaptionLabel(0);    

  t_name.getCaptionLabel()
    .setText("\u540d\u524d")
    .align(ControlP5.LEFT_OUTSIDE, CENTER)
    .getStyle().setPaddingLeft(-10);


  cp5_rs.addButton("entry")
    .setPosition(20, 20)
    .setSize(70, 30)
    .setCaptionLabel("Entry");

  // Calendar(x, y, width, height)
  //     | Class representing the whole calendar, including the days and upper titles.
  //
  // configure(startDay, nDays)
  //	   | Method of Calendar class.
  //	   | 	startDay - Represents which column day 1 is. (index start from 0)
  //	   |    nDays - number of days on month
  calendar = new Calendar(50, 50, 700, 500, cp5_create)
    .configure(3, 30);

  entryCalendar = new Calendar(50, 50, 700, 500, cp5_entry)
    .configure(3, 30);
}


public void draw() {
  if (screen == 0) {
    calendar.draw();
    cp5_extra.draw();
    cp5_event.draw();
  } else if (screen == 1) {
    clear();
    rs.draw();
    cp5_rs.draw();
    fill(0);
    textSize(25);
    text(eventName, 100, 40);
  } else if (screen == 2) {
    background(255);
    entryCalendar.draw();
    cp5_extra.draw();
    cp5_name.draw();
  }
}

public void selectAll() {
  if (screen == 0) {
    calendar.selectAll();
  } else if (screen == 2) {
    entryCalendar.selectAll();
  }
}

public void reset() {
  if (screen == 0) {
    calendar.clear();
  } else if (screen == 2) {
    entryCalendar.clear();
  }
}

public void ok() {

  if (screen == 0) {
    eventName = t_event.getText();
    days = calendar.selectedDays();
    rs = new ResultScreen(days);
    entryCalendar.keepSelectableOnlyDays(days);
  }

  if (screen == 2) {
    int entryDays[] = entryCalendar.selectedDays();
    Person person = new Person(t_name.getText(), entryDays, startX, days);
    startX += lineWidth;
    rs.addPerson(person);
    t_name.setText("");
    reset();
  }
  screen = 1;
}

public void entry() {
  screen = 2;
}

public void name() {
  println("text");
}

public void eventName() {
  println("text");
}
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
  public Calendar configure(int startDay, int nDays) {
    for (int n = 0; n < nDays; n++) {
      int i = (startDay + n) % 7;
      int j = (startDay + n) / 7;
      calendar[i][j].day = n + 1;
    }

    return this;
  }

  public void selectAll() {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 7; j++) {
        if (calendar[j][i].day > 0) {
          calendar[j][i].setActive(true);

          println(calendar[j][i].active);
        }
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

  public int[] selectedDays() {

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
  
  public void keepSelectableOnlyDays(int[] selectableDays) {
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
  
  public boolean selectableDaysContainsDay(int[] selectableDays, int day) {
    for (int i : selectableDays) {
      if (i == day) {
        return true;
      }
    }
    return false;
  }

  public void draw() {
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
    controller.setState(act);
    this.active = act;

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
    println(this.active);
  }
}


class Person {
  String name;
  int[] entryDays;
  int xPos;
  int[] selectableDays;

  Person(String name, int [] entryDays, int xPos, int[] selectableDays) {
    this.name = name;
    this.entryDays = entryDays;
    this.xPos = xPos;
    this.selectableDays = selectableDays;
  }

  public void draw() {
    int startY = 70;
    int lineHeight = 30;
    int lineWidth = 60;
    noFill();
    rectMode(CORNER);
    rect(xPos, startY, lineWidth, lineHeight);
    textAlign(CENTER);
    PFont f = createFont("Arial", 13, true); // STEP 2 Create Font
    textFont(f);                  // STEP 3 Specify font to be used
    fill(0);                      // STEP 4 Specify font color
    text(name, xPos + 30, startY + 20);

    // print a person's entry as "\u25cb" or "\u00d7"
    for (int i = 0; i < selectableDays.length; i++) {
      //noFill();
      if (searchElem(selectableDays[i], entryDays)) {
        fill(20, 230, 70);        
      } else {
        fill(230, 20, 70);
    }
      stroke(0);
      rect(xPos, startY + (i + 1) * lineHeight, lineWidth, lineHeight);
      textAlign(LEFT);
      rectMode(CORNER);

      fill(0);
      if (searchElem(selectableDays[i], entryDays)) {
        text("\u25cb", xPos + 23, startY + (i + 1) * lineHeight + 20);
      } else 
      text("\u00d7", xPos + 23, startY + (i + 1) * lineHeight + 20);
    }
  }

  public boolean searchElem(int Elem, int[] array) {
    for (int i = 0; i < array.length; i++) {
      if (Elem == array[i]) {
        return true;
      }
    }
    return false;
  }
}
class ResultScreen {
  int selectableDays[];
  Person[] personList = new Person[30];
  int personIndex;
  int[] maruSum;
  Map<Integer, Integer> selectableDaysMap;

  ResultScreen(int[] days) {
    selectableDays = days;
    maruSum = new int[selectableDays.length];

    selectableDaysMap = new HashMap<Integer, Integer>();

    for (int i = 0; i < selectableDays.length; i++) {
      selectableDaysMap.put(selectableDays[i], i);
      maruSum[i] = 0;
    }
  }

  public void draw() {
    rectMode(CORNER);
    background(255);


    int startX = 20;
    int startY = 100;
    int lineHeight = 30;
    int lineWidth = 60;

    for (int i = 0; i < selectableDays.length; i++) {
      noFill();
      stroke(0);
      rect(startX, startY + i * lineHeight, lineWidth, lineHeight);
      PFont f = createFont("Arial", 12, true); // STEP 2 Create Font
      textFont(f);                  // STEP 3 Specify font to be used
      fill(0);                      // STEP 4 Specify font color
      textAlign(LEFT);
      rectMode(CORNER);
      text("\uff16\u6708" + Integer.toString(selectableDays[i]) + "\u65e5", startX + 5, startY + i * lineHeight + 20);
    }
    //rect(width / 2, height / 2, 0.8 * width, selectableDays.length * 30);

    //print person entry result
    int count = 0;
    
    for (int i = 0; i < personList.length; i++) {
      if (personList[i] == null) {
        count = i;
        break;
      }
        
      personList[i].draw();
    }

    for (int i = 0; i < selectableDays.length; i++) {
      noFill();
      rect(80 + count * lineWidth, startY + i * lineHeight, lineWidth, lineHeight);
      textAlign(CENTER);
      text(Integer.toString(maruSum[i]), 80 + count * lineWidth, startY + 9 +  i * lineHeight, lineWidth, lineHeight);
    }
    
  }

  //add person to personList
  public void addPerson(Person person) {
    personList[personIndex++] = person;

    for (int entryDay : person.entryDays) {
      maruSum[selectableDaysMap.get(entryDay)]++;
    }
  }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "calendar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
