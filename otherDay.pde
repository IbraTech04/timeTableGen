int periodOther, dayOfMonth; //<>//
char currentCohortOther;
boolean noSchoolOther;
String otherCalDate;
void parseDate(String lineIn) {
  if (view == 0) {
    try {
      lineIn = lineIn.toUpperCase();
      if (lineIn.equals("TOMORROW")) {
        Calendar c = Calendar.getInstance();
        Calendar today = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, day()+1);
        int ID = c.get(Calendar.DAY_OF_YEAR) - today.get(Calendar.DAY_OF_YEAR);
        dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
        String dayOfWeek = testWeek[0][c.get(Calendar.DAY_OF_WEEK)];
        String month = testMonth[0][c.get(Calendar.MONTH)+1];
        otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";

        getDataFromWeekView(ID);
      } else if (lineIn.equals("TODAY")) {
        screenNumber = 0;
      } else if (lineIn.equals("WEDNESDAY") || lineIn.equals("WED")) {
        Calendar today = Calendar.getInstance();
        int ID = preCheckWed(false);
        getDataFromWeekView(ID);
      } else if (lineIn.equals("NEXT WEDNESDAY") || lineIn.equals("NEXT WED")) {
        int ID = preCheckWed(true);
        getDataFromWeekView(ID);
      } else {
        Calendar today = Calendar.getInstance();
        String[] split = split(lineIn, '/');
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, int(split[1]));
        c.set(Calendar.MONTH, int(split[0]) - 1);

        int ID = c.get(Calendar.DAY_OF_YEAR) - today.get(Calendar.DAY_OF_YEAR);
        getDataFromWeekView(ID);

        dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
        String dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
        String month = months[c.get(Calendar.MONTH) + 1];
        dayOfWeek = testWeek[lang][c.get(Calendar.DAY_OF_WEEK)];
        month = testMonth[lang][c.get(Calendar.MONTH) + 1];
        otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";
      }
    }
    catch (Exception e) {
      booster.showErrorDialog("Invalid Date Entered. Please Try again", "Error");
      screenNumber = 0;
    }
  } else if (view == 1) {
    Calendar toView = Calendar.getInstance();
    int day = toView.get(Calendar.DAY_OF_YEAR);
    transScale = (-91.8651685*day)-(height*0.333333333) + height-720;
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
      text(P1[lang] + p1Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 1 && cohort == 'A') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 2 && cohort == 'A') {
      text(P1[lang] + p2Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 2 && cohort == 'A') {
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 1 && cohort == 'B') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 1 && cohort == 'B') {
      text(P1[lang] + p1Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 2 && cohort == 'B') {
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 2 && cohort == 'B') {
      text(P1[lang] + p2Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else   if (currentCohortOther == 'A' && periodOther == 1 && cohort == 'C') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 1 && cohort == 'C') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'A' && periodOther == 2 && cohort == 'C') {
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohortOther == 'B' && periodOther == 2 && cohort == 'C') {
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    }
  }
  popMatrix();
}

boolean noSchoolOther(String weekDay, int day, int month) {

  if (weekDay == "Saturday" || weekDay == "Sunday") {
    reason = "Weekend";
    return true;
  } else if (paDayOther(day, month+1)) {
    reason = "PA Day";
    return true;
  } else {
    return false;
  }
}
boolean paDayOther(int day, int month) {
  int[] months = {2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 6, 6};
  int[] days = {15, 2, 5, 12, 13, 14, 15, 16, 26, 27, 24, 28, 29};
  for (int i = 0; i < days.length; i++) { 
    if (day == days[i] && month == months[i]) {

      return true;
    }
  }
  return false;
}
int preCheckWed(boolean next) {
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
  } else if ((wed.get(Calendar.DAY_OF_WEEK)) == 7) {
    changeFactor += 4;
  }
  wed.set(Calendar.DAY_OF_MONTH, wed.get(Calendar.DAY_OF_MONTH)+changeFactor);

  String month = months[wed.get(Calendar.MONTH) + 1];
  dayOfMonth = wed.get(Calendar.DAY_OF_MONTH);
  String dayOfWeek = week[wed.get(Calendar.DAY_OF_WEEK)];
  otherCalDate = dayOfWeek + " " + month + " " + dayOfMonth + " 2021";
  return changeFactor;
}

void getDataFromWeekView(int ID) {
  if (rects.get(ID).getInd().equals("A1")) {
    noSchoolOther = false;
    currentCohortOther = 'A';
    periodOther = 1;
  } else if (rects.get(ID).getInd().equals("A2")) {
    noSchoolOther = false;
    currentCohortOther = 'A';
    periodOther = 2;
  } else if (rects.get(ID).getInd().equals("B1")) {
    noSchoolOther = false;
    currentCohortOther = 'B';
    periodOther = 1;
  } else if (rects.get(ID).getInd().equals("B2")) {
    noSchoolOther = false;
    currentCohortOther = 'B';
    periodOther = 2;
  } else {
    noSchoolOther = true;
  }
}
