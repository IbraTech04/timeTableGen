void checkForUpdates() {
  String[] nversionFromServer = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/Vers.txt");
  println(nversionFromServer[1]);
  if (!nversionFromServer[0].equals(ver)) {
    if (nversionFromServer[1].equals("URGENT")) {
      booster.showConfirmDialog(
        "An urgent update (V" + nversionFromServer[0] + ") is availible. Would you like to update now?", 
        "Urgent Update", 
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
      if (isConfirmed) {
        link("https://github.com/IbraTech04/timeTableGen/releases");
      }
    } else {
      booster.showConfirmDialog(
        "A new update (V" + nversionFromServer[0] + ") Would you like to update now?", 
        "Update!", 
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
      if (isConfirmed) {
        link("https://github.com/IbraTech04/timeTableGen/releases");
      }
    }
  }
}
