int periodOther, dayOfMonth; //<>//
boolean noSchoolOther;
String otherCalDate;
int weekNumOther;

void parseDate(String lineIn) {
  if (view == 0) {
    try {
      lineIn = lineIn.toUpperCase();
      if (lineIn.equals("TOMORROW")) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, day()+1);
        dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
        String dayOfWeek = testWeek[0][c.get(Calendar.DAY_OF_WEEK)];
        String month = testMonth[0][c.get(Calendar.MONTH)+1];
        otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";
        weekNumOther = getWeekNum(c.get(Calendar.MONTH) + 1, c.get(Calendar.DAY_OF_MONTH));
      } else if (lineIn.equals("TODAY")) {
        screenNumber = 0;
      } else {
        String[] split = split(lineIn, '/');
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, int(split[1]));
        c.set(Calendar.MONTH, int(split[0]) - 1);
        /*
        int ID = c.get(Calendar.DAY_OF_YEAR) - today.get(Calendar.DAY_OF_YEAR);
        getDataFromWeekView(ID);
*/
        weekNumOther = getWeekNum(c.get(Calendar.MONTH) + 1, c.get(Calendar.DAY_OF_MONTH));

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

void drawTimesOther() {
  pushMatrix();
  translate(0, 50);
  if (noSchool()) {
    text("No School today. Reason: " + reason, width/2, height/2-105); //Drawing   times
  } else {
    text(P1[lang] + courses[weekNumOther][0], width/2, height/2-105); //Drawing   times
    text(P2[lang] +courses[weekNumOther][1], width/2, height/2-52);
  }
  popMatrix();
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
