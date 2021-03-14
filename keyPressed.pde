void keyPressed() {
  if (!isSetUp) {
    if (state == 0) {
      if (str(key).toUpperCase().equals("A") || str(key).toUpperCase().equals("B") || str(key).toUpperCase().equals("C")) {
        String temp = str(key).toUpperCase();
        cohort = temp.charAt(0);
        state++;
      }
    } else if (state == 1) {
      if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
        p1Class +=key;
      } else  if (key == BACKSPACE) {
        p1Class = p1Class.substring(0, max(0, p1Class.length() - 1));
      } else if (key == ENTER) {
        state++;
      }
    } else if (state == 2) {
      if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
        p2Class +=key;
      } else  if (key == BACKSPACE) {
        p2Class = p2Class.substring(0, max(0, p2Class.length() - 1));
      } else if (key == ENTER) {
        writeData();
        state = 3;
      }
    }
  } else {
    if (screenNumber == 1) {
      if (key == 'f' || key == 'F') {
        reset = true;
      }
    } else {
      if (key == 'c') {
        otherDay = booster.showTextInputDialog("Enter the day you wish to check, in the mm/dd format. Ex: 02/15");
        checkOtherDay = true;
      }
    }
  }
}
