void mouseDragged() {    
  toSubtract = pmouseY-mouseY;
}

void mouseReleased() {
  toSubtract += (pmouseY-mouseY)*1.2;
}

float toSubtract;
void weekView() {
  transScale -= toSubtract;
  if (toSubtract > 0) {
    if (toSubtract > 250) {
      toSubtract-=15;
    } else {
      toSubtract-=2.5;
    }
    if (toSubtract < 0) {
      toSubtract = 0;
    }
  } else if (toSubtract < 0) {
    if (toSubtract < -250) {
      toSubtract+=15;
    } else {
      toSubtract+=2.5;
    }
  }
  if (transScale > 250) {
    toSubtract -=7;
  }
  if (transScale > 150) {
    toSubtract -=5;
  }
  if (transScale > 0) {
    transScale = 0;
  } 
  if (transScale < (-100*daysLeft)-((height*0.102986612)*2) + height - 50) {
    transScale = (-100*daysLeft)-((height*0.102986612)*2) + height - 50;
    toSubtract = 0;
  } 
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2], alpha);
  textAlign(CENTER);
  fill(colors[0], colors[1], colors[2], alpha);
  // strokeWeight(2);
  //stroke(textColor[0], textColor[1], textColor[2], alpha);
  pushMatrix();
  translate(0, height*0.145833333);
  translate(0, transScale);
  for (int i = 0; i < getMaxVal(); i++) {
    if (i >= int(Math.abs(transScale/100))-1) {
      rects.get(i).drawRect();
    }
    translate(0, 100);
  }
  noStroke();
  popMatrix();
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height, 20, 20, 0, 0); //These two are the two rectangles on the top and bottom
  imageMode(CENTER);
  image(settingsp, height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar, width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(weekV, width/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  rect(0, 0, width, height*0.102986612, 0, 0, 20, 20);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  textFont(font, 50); //Setting Text Font
  textAlign(CENTER);
  text("TMTimeTable WeekView™ Beta", width/2, height*0.0494444444 + 25); //Top Text
}

void mouseWheel(MouseEvent event) {
  if (view == 1 && screenNumber == 0) {
    float e = event.getCount();
    toSubtract += e*8.75;
    if (toSubtract < 0&&transScale == 0) {
      toSubtract = 0;
    }
  }
}
void initWeekView() {
  rects.clear();
  viewWeek.set(Calendar.MONTH, 5);
  viewWeek.set(Calendar.DAY_OF_MONTH, 29);
  viewWeek.set(Calendar.YEAR, 2022);
    int toAdd = 365;
  if (cal.get(Calendar.YEAR) == 2022){
     toAdd = 0;
  }
  daysLeft = ((viewWeek.get(Calendar.DAY_OF_YEAR) + toAdd) - cal.get(Calendar.DAY_OF_YEAR)) + 1;

  for (int i = cal.get(Calendar.DAY_OF_YEAR); i <= viewWeek.get(Calendar.DAY_OF_YEAR) + toAdd; i++) {
    Calendar temp = Calendar.getInstance();
    int integer = i;
    if (i > 365){
       integer -= 365;
       temp.set(Calendar.YEAR, 2022);
    }
    temp.set(Calendar.DAY_OF_YEAR, integer);
    rects.add(new WeekRect(i - cal.get(Calendar.DAY_OF_YEAR), i));
  }
}
boolean noSchoolWeek(String weekDay, int day, int month) {
  if (weekDay == "Saturday" || weekDay == "Sunday") {
    reason = "Weekend";
    return true;
  } else if (paDayOther(day, month)) {
    reason = "PA Day";
    return true;
  } else {
    return false;
  }
}

double getMaxVal() {
  if (int((height + 300)) / 100 + Math.ceil(Math.abs(transScale)/100) < daysLeft) {
    return int((height + 300)) / 100 + Math.ceil(Math.abs(transScale)/100);
  } else {
    double toSubtract = int((height + 300)) / 100 + Math.ceil(Math.abs(transScale)/100) - daysLeft;
    return int((height + 300)) / 100 + Math.ceil(Math.abs(transScale)/100) - toSubtract;
  }
}
