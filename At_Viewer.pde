/* VIEWER */
void DRAW_MANDELBROT(){
  strokeWeight(1);
  /* Mandelbrot */ 
  if(canDraw && !invalidateDraw && barPosLeft == 0 && barPosRight == 0){
    background(0,150,0);
    currentSet = CreateMandelbrotImage(width, height, doubles.get("ZoomCenterX"), doubles.get("ZoomCenterY"), doubles.get("ZoomDepth"), bools.get("JuliaMode"), ints.get("iterations"), ints.get("pixelSize"));
    canDraw = false; // stops loop
    invalidateDraw = false;
  }
  noStroke();
  image(currentSet,width/2,height/2); 
  
  /* Sample Pixel */
  if(bools.get("SamplePixel")){
    //int size = 50;
    //double[][] SamplePixels = new double[size][2];
    double[] transmousepos = {(mouseX * doubles.get("ZoomDepth") * 0.002) - width*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterX"), 
                              (mouseY * doubles.get("ZoomDepth") * 0.002) - height*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterY")};
    if(!isAlt){
      doubles.put("SamplePixelX",transmousepos[0]);
      doubles.put("SamplePixelY",transmousepos[1]);
    }
    double[] sppxl = MANDEL(floats.get("inputTranslation"), new double[]{doubles.get("SamplePixelX"), doubles.get("SamplePixelY")},0,0);
    
    // Mandelbrot things. If alt held, recurse instead of going w/ curr mouse ptr pos
    
    if(isAlt) SamplePixels[0]=SamplePixels[size-1];
    else{
      if (bools.get("JuliaMode")) SamplePixels[0] = transmousepos;
      else SamplePixels[0] = new double[]{doubles.get("MandelCenterX"),doubles.get("MandelCenterY")};
    }
    //recurse
    
    float[] powerll = new float[arrays.get("PowerList").size()];
    int i0 = 0; for (Float f : arrays.get("PowerList")) {
      powerll[i0++] = (f != null ? f : Float.NaN); // Or whatever default you want.
    }
    float[] multll = new float[arrays.get("MultiplierList").size()];
    i0 = 0; for (Float f : arrays.get("MultiplierList")) {
      multll[i0++] = (f != null ? f : Float.NaN);
    }
  
    for(int i=1; i<size; ++i){
      SamplePixels[i] = iterate(bools.get("JuliaMode"), sppxl[0], sppxl[1], doubles.get("JuliaCenterX"), doubles.get("JuliaCenterY"), powerll, multll, SamplePixels[i-1], i-1);
    }
    
    //render
    for(int i=1; i<size; ++i){
      double[] transposI = new double[]{500*(SamplePixels[i][0]-doubles.get("ZoomCenterX"))/doubles.get("ZoomDepth") + 0.5*width,
                                        500*(SamplePixels[i][1]-doubles.get("ZoomCenterY"))/doubles.get("ZoomDepth") + 0.5*height,};
      double[] transposI1 = new double[]{500*(SamplePixels[i-1][0]-doubles.get("ZoomCenterX"))/doubles.get("ZoomDepth") + 0.5*width,
                                         500*(SamplePixels[i-1][1]-doubles.get("ZoomCenterY"))/doubles.get("ZoomDepth") + 0.5*height,}; 
      stroke(255,0,0);
      strokeWeight(2);
      line((float)transposI[0],(float)transposI[1],(float)transposI1[0],(float)transposI1[1]);
      noStroke();
    }
  }
   
  /* Previews */ 
  if(bools.get("showJuliaPreview") && barPosLeft==0 && barPosRight == 0){
    double[] transmousepos = {(mouseX * doubles.get("ZoomDepth") * 0.002) - width*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterX"),
                              (mouseY * doubles.get("ZoomDepth") * 0.002) -height*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterY")};//transl(mouseX,mouseY);
    fill(255);
    textFont(mono[1]);
    
    /* Mandel + Julia Preview */
    if(canDraw && !invalidateDraw && barPosLeft == 0 && barPosRight == 0)
    juliaPreview = new PImage(400,400);
    juliaPreview = CreateMandelbrotImage(400, 400, 0, 0, doubles.get("PreviewZoomDepth"), !bools.get("JuliaMode"), 75, 1, transmousepos[0], transmousepos[1]);
    
    stroke(255);
    strokeWeight(4);
    rect(width-200,height-200,400,400);
    image(juliaPreview,width-200,height-200);
    strokeWeight(1);
    /* Locator cross */
    float[] temp;
    if(!bools.get("JuliaMode")) temp = new float[]{(float)(width-200+doubles.get("MandelCenterX")*500/doubles.get("PreviewZoomDepth")),(float)(height-200+doubles.get("MandelCenterY")*500/doubles.get("PreviewZoomDepth"))};
    else temp = new float[]{(float)(width-200+doubles.get("JuliaCenterX")*500/doubles.get("PreviewZoomDepth")),(float)(height-200+doubles.get("JuliaCenterY")*500/doubles.get("PreviewZoomDepth"))};
    line(temp[0],temp[1],temp[0]+5,temp[1]);
    line(temp[0],temp[1],temp[0]-5,temp[1]);
    line(temp[0],temp[1],temp[0],temp[1]+5);
    line(temp[0],temp[1],temp[0],temp[1]-5);
    noStroke();
  }
  /* Mandel Preview */
  colorMode(RGB);

  /*update file reading*/
  if(FILEUPDATE){
    fileNames = getSetNamesFromFile();
    
    /* Reset displacement */
    savedFractalDisp = new int[fileNames.length];
    for(int i=0; i<fileNames.length; i++){
      savedFractalDisp[i]=0;
    }
    FILEUPDATE=false;
  }
  
  /*Open right-side bar*/
  if (mouseX > width-200) {
    if(barPosRight<200){
      barPosRight+=25;
    }
  }else{
    if(barPosRight>0){
      barPosRight-=25;
    }
  }
  
  /*Open left-side bar*/
  if (mouseX < 200) {
    if(barPosLeft<200){
      barPosLeft+=25;
    }
  }else{
    if(barPosLeft>0){
      barPosLeft-=25;
    }
    if(barPosLeft==25){
      filefeedback="~";
    }
  }
  
  /* Draw Bars if open */
  if(barPosRight>0){
    drawBarParams();
  } 
  if(barPosLeft>0){
    drawBarSaveLoad();
  }
  
  /* Darken Mandelbrot Render */
  fill(0,0,0,128*barPosRight/200+128*barPosLeft/200);
  rect(width/2-barPosRight/2+barPosLeft/2,height/2,width-barPosRight-barPosLeft,height);
  
  // Debug mouse pos
  if(barPosLeft == 0 && barPosRight == 0 && SamplePixelPrompt){
    textAlign(LEFT);
    color cspx = currentSet.pixels[0];
    if(pow(red(cspx),2)+pow(green(cspx),2)+pow(blue(cspx),2) <= 50000) fill(255);
    else fill(0);
    
    noStroke();
    double[] tmp = {(round(mouseX /*/ ints.get("pixelSize")*/)/**ints.get("pixelSize")*/ * doubles.get("ZoomDepth") * 0.002) - width*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterX"), 
                    (round(mouseY /*/ ints.get("pixelSize")*/)/**ints.get("pixelSize")*/ * doubles.get("ZoomDepth") * 0.002) - height*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterY")};//transl(mouseX,mouseY); // sets up for next zoom
    textFont(mono[2]);
    textSize(20);
    stroke(0);
     strokeWeight(1);
    text("$: SelectPixel",10, 30);
    textSize(15);
    String[] tmps = {Double.toString(tmp[0]), Double.toString(tmp[1])};
    int[] Eix = {255,255};
    
    for(int i=0; i<2; ++i){
      if(tmps[i].length() > 6){
        for(int j=0; j<tmps[i].length(); ++j){
          if(tmps[i].charAt(j)=='E') Eix[i] = j;
        }
        if(tmps[i].charAt(0)!='-'){
          tmps[i] = " " + tmps[i];
          Eix[i]++;
        }
        Eix[i] = min(Eix[i],tmps[i].length());
      }
    }
    textSize(10);
    if (tmps[0].length() > 6) text(tmps[0].substring(6,Eix[0]),65,50);
    if (tmps[1].length() > 6) text(tmps[1].substring(6,Eix[1]),65,70);
    textSize(15);
    if (tmps[0].length() > 6) text(tmps[0].substring(Eix[0]), 65 + 6*(Eix[0]-6), 50);
    if (tmps[1].length() > 6) text(tmps[1].substring(Eix[1]), 65 + 6*(Eix[1]-6), 70);
    textSize(15);
    text(tmps[0].substring(0,min(6,tmps[0].length())),10,50);
    text(tmps[1].substring(0,min(6,tmps[1].length())),10,70);
    
    boolean isInSet;
    double[] tmp2 = MANDEL(floats.get("inputTranslation"), new double[]{tmp[0], tmp[1]},0,0);
    isInSet = isInFractal(bools.get("JuliaMode"),
                          tmp2[0],tmp2[1],
                          bools.get("JuliaMode") ? doubles.get("JuliaCenterX") : doubles.get("MandelCenterX"),
                          bools.get("JuliaMode") ? doubles.get("JuliaCenterY") : doubles.get("MandelCenterY"),
                          ints.get("iterations"));
    rectMode(CORNER);
    if(isInSet){
      text("Bounded",10,100);
      text("∞?",70,120);
      fill(0);
      rect(10,105,50,20,5);
    }else{
      text("Escaped",10,100);
      text((int)qucol,70,120);
      fill(genColor(qucol,ints.get("colorMode")));
      rect(10,105,50,20,5);
    }
    if(pow(red(cspx),2)+pow(green(cspx),2)+pow(blue(cspx),2) <= 50000) fill(255);
    else fill(0);
    text("Bulb Value: " + Integer.toString(0+ints.get("BulbSelect")),10,155);
    rectMode(CENTER);
    noStroke();

    if (fcPsec == second()){
      fctr++;
    }else{
      fps = fctr;
      fctr = 0;
    }
    text(str(fps) + " fps", 10, 185);
    fcPsec = second();
  } 
}
