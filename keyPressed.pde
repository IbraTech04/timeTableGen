void keyPressed() {
  if (!isSetUp) {
    if (state == 0) {
      if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22  && keyCode!=86) {
        courses[0][0] +=key;
      } else  if (key == BACKSPACE) {
        courses[0][0] = courses[0][0].substring(0, max(0, courses[0][0].length() - 1));
      } else if (key == ENTER) {
        state++;
      }
    } else if (state == 1) {
      if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
        courses[0][1] +=key;
      } else  if (key == BACKSPACE) {
        courses[0][1] = courses[0][1].substring(0, max(0, courses[0][1].length() - 1));
      } else if (key == ENTER) {
        state++;
      }
    } else if (state == 2) {
      if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
        courses[1][0] +=key;
      } else  if (key == BACKSPACE) {
        courses[1][0] = courses[1][0].substring(0, max(0, courses[1][0].length() - 1));
      } else if (key == ENTER) {
        state++;
      }
    } else if (state == 3) {
      if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
        courses[1][1] +=key;
      } else  if (key == BACKSPACE) {
        courses[1][1] = courses[1][1].substring(0, max(0, courses[1][1].length() - 1));
      } else if (key == ENTER) {
        writeData();
        state++;
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
