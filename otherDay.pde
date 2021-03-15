int periodOther, dayOfMonth;
char currentCohortOther;
boolean noSchoolOther;
String otherCalDate;
void parseDate(String lineIn) {
  try {
    lineIn = lineIn.toUpperCase();
    if (lineIn.equals("TOMORROW")) {
      Calendar c = Calendar.getInstance();
      c.set(Calendar.DAY_OF_MONTH, day()+1);
      dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
      c.set(Calendar.MONTH, month()-1);
      String dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
      String month = months[c.get(Calendar.MONTH)];
      calculateClassesOther(dayOfWeek, month);
      noSchoolOther = noSchoolOther(dayOfWeek, c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.MONTH)+1);
      otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";
    } else if (lineIn.equals("TODAY")) {
      screenNumber = 0;
    } else if (lineIn.equals("WEDNESDAY") || lineIn.equals("WED")) {
      checkWedOther(preCheckWed(false));
    } else if (lineIn.equals("NEXT WEDNESDAY") || lineIn.equals("NEXT WED")) {
      checkWedOther(preCheckWed(true));
    } else {
      String[] split = split(lineIn, '/');
      Calendar c = Calendar.getInstance();
      c.set(Calendar.DAY_OF_MONTH, int(split[1]));
      c.set(Calendar.MONTH, int(split[0]) - 1);
      dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
      String dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
      String month = months[c.get(Calendar.MONTH) + 1];
      calculateClassesOther(dayOfWeek, month);
      noSchoolOther = noSchoolOther(dayOfWeek, c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.MONTH)+1);
      otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";
    }
  }
  catch (Exception e) {
    booster.showErrorDialog("Invalid Date Entered. Please Try again", "Error");
    screenNumber = 0;
  }
}
void calculateClassesOther(String day, String month) {
  if (day.equals("Monday")) {
    currentCohortOther = 'A';
    periodOther = 1;
  } else if (day.equals("Tuesday")) {
    currentCohortOther = 'A';
    periodOther = 2;
  } else if (day.equals("Thursday")) {
    currentCohortOther = 'B';
    periodOther = 1;
  } else if (day.equals("Friday")) {
    currentCohortOther = 'B';
    periodOther = 2;
  } else {
    String toPass = month + year();
    checkWedOther(toPass);
  }
}
void checkWedOther(String toPass) {
  for (int i = 0; i < wedDates.length; i++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[i];
    if (temp.equals(toPass)) {
      loadWedOther(i);
      break;
    }
  }
}
void loadWedOther(int i) {
  for (int j = i; j < wedDates.length; j++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[j];
    if (temp.equals(str(dayOfMonth))) {
      if (wedDates[j+1].equals("A1")) {
        currentCohortOther = 'A';
        periodOther = 1;
      } else if (wedDates[j+1].equals("B1")) {
        currentCohortOther = 'B';
        periodOther = 1;
      } else if (wedDates[j+1].equals("A2")) {
        currentCohortOther = 'A';
        periodOther = 2;
      } else if (wedDates[j+1].equals("B2")) {
        currentCohortOther = 'B';
        periodOther = 2;
      }
      break;
    }
  }
}

void drawTimesOther() {
  pushMatrix();
  translate(0, 50);
  if (noSchoolOther) {
    text("No School today. Reason: " + reason, width/2, height/2-105); //Drawing   times
  } else {
    if (currentCohortOther == 'A' && periodOther == 1 && cohort == 'A') {
      text("P1: " + p1Class + " In Class", width/2, height/2-105); //Drawing   times
      text("P2: " + p2Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 1 && cohort == 'A') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p2Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 2 && cohort == 'A') {
      text("P1: " + p2Class + " In Class", width/2, height/2-105); //Drawing   times
      text("P2: " + p1Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 2 && cohort == 'A') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p1Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 1 && cohort == 'B') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p2Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 1 && cohort == 'B') {
      text("P1: " + p1Class + " In Class", width/2, height/2-105); //Drawing   times
      text("P2: " + p2Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 2 && cohort == 'B') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p1Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 2 && cohort == 'B') {
      text("P1: " + p2Class + " In Class", width/2, height/2-105); //Drawing   times
      text("P2: " + p1Class + " At home", width/2, height/2-52);
    } else   if (currentCohortOther == 'A' && periodOther == 1 && cohort == 'C') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p2Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 1 && cohort == 'C') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p2Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 2 && cohort == 'C') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p1Class + " At home", width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 2 && cohort == 'C') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing   times
      text("P2: " + p1Class + " At home", width/2, height/2-52);
    }
  }
  popMatrix();
}

boolean noSchoolOther(String weekDay, int day, int month) {
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
boolean paDayOther(int day, int month) {
  int[] months = {2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5};
  int[] days = {15, 2, 5, 12, 13, 14, 15, 16, 26, 27, 24};
  for (int i = 0; i < days.length; i++) { 
    if (day == days[i] && month == months[i]) {
      println(day,month);
      return true;
    }
  }
  return false;
}
String preCheckWed(boolean next) {
  int changeFactor = 0;
  if (next) {
    changeFactor = 7;
  } else {
    changeFactor = 0;
  }
  Calendar wed = Calendar.getInstance();

  wed.set(Calendar.DAY_OF_MONTH, day());
  wed.set(Calendar.MONTH, month()-1);

  if ((wed.get(Calendar.DAY_OF_WEEK)) == 1) {
    changeFactor += 3;
  } else if ((wed.get(Calendar.DAY_OF_WEEK)) == 2) {
    changeFactor += 2;
  } else if ((wed.get(Calendar.DAY_OF_WEEK)) == 3) {
    changeFactor += 1;
  } else if ((wed.get(Calendar.DAY_OF_WEEK)) == 4) {
    changeFactor += 7;
  } else if ((wed.get(Calendar.DAY_OF_WEEK)) == 5) {
    changeFactor += 6;
  } else if ((wed.get(Calendar.DAY_OF_WEEK)) == 6) {
    changeFactor += 5;
  } else if ((wed.get(Calendar.DAY_OF_WEEK)) == 0) {
    changeFactor += 4;
  }


  wed.set(Calendar.DAY_OF_MONTH, wed.get(Calendar.DAY_OF_MONTH)+changeFactor);

  String month = months[wed.get(Calendar.MONTH) + 1];
  String toPass = month + year();
  dayOfMonth = wed.get(Calendar.DAY_OF_MONTH);
  String dayOfWeek = week[wed.get(Calendar.DAY_OF_WEEK)];
  otherCalDate = dayOfWeek + " " + month + " " + dayOfMonth + " 2021";
  noSchoolOther = noSchoolOther(dayOfWeek, wed.get(Calendar.DAY_OF_MONTH), wed.get(Calendar.MONTH));

  return toPass;
}
