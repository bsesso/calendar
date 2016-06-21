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

  Day setPosition(int x, int y) {
    this.x = x;
    this.y = y;
    controller.setPosition(x, y);

    return this;
  }

  Day setSize(int w, int h) {
    this.height = h;
    this.width = w;
    controller.setSize(w, h);

    return this;
  }

  Day setActive(boolean act) {
    controller.setState(act);
    this.active = act;

    return this;
  }

  void draw() {
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

  void drawLabel() {
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