PImage CreateMandelbrotImage(int w, int h, double centerX, double centerY, double zoom, boolean MandelMode, int iterations, int pxSize ,double... centerShift){
  PImage image = createImage(w, h, RGB);
  image.loadPixels();
  color currc;
  int px = pxSize; // for speed
  
  double[] FracCenter;
  switch(centerShift.length){
    case 0:
      FracCenter = new double[]{MandelMode ? doubles.get("JuliaCenterX") : doubles.get("MandelCenterX"),
                                MandelMode ? doubles.get("JuliaCenterY") : doubles.get("MandelCenterY")};
      break;
    case 2:
      FracCenter = new double[]{centerShift[0], centerShift[1]};
      break;
    default:
      FracCenter = new double[]{0,0};
      break;
  }
  
  /* Initialize array variables to not call them many times a pixel*/
  powerll = new float[arrays.get("PowerList").size()];
  int i33 = 0; 
  for (Float f : arrays.get("PowerList")) {
    powerll[i33++] = (f != null ? f : Float.NaN); // Or whatever default you want.
  }
  multll = new float[arrays.get("MultiplierList").size()];
  i33 = 0; 
  for (Float f : arrays.get("MultiplierList")) {
    multll[i33++] = (f != null ? f : Float.NaN);
  }
  
  /* Mandelbrot Set */
  /* tests point (x,y) */
  for(float x=0;x<(int)(w/px);x++){
    for(float y=0; y<(int)(h/px);y++){
      /* In Set? */
      double[] translpos = {(x*px*0.002 - w*0.001)*zoom + centerX,
                            (y*px*0.002 -h*0.001)*zoom + centerY};  
      if(isInFractal(MandelMode,
                         translpos[0],translpos[1],
                         FracCenter[0],FracCenter[1],
                         iterations)){
        // Makes px*px pixel
        if(recurseLength == ints.get("BulbSelect")){
          currc = color(255);
        }else if(recurseLength > 1 && ints.get("BulbSelect") > 0 && ints.get("BulbSelect")%recurseLength == 0){
          currc = color(256-256/recurseLength);
        }else{
          currc = bools.get("inverseColoring") ? genColor(250*sqrt((float)minabs),ints.get("colorMode")) : color(0);
        }
      }else{
        currc = bools.get("inverseColoring") ? (bools.get("inverseColorNotInSet") ? genColor(250*sqrt((float)minabs),ints.get("colorMode")) : color(0)) : genColor(qucol,ints.get("colorMode"));
      }
      for(int i=0;i<px;i++) for(int j=0;j<px;j++) image.pixels[(int)((px*y+j)*w+px*x+i)] = currc;
    }
    if(w==width && h==height){
      String out = "Rendering... [";
      for(int i=0; i<(int)(30*x/(width/px)); ++i) out += "#";
      for(int i=(int)(30*x/(width/px)); i<30;++i) out += " ";
      out += "] : ";
      out += (int)(100*x/(width/px));
      out += "% \r";
      print(out);
    }
    
    //if(keyPressed && (key==BACKSPACE || key==DELETE)) break;
  }
  if(w==width && h==height){
    String out = "Rendered.    [";
    for(int i=0; i<30; ++i) out += " ";
    out += "] : --%\r";
    print(out);
  }
  image.updatePixels();
  return(image);
}
