class ResultScreen {
  int selectableDays[];
  Person[] personList = new Person[30];
  int personIndex;

  ResultScreen(int[] days) {
    selectableDays = days;
  }

  void draw() {
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
      text("６月" + Integer.toString(selectableDays[i]) + "日", startX + 5, startY + i * lineHeight + 20);
    }
    //rect(width / 2, height / 2, 0.8 * width, selectableDays.length * 30);

    //print person entry result
    for (int i = 0; i < personList.length; i++) {
      if (personList[i] == null) break;
      personList[i].draw();
    }
  }

  //add person to personList
  void addPerson(Person person) {
    personList[personIndex++] = person;
  }
}