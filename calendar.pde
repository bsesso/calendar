import controlP5.*;

ControlP5 cp5_create, cp5_entry, cp5_extra, cp5_rs, cp5_event, cp5_name;
Calendar calendar, entryCalendar;
Textfield t_event, t_name;
String eventName;
int startX = 80;
int lineWidth = 60;
int[] days;
int screen;

ResultScreen rs;

color activeColor = color(0, 200, 30);
color unselectableColor = color(200);
color unactiveColor = color(255);


void setup() {
  // pixelDensity(displayDensity());
  size(800, 800);

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
    .setText("イベント名")
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
    .setText("名前")
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


void draw() {
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

void selectAll() {
  if (screen == 0) {
    calendar.selectAll();
  } else if (screen == 2) {
    entryCalendar.selectAll();
  }
}

void reset() {
  if (screen == 0) {
    calendar.clear();
  } else if (screen == 2) {
    entryCalendar.clear();
  }
}

void ok() {

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

void entry() {
  screen = 2;
}

void name() {
  println("text");
}

void eventName() {
  println("text");
}