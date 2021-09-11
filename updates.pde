void checkForUpdates() {
  nversionFromServer = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/Vers.txt");
  if (isGreater(nversionFromServer[0])) {
    if (nversionFromServer[1].equals("URGENT")) {
      booster.showConfirmDialog(
        "An urgent update (V" + nversionFromServer[0] + ") is availible. You need to update before using TMTimeTable",
        "Urgent Update",
        new Runnable() {
        public void run() {
          isConfirmed = true;
        }
      }
      ,
        new Runnable() {
        public void run() {
          isConfirmed = true;
        }
      }
      );
      if (isConfirmed) {
        updateMode = true;
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
        updateMode = true;
      }
    }
  }
}

float integer;
int frameNum = 0;
void update() {
  frameRate(30);
  colorMode(HSB, 360, 100, 100);
  integer += 0.5;
  if (integer == 255){
     integer = 0;
  }
  imageMode(CENTER);
  if (updateState == 0) {
    background(color(integer, 255, 255));
    image(loadingAnimation[frameNum], width/2, height/2 - 175, 300, 300);
    frameNum ++;
    if (frameNum == 74) {
      frameNum = 0;
    }
    textAlign(CENTER);
    textSize(29);
    text("Updating... \nPlease do not close this window until this process is complete \nPreparing to Update", width/2, height/2 - 10);
    UpdateDownloader up = new UpdateDownloader();
    up.start();
    updateState++;
  } else if (updateState == 1) {
    background(color(integer, 255, 255));
    image(loadingAnimation[frameNum], width/2, height/2 - 175, 300, 300);
    frameNum ++;
    if (frameNum == 74) {
      frameNum = 0;
    }
    text("Updating... \nPlease do not close this window until this process is complete\n Downloading update files", width/2, height/2 - 10);
  }
  if (integer > 255) {
    integer = 0;
  }
}

boolean isGreater(String version) {
  String ver1 = ver + ".0.0";
  String[] ww = split(version, '.');
  String[] w = split(ver1, '.');
  try {

    if (int(ww[0]) > int(w[0])) {
      return true;
    } else if (int(ww[1]) > int(w[1]) && int(ww[0]) == int(w[0])) {
      return true;
    } else if (int(ww[2]) > int(w[2]) && int(ww[1]) == int(w[1]) && int(ww[0]) == int(w[0])) {
      return true;
    }
  }
  catch (Exception e) {
    return true;
  }
  return false;
}
