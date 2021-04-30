PFont font;
PImage homep, settingsp, calendar, weekV;
PrintWriter output;

float[] colors = {60, 135, 245, 128, 0, 0, 92, 153, 107}, textColor = {255, 255, 255}, backGroundColor = {0, 0, 0};
int date = cal.get(Calendar.DAY_OF_WEEK), period, state = 0, picCol = 255, colToBe = 255;
String[] nversionFromServer;
int shiftRegister = 0, screenNumber = 0;

int lang = 0, view = 0, guiTrans = -70;

String[] englishWeek = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}, englishMonths = {"", "January", "February", "March", "April", "May", "June", "July", "Auguest", "September", "October", "November", "December"};
String[] arabicWeek = {"", " الأحد", "الاثنين", " الثلاثاء", "الأربعاء", " الخميس", " الجمعة", " السبت"}, arabicMonths = {"", "يناير", "فبراير", "مارس", "أبريل ", "مايو", "يونيو", "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"};

String[][] testWeek = {englishWeek,arabicWeek};
String[][] testMonth = {englishMonths, arabicMonths};
String[] week = englishWeek;
String[] months = englishMonths;
String dayOfWeek, p1Class = "", p2Class = "", monthString, Theme = "", cScheme = "";

String calDate, reason = "Weekend";
String[] wedDates, pref;
String otherDay;
float transSpeed = 2.5;
char cohort, currentCohort, backupCohort;

boolean isSetUp = true, customTheme, checkOtherDay = false, reset = false, warningShown = false, showVer = false, updateMode = false, updateMode2 = false;
float alpha = 0;

String ver = "4";
int verCounter = 0;

int guiState = 0, updateState = 0;


String[] titleText = {"TMTimeTable Home", "برنامج الجدول الزمني"};
String[] settingsText = {"TMTimeTable Settings", "إعدادات"};
String[] dateText = {"TMTimeTable Custom Date Lookup", "بحث التاريخ"};
String[] enteredDate = {"Your Schedule for entered date:", "الجدول الزمني الخاص بك لـ:"};

String[] schedToday = {"Your Schedule for today:", "جدول اليوم:"};

String[] atHome = {" At Home", " في البيت"};
String[] inSchool = {" In School", " في المدرسة"};

String[] P1 = {"P1: ", "الحصة ١ "};
String[] P2 = {"P2: ", "الحصة ٢ "};

String[] resetString = {"Press F to perform a factory reset", "اضغط F لإعادة التعيين"};

int daysLeft = 100;

float transScale;

String[] reg;

boolean forceCohortC = false;
