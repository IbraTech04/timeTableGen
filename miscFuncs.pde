void prepareFirstTime() {
  isSetUp = false;
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
  colors[0] = 66;
  colors[1] = 135;
  colors[2] = 245;
  newColors[0] = 66;
  newColors[1] = 135;
  newColors[2] = 245;
  Theme = "Dark";
  cScheme = "Blue";
  output = createWriter(System.getProperty("user.home")+"\\TMTimeTable\\pref.txt");
}

void reset() {
  reset = false;
  isSetUp = false;
  output = createWriter(System.getProperty("user.home")+"\\TMTimeTable\\pref.txt");
  colors[0] = 66;
  colors[1] = 135;
  colors[2] = 245;
  textColor[0] = 255;
  textColor[1] = 255;
  textColor[2] = 255;
  backGroundColor[0] = 0;
  backGroundColor[1] = 0;
  backGroundColor[2] = 0;
  state = 0;
  p1Class = "";
  p2Class = "";
  alpha = 0;
  screenNumber = 0;
  picCol = 0;
  transSpeed = 2.5;
  setup();
}

void drawRect() {
  rect(10, 10, width-20, 90, 15, 15, 15, 15);
}
