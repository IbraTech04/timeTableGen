float[] them = {0, 0, 0, 0}, clr = {0, 0, 0, 0}, themPos = {0, 0}, clrPos = {0, 0}, courseOne = {0, 0}, courseTwo={0, 0}, changeCohort = {0, 0};
float[] changeCourseOne = {0, 0, 0, 0};
float aniSpeed;
void sizeDeteccLegacy() {
  float wid = width;
  float hei = height;
  //Theme Toggle Button Coords
  them[0] = wid*0.37109375;
  them[1] = wid*0.62734375;
  them[2] = hei*0.231944444;
  them[3] = hei*0.291666667;
  //Color Button Toggle Coords
  clr[0] = wid*0.30703125;
  clr[1] = wid*0.68203125;
  clr[2] = hei*0.305555556;
  clr[3] = hei*0.369444444;
  //Theme Text Position
  themPos[0] = hei*0.291666667;
  //Color Text Position
  clrPos[0] = hei*0.361111111;
  //Verbose Text Position  
  courseOne[0] = hei*0.430555556;
  //UDP Socket text position
  courseTwo[0] = hei*0.5;
  //UDP IP Text Position
  changeCohort[0] = hei*0.569444444;
  //Verbose Button Coords
  changeCourseOne[0] = wid*0.27265625;
  changeCourseOne[1] = wid*0.71796875;
  changeCourseOne[2] = hei*0.376388889;
  changeCourseOne[3] = hei*0.427777778;
  aniSpeed = hei*0.64;
}
