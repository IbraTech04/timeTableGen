float[] them = {0, 0, 0, 0}, clr = {0, 0, 0, 0}, themPos = {0, 0}, clrPos = {0, 0}, courseOne = {0, 0}, courseTwo={0, 0}, changeCohort = {0, 0};
float[] changeCourseOne = {0, 0, 0, 0};
float aniSpeed;
void sizeDeteccLegacy() {
  float wid = width;
  float hei = height;
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
  aniSpeed = hei*0.64;
}
