import java.util.Calendar; //Import Calendar Functions
import uibooster.*;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import java.awt.Dimension;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;

int col;
boolean isConfirmed;

ArrayList<WeekRect> rects = new ArrayList<WeekRect>();
ArrayList<ClickableText> settings = new ArrayList<ClickableText>();
ArrayList<Event> events = new ArrayList<Event>();

Calendar cal = Calendar.getInstance(); //Get calendar date
Calendar viewWeek = Calendar.getInstance(); //Get calendar date
Calendar event = Calendar.getInstance(); 

ClickableText A, B, C;

UiBooster booster;
void settings() {
  size(1280, 720);
}

void setup() {
  A = new ClickableText();
  A.setText("A");
  A.setMode("CENTER");
  A.setPos(width/2 - 300, height/2 + 50);
  A.setSize(150);
  B = new ClickableText();
  B.setText("B");
  B.setMode("CENTER");
  B.setPos(width/2, height/2 + 50);
  B.setSize(150);

  C = new ClickableText();
  C.setText("C");
  C.setMode("CENTER");
  C.setPos(width/2 + 300, height/2 + 50);
  C.setSize(150);

  File saveDir = new File(System.getProperty("user.home") + "\\TMTimeTable");
  if (!saveDir.exists()) {
    saveDir.mkdirs();
  }
  background(0);
  booster = new UiBooster();
  homep = loadImage("HomeL.png");
  settingsp = loadImage("SettingsL.png");
  calendar = loadImage("calL.png");
  weekV = loadImage("weekL.png");

  smooth();
  noStroke();
  font = createFont("ProductSans-Bold.ttf", 100); //Load the font
  surface.setTitle("TMTimeTable");
  surface.setResizable(true);
  wedDates = loadStrings("Wed1.txt");
  monthString = months[month()] + year();
  dayOfWeek = week[date];
  try {
    if (System.getProperty("sun.desktop").equals("windows")) {
      pref = loadStrings(System.getProperty("user.home")+"\\TMTimeTable\\pref.txt");
    } else {
      pref = loadStrings(System.getProperty("user.home")+"/TMTimeTable/pref.txt");
    }
    loadData();
  }
  catch (Exception e) {
    prepareFirstTime();
  }
  calculateClasses();
  try {
    checkForUpdates();
  }
  catch (Exception e) {
  }
  initWeekView();
  for (int i = 0; i < 6; i ++) {
    settings.add(new ClickableText());
    settings.get(i).setMode("CENTER");
    settings.get(i).setSize(50);
  }
  loadEvents();

  try {
    reg = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/timeTableReg.txt");
    String cForce = split(reg[0], '=')[1];
    if (cForce.equals("true")) {
      backupCohort = cohort;
      cohort = 'C';
      forceCohortC = true;
      booster.showInfoDialog("Your cohort has been set to C, as per the server requirements");
      initWeekView();
    }
  }
  catch (Exception e) {
  }
  println("Days Left " + actualDaysLeft);
}

void draw() {
  if (updateMode) {
    update();
  } else {
    colorShift(newColors[0], newColors[1], newColors[2]);
    colorShiftBG(newBG[0], newBG[1], newBG[2]);
    colorShiftText(newText[0], newText[1], newText[2]);
    colorShiftImg(colToBe);
    calculateClasses();
    tint(picCol, alpha);

    sizeDeteccLegacy();

    if (isSetUp) {
      if (screenNumber == 0) {
        if (alpha <= 255) {
          alpha+=17;
        }
        if (view == 0) {
          mainScreen();
        } else {
          weekView();
        }
      } else if (screenNumber == 1) {
        if (reset) {
          alpha-=17;
          if (alpha < 0) {
            reset();
          }
        }      
        guiSettings();
      } else if (screenNumber == 3) {
        checkOtherTime();
      } else {
        eventRemember();
      }
    } else {
      firstTimeSetup();
    }
  }
}
int c = 0;

void mainScreen() {
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height, 20, 20, 0, 0); //These two are the two rectangles on the top and bottom
  rect(0, 0, width, height*0.102986612, 0, 0, 20, 20);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  textFont(font, 50); //Setting Text Font
  text(titleText[lang], width/2, height*0.0494444444 + 25); //Top Text
  text(schedToday[lang], width/2, height/2-200);
  textFont(font, 45); //Setting Text Font
  if (lang == 0) {
    calDate = testWeek[lang][date] + " " + testMonth[lang][month()] + " " + day() + " " + year();
  } else if (lang == 1) {
    calDate = testWeek[lang][date] + " " + day() + " " + testMonth[lang][month()] + " " + year();
  }
  text(calDate + " (Day " + period + ")", width/2, height/2-130);

  drawTimes();

  imageMode(CENTER);
  image(settingsp, height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar, width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(weekV, width/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
}



void guiSettings() {
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height, 20, 20, 0, 0); //These two are the two rectangles on the top and bottom
  rect(0, 0, width, height*0.102986612, 0, 0, 20, 20);
  pushMatrix();
  fill(textColor[0], textColor[1], textColor[2], alpha);

  textFont(font, 50);
  textAlign(CENTER);

  text(settingsText[lang], width/2, height*0.0494444444 + 25); //Top Text

  textFont(font, 25);
  textAlign(LEFT);
  textFont(font, 50);
  textAlign(CENTER);

  settings.get(0).setText("Theme: " + Theme);
  settings.get(0).setPos(width/2, int(themPos[0]));
  settings.get(0).drawText();

  if (Theme.equals("Really Dark")) {
    settings.get(1).setText("Color Scheme: Really Dark");
  } else if (Theme.equals("Really Light")) {
    settings.get(1).setText("Color Scheme: Really Light (You menace to society)");
  } else {
    settings.get(1).setText("Color Scheme: " + cScheme);
  }
  settings.get(1).setPos(width/2, int(clrPos[0]));
  settings.get(1).drawText();

  settings.get(2).setText("Change Course One: " + p1Class);
  settings.get(2).setPos(width/2, int(courseOne[0]));
  settings.get(2).drawText();

  settings.get(3).setText("Change Course Two: " + p2Class);
  settings.get(3).setPos(width/2, int(courseTwo[0]));
  settings.get(3).drawText();
  if (forceCohortC) {
    fill(128, 128, 128, alpha);
  } else {
    fill(textColor[0], textColor[1], textColor[2], alpha);
  }
  settings.get(4).setText("Change Cohort: " + cohort);
  settings.get(4).setPos(width/2, int(changeCohort[0]));
  settings.get(4).drawText();

  fill(textColor[0], textColor[1], textColor[2], alpha);

  settings.get(5).setText("Animation Speed: " + str(transSpeed));
  settings.get(5).setPos(width/2, int(aniSpeed));
  settings.get(5).drawText();

  fill(128, 128, 128, alpha);

  textFont(font, 20);
  text(resetString[lang], width/2+35, height-110);
  popMatrix();

  image(homep, height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar, width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  if (verCounter >= 5) {
    fill(textColor[0], textColor[1], textColor[2], alpha);
    textAlign(LEFT);
    text("Version: " + ver, width-200, height - height*0.102986612);
  }
}

void checkOtherTime() {
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height, 20, 20, 0, 0); //These two are the two rectangles on the top and bottom
  rect(0, 0, width, height*0.102986612, 0, 0, 20, 20);
  image(homep, height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar, width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  textFont(font, 50); //Setting Text Font
  text(dateText[lang], width/2, height*0.0494444444 + 25); //Top Text
  text(enteredDate[lang], width/2, height/2-200);
  textFont(font, 45); //Setting Text Font
  text(otherCalDate + " (Day " + periodOther + ")", width/2, height/2-130);
  drawTimesOther();
}

void eventRemember() {
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
  fill(colors[0], colors[1], colors[2]);
  rect(0, height -  height*0.102986612, width, height, 20, 20, 0, 0); //These two are the two rectangles on the top and bottom
  rect(0, 0, width, height*0.102986612, 0, 0, 20, 20);
  image(homep, height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2]);
  textFont(font, 50); //Setting Text Font
  text("TMTimeTable OnTime\u2122", width/2, height*0.0494444444 + 25); //Top Text\
  textAlign(LEFT);
  int ID = event.get(Calendar.DAY_OF_YEAR) - cal.get(Calendar.DAY_OF_YEAR);
  
  text("P1: " + rects.get(ID).getP1(), 10, height*0.138888889 + 25); //Top Text\

  pushMatrix();
  translate(0, height*0.145833333 + 45);
  // translate(0, transScale);
  for (int i = 0; i < events.size(); i++) {
    if (events.get(i).day == event.get(Calendar.DAY_OF_MONTH) && events.get(i).month == event.get(Calendar.MONTH) + 1 && events.get(i).period.equals("P1")) {
      events.get(i).drawRect();
      translate(0, 100);
    }
  }
  translate(0, 25);
  textFont(font, 50); //Setting Text Font
  text("P2: " + rects.get(ID).getP2(), 10, 10 + 25); //Top Text\
  translate(0, 50);
  for (int i = 0; i < events.size(); i++) {
    if (events.get(i).day == event.get(Calendar.DAY_OF_MONTH) && events.get(i).month == event.get(Calendar.MONTH) + 1 && events.get(i).period.equals("P2")) {
      events.get(i).drawRect();
      translate(0, 100);
    }
  }
  popMatrix();
}

void drawTimes() {
  pushMatrix();
  translate(0, 50);
  if (noSchool()) {
    text("No School today. Reason: " + reason, width/2, height/2-105); //Drawing   times
  } else {
    if (currentCohort == 'A' && period == 1 && cohort == 'A') {
      if (!warningShown && alpha >= 255 && hour() <= 9) {
        booster.showConfirmDialog(
          "Don't forget to do your COVID Screening. Would you like to go there now?", 
          "COVID Screening", 
          new Runnable() {
          public void run() {
            isConfirmed = true;
          }
        }
        , 
          new Runnable() {
          public void run() {
            isConfirmed = false;
          }
        }
        );        
        warningShown = true;
        if (isConfirmed) {
          link("https://covid-19.ontario.ca/school-screening/");
        }
      }
      text(P1[lang] + p1Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'B' && period == 1 && cohort == 'A') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'A' && period == 2 && cohort == 'A') {
      if (!warningShown && alpha >= 255 && hour() <= 9) {
        booster.showConfirmDialog(
          "Don't forget to do your COVID Screening. Would you like to go there now?", 
          "COVID Screening", 
          new Runnable() {
          public void run() {
            isConfirmed = true;
          }
        }
        , 
          new Runnable() {
          public void run() {
            isConfirmed = false;
          }
        }
        );        
        warningShown = true;
        if (isConfirmed) {
          link("https://covid-19.ontario.ca/school-screening/");
        }
      }
      text(P1[lang] + p2Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'B' && period == 2 && cohort == 'A') {
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'A' && period == 1 && cohort == 'B') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'B' && period == 1 && cohort == 'B') {
      if (!warningShown && alpha >= 255 && hour() <= 9) {
        booster.showConfirmDialog(
          "Don't forget to do your COVID Screening. Would you like to go there now?", 
          "COVID Screening", 
          new Runnable() {
          public void run() {
            isConfirmed = true;
          }
        }
        , 
          new Runnable() {
          public void run() {
            isConfirmed = false;
          }
        }
        );        
        warningShown = true;
        if (isConfirmed) {
          link("https://covid-19.ontario.ca/school-screening/");
        }
      }
      text(P1[lang] + p1Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'A' && period == 2 && cohort == 'B') {
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'B' && period == 2 && cohort == 'B') {
      if (!warningShown && alpha >= 255  && hour() <= 9) {
        booster.showConfirmDialog(
          "Don't forget to do your COVID Screening. Would you like to go there now?", 
          "COVID Screening", 
          new Runnable() {
          public void run() {
            isConfirmed = true;
          }
        }
        , 
          new Runnable() {
          public void run() {
            isConfirmed = false;
          }
        }
        );        
        warningShown = true;
        if (isConfirmed) {
          link("https://covid-19.ontario.ca/school-screening/");
        }
      }
      text(P1[lang] + p2Class + inSchool[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else   if (currentCohort == 'A' && period == 1 && cohort == 'C') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'B' && period == 1 && cohort == 'C') {
      text(P1[lang] + p1Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p2Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'A' && period == 2 && cohort == 'C') { 
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    } else if (currentCohort == 'B' && period == 2 && cohort == 'C') {
      text(P1[lang] + p2Class + atHome[lang], width/2, height/2-105); //Drawing   times
      text(P2[lang] + p1Class + atHome[lang], width/2, height/2-52);
    }
  }
  popMatrix();
}

void firstTimeSetup() {
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height, 20, 20, 0, 0); //These two are the two rectangles on the top and bottom
  rect(0, 0, width, height*0.102986612, 0, 0, 20, 20);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  textFont(font, 50); //Setting Text Font

  text("TMTimeTable First Time Setup", width/2, height*0.0494444444 + 25); //Top Text
  if (state != 3) {
    if (alpha < 255) {
      alpha+=17;
    }
  }
  if (state == 0) {
    text("Welcome to TMTimeTable V4!", width/2, sizeDetecH(135, height));
    textFont(font, 43); //Setting Text Font
    text("\"Where Timetables Evolve\"", width/2, sizeDetecH(185, height));
    textFont(font, 39); //Setting Text Font
    text("To begin, please input your cohort:", width/2, sizeDetecH(235, height));

    textFont(font, 150); //Setting Text Font
    int yPos = int(sizeDetecH(410, height));
    A.setPos(int(sizeDetecW(325, width)), yPos);
    A.drawText();

    B.setPos(int(sizeDetecW(625, width)), yPos);
    B.drawText();

    C.drawText();
    C.setPos(int(sizeDetecW(925, width)), yPos);
  } else if (state == 1) {
    text("Welcome to TMTimeTable V4!", width/2, sizeDetecH(135, height));
    textFont(font, 43); //Setting Text Font
    text("\"Where Timetables Evolve\"", width/2, sizeDetecH(185, height));
    textFont(font, 39); //Setting Text Font
    text("Awesome! Now type in your period 1 class", width/2, sizeDetecH(235, height));
    text(p1Class, width/2, height/2-80); //Drawing   times
  } else if (state == 2) {
    text("Welcome to TMTimeTable V4!", width/2, sizeDetecH(135, height));
    textFont(font, 43); //Setting Text Font
    text("\"Where Timetables Evolve\"", width/2, sizeDetecH(185, height));
    textFont(font, 39); //Setting Text Font
    text("Great! Now type in your period 2 class", width/2, sizeDetecH(235, height));
    text(p2Class, width/2, height/2-80); //Drawing   times
  } else if (state == 3) {
    alpha-= 15;
    if (alpha <= 0) {
      isSetUp = true;
      initWeekView();
    }
  }
}
void calculateClasses() {
  if (dayOfWeek.equals("Monday")) {
    currentCohort = 'A';
    period = 1;
  } else if (dayOfWeek.equals("Tuesday")) {
    currentCohort = 'A';
    period = 2;
  } else if (dayOfWeek.equals("Thursday")) {
    currentCohort = 'B';
    period = 1;
  } else if (dayOfWeek.equals("Friday")) {
    currentCohort = 'B';
    period = 2;
  } else {
    checkWed();
  }
}
void checkWed() {
  for (int i = 0; i < wedDates.length; i++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[i];
    if (temp.equals(monthString)) {
      loadWed(i);
      break;
    }
  }
}

void loadWed(int i) {
  for (int j = i; j < wedDates.length; j++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[j];
    if (temp.equals(str(day()))) {
      if (wedDates[j+1].equals("A1")) {
        currentCohort = 'A';
        period = 1;
      } else if (wedDates[j+1].equals("B1")) {
        currentCohort = 'B';
        period = 1;
      } else if (wedDates[j+1].equals("A2")) {
        currentCohort = 'A';
        period = 2;
      } else if (wedDates[j+1].equals("B2")) {
        currentCohort = 'B';
        period = 2;
      }
      break;
    }
  }
}

void loadData() {
  if (pref[0].equals("timeTableGenV4Save")) {

    String[] temp = (split(pref[1], ':'));
    cohort = temp[1].charAt(0);
    p1Class = split(pref[2], ':')[1];
    p2Class = split(pref[3], ':')[1];
    Theme = split(pref[4], ':')[1];
    cScheme = split(pref[5], ':')[1];
    view = int(split(pref[7], ':')[1]);
    if (Theme.equals("Dark")) {
      backGroundColor[0] = 0;
      backGroundColor[1] = 0;
      backGroundColor[2] = 0;
      textColor[0] = 255;
      textColor[1] = 255;
      textColor[2] = 255;
      newBG[0] = 0;
      newBG[1] = 0;
      newBG[2] = 0;
      newText[0] = 255;
      newText[1] = 255;
      newText[2] = 255;
      colToBe = 255;
      picCol = 255;
    } else if (Theme.equals("Light")) {
      backGroundColor[0] = 255;
      backGroundColor[1] = 255;
      backGroundColor[2] = 255;
      textColor[0] = 0;
      textColor[1] = 0;
      textColor[2] = 0;
      newBG[0] = 255;
      newBG[1] = 255;
      newBG[2] = 255;
      newText[0] = 0;
      newText[1] = 0;
      newText[2] = 0;
      colToBe = 0;
      picCol = 0;
    } else if (Theme.equals("Really Dark")) {
      newText[0] = 255;
      newText[1] = 255;
      newText[2] = 255;
      textColor[0] = 255;
      textColor[1] = 255;
      textColor[2] = 255;
      backGroundColor[0] = 0;
      backGroundColor[1] = 0;
      backGroundColor[2] = 0;
      newBG[0] = 0;
      newBG[1] = 0;
      newBG[2] = 0;
      colors[0] = 0;
      colors[1] = 0;
      colors[2] = 0;
      newColors[0] = 0;
      newColors[1] = 0;
      newColors[2] = 0;
      colToBe = 255;
      picCol = 255;
    } else if (Theme.equals("Really Light")) {
      newText[0] = 0;
      newText[1] = 0;
      newText[2] = 0;
      newBG[0] = 255;
      newBG[1] = 255;
      newBG[2] = 255;
      newColors[0] = 255;
      newColors[1] = 255;
      newColors[2] = 255;
      colors[0] = 255;
      colors[1] = 255;
      colors[2] = 255;
      textColor[0] = 0;
      textColor[1] = 0;
      textColor[2] = 0;
      backGroundColor[0] = 255;
      backGroundColor[1] = 255;
      backGroundColor[2] = 255;
      colToBe = 0;
      picCol = 0;
    }
    if (!customTheme && !Theme.equals("Really Dark") && !Theme.equals("Really Light")) {
      if (cScheme.equals("Blue")) {
        colors[0] = 66;
        colors[1] = 135;
        colors[2] = 245;
        newColors[0] = 66;
        newColors[1] = 135;
        newColors[2] = 245;
      } else if (cScheme.equals("Red")) {
        colors[0] = 128;
        colors[1] = 0;
        colors[2] = 0;
        newColors[0] = 128;
        newColors[1] = 0;
        newColors[2] = 0;
      } else if (cScheme.equals("Green")) {
        colors[0] = 92;
        colors[1] = 153;
        colors[2] = 107;
        newColors[0] = 92;
        newColors[1] = 153;
        newColors[2] = 107;
      } else if (cScheme.equals("Orange")) {
        newColors[0] = 252;
        newColors[1] = 134;
        newColors[2] = 33;
        colors[0] = 252;
        colors[1] = 134;
        colors[2] = 33;
      } else if (cScheme.equals("Purple")) {
        newColors[0] = 117;
        newColors[1] = 121;
        newColors[2] = 231;
        colors[0] = 117;
        colors[1] = 121;
        colors[2] = 231;
      } else if (cScheme.equals("Turquoise")) {
        newColors[0] = 0;
        newColors[1] = 136;
        newColors[2] = 145;
        colors[0] = 0;
        colors[1] = 136;
        colors[2] = 145;
      }
    }
    try {
      transSpeed = float(split(pref[6], ':')[1]);
    }
    catch (Exception e) {
      booster.showInfoDialog("Your save file has been updated to be compliant with TMTimeTable V" + ver);
      writeData(forceCohortC);
    }
  } else {
    throw null;
  }
}

void writeData(boolean switchCohort) {
  if (switchCohort) {
    output = createWriter(System.getProperty("user.home")+"\\TMTimeTable\\pref.txt");
    output.println("timeTableGenV4Save");
    output.println("Cohort:" + backupCohort);
    output.println("P1:" + p1Class);
    output.println("P2:" + p2Class);
    output.println("Theme:" + Theme);
    output.println("Color Scheme:" + cScheme);
    output.println("Animation Speed:" + transSpeed);
    output.println("View:" + view);

    output.flush();
  } else {
    output = createWriter(System.getProperty("user.home")+"\\TMTimeTable\\pref.txt");
    output.println("timeTableGenV4Save");
    output.println("Cohort:" + cohort);
    output.println("P1:" + p1Class);
    output.println("P2:" + p2Class);
    output.println("Theme:" + Theme);
    output.println("Color Scheme:" + cScheme);
    output.println("Animation Speed:" + transSpeed);
    output.println("View:" + view);

    output.flush();
  }
}

boolean noSchool() {
  if (dayOfWeek == "Saturday" || dayOfWeek == "Sunday") {
    reason = "Weekend";
    return true;
  } else if (paDay()) {
    reason = "PA Day";
    return true;
  } else {
    return false;
  }
}
boolean paDay() {
  int[] months = {2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5};
  int[] days = {15, 2, 5, 12, 13, 14, 15, 16, 26, 27, 24};
  for (int i = 0; i < days.length; i++) { 
    if (day() == days[i] && month() == months[i]) {
      return true;
    }
  }
  return false;
}
