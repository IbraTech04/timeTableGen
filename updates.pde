void checkForUpdates() {
  nversionFromServer = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/Vers.txt");
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
        //link("https://github.com/IbraTech04/timeTableGen/releases");
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
        // link("https://github.com/IbraTech04/timeTableGen/releases");
        updateMode = true;
      }
    }
  }
}

void update() {
  if (updateState == 0) {
    background(0);
    textAlign(CENTER);
    textSize(29);
    text("Updating... \nPlease do not close this window until this process is complete", width/2, height/2+30);
    text("Stage One: Downloading Update Files", width/2, height/2);
    updateState++;
  } else if (updateState == 1) {
    byte[] updateFile = loadBytes("https://github.com/IbraTech04/updateServer/raw/master/timeTableGenV2.exe");
    updateState++;
  } else if (updateState == 2) {
    background(0);
    text("Updating... \nPlease do not close this window until this process is complete.\nTMTimeTable will resetart soon. Follow the prompts to update TMTimeTable.", width/2, height/2+60);
    text("Stage Two: Applying Update", width/2, height/2);
    updateState++;
  } else if (updateState == 3) {
    File file;
    Desktop desktop = Desktop.getDesktop();  
    try {
      File theDir = new File(System.getProperty("user.home") + "\\TMTimeTable");
      if (!theDir.exists()) {
        theDir.mkdirs();
      }
      if (System.getProperty("sun.desktop").equals("windows")) {
        if (System.getProperty("os.arch").equals("amd64")) {
          byte[] test = loadBytes("https://github.com/IbraTech04/updateServer/raw/master/timetable64.exe");
          saveBytes(System.getProperty("user.home")+"\\TMTimeTable\\TMTimeTableV" + nversionFromServer[0] + ".exe", test);
        } else {
          byte[] test = loadBytes("https://github.com/IbraTech04/updateServer/raw/master/timetable32.exe");
          saveBytes(System.getProperty("user.home")+"\\TMTimeTable\\TMTimeTableV" + nversionFromServer[0] + ".exe", test);
        }
      } else {
        link("https://github.com/IbraTech04/timeTableGen/releases");
      }

      if (!Desktop.isDesktopSupported()) {
        System.out.println("Desktop is not supported");
        return;
      }
      file = new File(System.getProperty("user.home")+"\\TMTimeTable\\TMTimeTableV" + nversionFromServer[0] + ".exe");
      if (file.exists()) { 
        desktop.open(file);
        exit();
      }
    }
    catch(Exception e)  
    {  
      e.printStackTrace();
    }
    updateState++;
  }
}
