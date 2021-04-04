String[] parseDateWeekView(String lineIn) {
  String[] split = split(lineIn, '/');
  Calendar c = Calendar.getInstance();
  c.set(Calendar.DAY_OF_MONTH, int(split[1]));
  c.set(Calendar.MONTH, int(split[0]) - 1);
  int dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
  String dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
  String month = months[c.get(Calendar.MONTH) + 1];
  noSchoolOther = noSchoolWeek(dayOfWeek, c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.MONTH)+1);
  otherCalDate = month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";
  String[] toReturn = {dayOfWeek, otherCalDate, str(noSchoolWeek(dayOfWeek, c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.MONTH)+1)), calculateClassesWeekView(dayOfWeek, month, dayOfMonth)};
  return toReturn;
}
float toSubtract;
void weekView() {
  transScale -= toSubtract;
  if (toSubtract > 0) {
    if (toSubtract > 150) {
      toSubtract-=15;
    } else {
      toSubtract-=2.5;
    }
    if (toSubtract < 0) {
      toSubtract = 0;
    }
  } else if (toSubtract < 0) {
    if (toSubtract < -150) {
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
  if (transScale < (-91.8651685*daysLeft)-(height*0.333333333) + height-720) {
    transScale =  (-91.8651685*daysLeft)-(height*0.333333333) + height-720;
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
  for (int i = 0; i < daysLeft; i++) {
    rects.get(i).drawRect();
    translate(0, 100);
  }
  noStroke();
  popMatrix();
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height); //These two are the two rectangles on the top and bottom
  imageMode(CENTER);
  image(settingsp, height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar, width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  //image(weekV, width/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  rect(0, 0, width, height*0.102986612);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  textFont(font, 50); //Setting Text Font
  textAlign(CENTER);
  text("TMTimeTable WeekView™ Beta", width/2, height*0.0494444444 + 25); //Top Text
}

void mouseWheel(MouseEvent event) {
  if (view == 1 && screenNumber == 0) {
    float e = event.getCount();
    toSubtract += e*10;
    if (toSubtract < 0&&transScale == 0) {
      toSubtract = 0;
    }
  }
}
void initWeekView() {
  rects.clear();
  viewWeek.set(Calendar.MONTH, 5);
  viewWeek.set(Calendar.DAY_OF_MONTH, 29);
  daysLeft = (viewWeek.get(Calendar.DAY_OF_YEAR) - cal.get(Calendar.DAY_OF_YEAR));
  for (int i = cal.get(Calendar.DAY_OF_YEAR) - 1; i < viewWeek.get(Calendar.DAY_OF_YEAR); i++) {
    Calendar temp = Calendar.getInstance();
    temp.set(Calendar.DAY_OF_YEAR, i);
    String arg = str(temp.get(Calendar.MONTH) + 1) + "/" + str(temp.get(Calendar.DAY_OF_MONTH) +1);
    rects.add(new WeekRect(parseDateWeekView(arg)));
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
String calculateClassesWeekView(String day, String month, int dayOfMonth) {
  if (day.equals("Monday")) {
    return "A1";
  } else if (day.equals("Tuesday")) {
    return "A2";
  } else if (day.equals("Thursday")) {
    return "B1";
  } else if (day.equals("Friday")) {
    return "B2";
  } else {
    String toPass = month + year();
    return checkWedWeek(toPass, dayOfMonth);
  }
}
String checkWedWeek(String toPass, int a) {
  for (int i = 0; i < wedDates.length; i++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[i];
    if (temp.equals(toPass)) {
      return loadWedWeek(i, a);
    }
  }
  return " ";
}
String loadWedWeek(int i, int a) {
  for (int j = i; j < wedDates.length; j++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[j];
    if (temp.equals(str(a))) {
      return wedDates[j+1];
    }
  }
  return " ";
}
