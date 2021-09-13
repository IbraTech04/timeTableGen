int periodOther, dayOfMonth; //<>//
boolean noSchoolOther;
String otherCalDate;
int weekNumOther;

void parseDate(String lineIn) {
  noSchoolOther = false;
  if (view == 0) {
    try {
      lineIn = lineIn.toUpperCase();
      if (lineIn.equals("TOMORROW")) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, day()+1);
        dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
        String dayOfWeek = testWeek[0][c.get(Calendar.DAY_OF_WEEK)];
        String month = testMonth[0][c.get(Calendar.MONTH)+1];
        otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " " + c.get(Calendar.YEAR);
        weekNumOther = getWeekNum(c.get(Calendar.MONTH) + 1, c.get(Calendar.DAY_OF_MONTH));
        if (dayOfWeek.equals("Sunday") || dayOfWeek.equals("Saturday")) {
          noSchoolOther = true;
        } else if (paDay(c.get(Calendar.MONTH)+1, c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.YEAR))) {
          noSchoolOther = true;
        }
      } else if (lineIn.equals("TODAY")) {
        screenNumber = 0;
      } else {
        String[] split = split(lineIn, '/');
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, int(split[1]));
        c.set(Calendar.MONTH, int(split[0]) - 1);

        weekNumOther = getWeekNum(c.get(Calendar.MONTH) + 1, c.get(Calendar.DAY_OF_MONTH));

        dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
        String dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
        String month = months[c.get(Calendar.MONTH) + 1];
        dayOfWeek = testWeek[lang][c.get(Calendar.DAY_OF_WEEK)];
        month = testMonth[lang][c.get(Calendar.MONTH) + 1];
        otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " " + c.get(Calendar.YEAR);
        if (dayOfWeek.equals("Sunday") || dayOfWeek.equals("Saturday")) {
          noSchoolOther = true;
        } else if (paDay(c.get(Calendar.MONTH)+1, c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.YEAR))) {
          noSchoolOther = true;
        }
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
  if (noSchoolOther) {
    text("No School", width/2, height/2-105); //Drawing   times
  } else {
    text(P1[lang] + courses[weekNumOther][0], width/2, height/2-105); //Drawing   times
    text(P2[lang] +courses[weekNumOther][1], width/2, height/2-52);
  }
  popMatrix();
}
