public class ClickableText {
  String text;
  int textPosX;
  int textPosY;
  int textSize;
  boolean isCenter = false;
  public boolean isPressed() {
    if (isCenter) {
      if (mouseX >= textPosX - ((text.length())*textSize/2)/2 && mouseX <= textPosX + ((text.length())*textSize/2)/2 && mouseY >= textPosY-textSize && mouseY <= textPosY) {
        return true;
      }
      return false;
    } else {
      if (mouseX >= textPosX && mouseX <= (text.length())*textSize/2 && mouseY >= textPosY-textSize && mouseY <= textPosY) {
        return true;
      } else {
        return false;
      }
    }
  }
  public void drawText() {
    if (isCenter) {
      textAlign(CENTER);
    } else {
      textAlign(LEFT);
    }
    text(text, textPosX, textPosY);
  }
  public void setText(String tempText) {
    text = tempText;
  }
  public void setSize(int size) {
    textSize = size;
  }
  public void setPos(int x, int y) {
    textPosX = x;
    textPosY = y;
  }

  public void setMode(String mode) {
    if (mode.toUpperCase().equals("CENTER")) {
      isCenter = true;
    } else {
      isCenter = false;
    }
  }
  public int getTextSize() {
    return textSize;
  }
  public int getTextX() {
    return textPosX;
  }
  public int getTextY() {
    return textPosY;
  }
  public String getText() {
    return text;
  }
}

class WeekRect {
  int id;
  String day;
  String dayPt2;
  String P1Class;
  String P2Class;
  boolean noSchool;
  String indent;
  Calendar cal = Calendar.getInstance();
  public WeekRect(String[] args, int newID, int dayOfYear) {
    day = args[0];
    dayPt2 = args[1];
    cal.set(Calendar.DAY_OF_YEAR, dayOfYear);
    if (args[2].equals("true")) {
      noSchool = true;
      actualDaysLeft--;
    } else {
      noSchool = false;
    }
    indent = args[3];
    if (cohort == 'A') {
      if (args[3].equals("A1")) {
        P1Class = p1Class + inSchool[lang];
        P2Class = p2Class + atHome[lang];
      } else if (args[3].equals("A2")) {
        P1Class = p2Class + inSchool[lang];
        P2Class = p1Class + atHome[lang];
      } else if (args[3].equals("B1")) {
        P1Class = p1Class + atHome[lang];
        P2Class = p2Class + atHome[lang];
      } else if (args[3].equals("B2")) {
        P1Class = p2Class + atHome[lang];
        P2Class = p1Class + atHome[lang];
      }
    } else if (cohort == 'B') {
      if (args[3].equals("A1")) {
        P1Class = p1Class + atHome[lang];
        P2Class = p2Class + atHome[lang];
      } else if (args[3].equals("A2")) {
        P1Class = p2Class + atHome[lang];
        P2Class = p1Class + atHome[lang];
      } else if (args[3].equals("B1")) {
        P1Class = p1Class + inSchool[lang];
        P2Class = p2Class + atHome[lang];
      } else if (args[3].equals("B2")) {
        P1Class = p2Class + inSchool[lang];
        P2Class = p1Class + atHome[lang];
      }
    } else {
      if (args[3].equals("A1")) {
        P1Class = p1Class + atHome[lang];
        P2Class = p2Class + atHome[lang];
      } else if (args[3].equals("A2")) {
        P1Class = p2Class + atHome[lang];
        P2Class = p1Class + atHome[lang];
      } else if (args[3].equals("B1")) {
        P1Class = p1Class + atHome[lang];
        P2Class = p2Class + atHome[lang];
      } else if (args[3].equals("B2")) {
        P1Class = p2Class + atHome[lang];
        P2Class = p1Class + atHome[lang];
      }
    }
    id = newID;
  }

  public void drawRect() {
    if (noSchool) {
      fill(colors[0], colors[1], colors[2], alpha);
      rect(10, 10, width-20, 90, 15, 15, 15, 15);
      fill(textColor[0], textColor[1], textColor[2], alpha);
      textAlign(LEFT);
      textSize(25);
      text(day + "\n" + dayPt2, 20, 45);
      textSize(35);
      text("No School", 240, 65);
    } else {
      fill(colors[0], colors[1], colors[2], alpha);
      rect(10, 10, width-20, 90, 15, 15, 15, 15);
      fill(textColor[0], textColor[1], textColor[2], alpha);
      textAlign(LEFT);
      textFont(font, 25); //Setting Text Font
      text(day + "\n" + dayPt2, 20, 45);
      textFont(font, 30); //Setting Text Font
      text(P1[lang] + P1Class, 240, 45);
      text(P2[lang] + P2Class, 240, 85);
    }
    if (mousePressed && mouseX >= 10 && mouseX <= width-20 && mouseY >= ((id*100) + (height*0.145833333)) + transScale && mouseY <= ((id*100) + (height*0.145833333) +transScale) + 90) {
      if (mouseY < height -  height*0.102986612) {
        event = cal;
        screenNumber = 4;
      }
    }
  }

  public String getP1() {
    return P1Class;
  }
  public String getP2() {
    return P2Class;
  }

  public String getInd() {
    if (noSchool) {
      return "NS";
    } else {
      return indent;
    }
  }
}

void addEvent(Calendar cal) {
  String eventName = getEvent();
  String period = getPeriod();
  events.add(new Event(cal, eventName, period));
  saveEvents();
}

void addEvent(int dayOfYear, String event, String period) {
  Calendar cal = Calendar.getInstance();
  cal.set(Calendar.DAY_OF_YEAR, dayOfYear);
  events.add(new Event(cal, event, period));
}

String getPeriod() {
  String test = booster.showTextInputDialog("What Period is this event? (P1/P2)");
  if (test != null) {
    if (test.toUpperCase().equals("P1") || test.toUpperCase().equals("P2")) {
      return test.toUpperCase();
    } else {
      getPeriod();
    }
  }
  return "";
}

String getEvent() {
  return booster.showTextInputDialog("What is the name of this event?");
}

class Event {
  String eventTitle;
  String period;
  int day;
  int month;
  Calendar cal;
  public Event(Calendar localCal, String eventName, String per) {
    cal = localCal;
    day = localCal.get(Calendar.DAY_OF_MONTH);
    month = localCal.get(Calendar.MONTH) + 1;
    eventTitle = eventName;
    period = per;
  }

  public void drawRect() {
    fill(colors[0], colors[1], colors[2]);
    rect(10, 10, width-20, 90, 15, 15, 15, 15);
    fill(textColor[0], textColor[1], textColor[2]);
    textAlign(LEFT);
    textFont(font, 40); //Setting Text Font
    text(eventTitle, 20, 65);
  }
  int getDayOfYear() {
    return cal.get(Calendar.DAY_OF_YEAR);
  }
  String getPeriod() {
    return period;
  }
  String getTitle() {
    return eventTitle;
  }
}
public void loadEvents() {
  try {
    String[] stringEvent = loadStrings(System.getProperty("user.home")+"\\TMTimeTable\\event.txt");
    for (int i = 0; i < stringEvent.length; i++) {
      String[] temp = split(stringEvent[i], ':');
      addEvent(int(temp[0]), temp[1], temp[2]);
    }
  }
  catch (Exception e) {
  }
}
public void saveEvents() {
  PrintWriter EventSaver = createWriter(System.getProperty("user.home")+"\\TMTimeTable\\event.txt");
  for (int i = 0; i < events.size(); i++) {
    String[] toSave = new String[3];
    toSave[0] = str(events.get(i).getDayOfYear());
    toSave[1] = events.get(i).getTitle();
    toSave[2] = events.get(i).getPeriod();
    EventSaver.println(toSave[0] + ":" + toSave[1] + ":" + toSave[2]);
    EventSaver.flush();
  }
  EventSaver.close();
}

class Theme {
}
