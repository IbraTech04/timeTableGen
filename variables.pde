PFont font;
PImage homep, settingsp, calendar;
PrintWriter output;

float[] colors = {60, 135, 245, 128, 0, 0, 92, 153, 107}, textColor = {255, 255, 255}, backGroundColor = {0, 0, 0};
int date = cal.get(Calendar.DAY_OF_WEEK), period, state = 0, picCol = 255, colToBe = 255;;
int shiftRegister = 0, screenNumber = 0;

String[] week = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}, months = {"", "January", "February", "March", "April", "May", "June", "July", "Auguest", "September", "October", "November", "December"};
String dayOfWeek = week[date], p1Class = "", p2Class = "", monthString = months[month()] + year(), Theme = "", cScheme = "";;
String calDate = week[date] + " " + months[month()] + " " + day() + " " + year(), reason = "Weekend";
String[] wedDates, pref;
String otherDay;
float transSpeed = 2.5;
char cohort, currentCohort;

boolean isSetUp, customTheme, checkOtherDay = false, reset = false, warningShown = false, showVer = false;
float alpha = 0;

String ver = "3.2.1";
int verCounter = 0;

int frame1, frame2;

int guiState = 0;
