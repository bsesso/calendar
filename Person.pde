import java.util.*;

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

  void draw() {
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

    // print a person's entry as "○" or "×"
    for (int i = 0; i < selectableDays.length; i++) {
      noFill();
      stroke(0);
      rect(xPos, startY + (i + 1) * lineHeight, lineWidth, lineHeight);
      textAlign(LEFT);
      rectMode(CORNER);

      if (searchElem(selectableDays[i], entryDays)) {
        text("○", xPos + 23, startY + (i + 1) * lineHeight + 20);
      } else 
      text("×", xPos + 23, startY + (i + 1) * lineHeight + 20);
    }
  }

  boolean searchElem(int Elem, int[] array) {
    for (int i = 0; i < array.length; i++) {
      if (Elem == array[i]) {
        return true;
      }
    }
    return false;
  }
}