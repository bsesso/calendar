class ResultScreen {
  int selectableDays[];
  Person[] personList = new Person[30];
  int personIndex;
  int maruSumMax = 0;
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
    int count = 0;
    
    for (int i = 0; i < personList.length; i++) {
      if (personList[i] == null) {
        count = i;
        break;
      }
        
      personList[i].draw();
    }
    noFill();
    rect(80 + count * lineWidth, 70, lineWidth, lineHeight);
    textAlign(CENTER);
    PFont f = createFont("Arial", 13, true); // STEP 2 Create Font
    textFont(f);                  // STEP 3 Specify font to be used
    fill(0);                      // STEP 4 Specify font color
    text("total", 80 + count * lineWidth + 30, 70 + 20);
    for (int i = 0; i < selectableDays.length; i++) {
      if (maruSum[i] == maruSumMax) {
        fill(0, 200, 30);
      } else {
        noFill();
      }
      rect(80 + count * lineWidth, startY + i * lineHeight, lineWidth, lineHeight);
      textAlign(CENTER);
      fill(0);
      text(Integer.toString(maruSum[i]), 80 + count * lineWidth, startY + 9 +  i * lineHeight, lineWidth, lineHeight);
    }
    
  }

  //add person to personList
  void addPerson(Person person) {
    personList[personIndex++] = person;

    for (int entryDay : person.entryDays) {
      maruSum[selectableDaysMap.get(entryDay)]++;
      if (maruSum[selectableDaysMap.get(entryDay)] > maruSumMax) {
        maruSumMax = maruSum[selectableDaysMap.get(entryDay)];
      }
    }
  }
}