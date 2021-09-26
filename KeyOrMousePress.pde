/* On Key Press */
void keyPressed() {
  
  if(keyCode==ALT) isAlt=true;
  if(keyCode==CONTROL) isCtrl=true;
  if(keyCode==SHIFT) isShift=true;
  
  /* Normal Mandelbrot Keybinds */
  if(barPosLeft == 0 && barPosRight == 0){
    isTextBox = -1;
    
    canDraw = true;
    switch(key){
      // movement
      case CODED:
        if(isAlt){ it *= 0.1; cenit *= 0.1; }
        if(isShift){
          if(bools.get("JuliaMode")){
            if(keyCode==UP) doubles.put("JuliaCenterY",doubles.get("JuliaCenterY")-cenit);
            if(keyCode==DOWN) doubles.put("JuliaCenterY",doubles.get("JuliaCenterY")+cenit);
            if(keyCode==LEFT) doubles.put("JuliaCenterX",doubles.get("JuliaCenterX")-cenit);
            if(keyCode==RIGHT) doubles.put("JuliaCenterX",doubles.get("JuliaCenterX")+cenit);
          }else{
            if(keyCode==UP) doubles.put("MandelCenterY",doubles.get("MandelCenterY")-cenit);
            if(keyCode==DOWN) doubles.put("MandelCenterY",doubles.get("MandelCenterY")+cenit);
            if(keyCode==LEFT) doubles.put("MandelCenterX",doubles.get("MandelCenterX")-cenit);
            if(keyCode==RIGHT) doubles.put("MandelCenterX",doubles.get("MandelCenterX")+cenit);
          }
        }else{
          if(isCtrl){
            if(keyCode==UP) ints.put("BulbSelect",ints.get("BulbSelect")+1);
            if(keyCode==DOWN && ints.get("BulbSelect")>=0) ints.put("BulbSelect",ints.get("BulbSelect")-1);
          }else{
            if(keyCode==UP) doubles.put("ZoomCenterY",doubles.get("ZoomCenterY")-it*doubles.get("ZoomDepth"));
            if(keyCode==DOWN) doubles.put("ZoomCenterY",doubles.get("ZoomCenterY")+it*doubles.get("ZoomDepth"));
            if(keyCode==LEFT) doubles.put("ZoomCenterX",doubles.get("ZoomCenterX")-it*doubles.get("ZoomDepth"));
            if(keyCode==RIGHT) doubles.put("ZoomCenterX",doubles.get("ZoomCenterX")+it*doubles.get("ZoomDepth"));
          }
        }
        if(isAlt){ it *= 10; cenit *= 10; }
        if(!(keyCode==UP||keyCode==DOWN||keyCode==LEFT||keyCode==RIGHT)) canDraw = false;
        break;
        
      case 'w': // overflow modification
        floats.put("overflow",floats.get("overflow")+2*sqrt(floats.get("overflow"))+1);
        break;
      case 's':
        floats.put("overflow",floats.get("overflow")+1-2*sqrt(floats.get("overflow")));
        break;
        
      case 'q': // gradient rate
        ints.put("colorGrad",ints.get("colorGrad")+1);
        break;
      case 'a':
        ints.put("colorGrad",ints.get("colorGrad")-1);
        break;
        
      case 'r': // resets
        doubles.put("ZoomCenterX",0d);
        doubles.put("ZoomCenterY",0d);
        doubles.put("ZoomDepth",2d);
        //floats.put("overflow",4f);
        doubles.put("PreviewZoomDepth",4d);
        break;
      case 'o':
        if(bools.get("JuliaMode")){
          doubles.put("JuliaCenterX",0d);
          doubles.put("JuliaCenterY",0d);
        }else{
          doubles.put("MandelCenterX",0d);
          doubles.put("MandelCenterY",0d);
        }
        doubles.put("PreviewZoomDepth",4d);
        break;
        
      case 'j': // Toggle J-mode
        bools.put("JuliaMode",!bools.get("JuliaMode"));
        break;
      
      case '=':
      case '+':
        doubles.put("PreviewZoomDepth",doubles.get("PreviewZoomDepth")/1.5);
        canDraw = false;
        break;
      case '_':
      case '-':
        doubles.put("PreviewZoomDepth",doubles.get("PreviewZoomDepth")*1.5);
        canDraw = false;
        break;
      
      case '\\':
        bools.put("showJuliaPreview",!bools.get("showJuliaPreview"));
        canDraw = false;
        break;
      
      case '[':
        doubles.put("ZoomDepth",doubles.get("ZoomDepth")/1.5);
        break;
      case ']':
        doubles.put("ZoomDepth",doubles.get("ZoomDepth")*1.5);
        break;
      
      case '\'':
        bools.put("inverseColoring",!bools.get("inverseColoring"));
        break;
      case '"':
        if(!bools.get("inverseColoring"))
          bools.put("smoothColoring", !bools.get("smoothColoring"));
        else
          bools.put("inverseColorNotInSet",!bools.get("inverseColorNotInSet"));
        break;
      case '|':
        bools.put("DEM",!bools.get("DEM"));
        break;
      case '$':
        SamplePixelPrompt = !SamplePixelPrompt;
        canDraw = false;
        break;
      
      default:
        canDraw = false; // pixel sizing
        if((int)key-48>0 && (int)key-48<10){ // keys 1-10
          ints.put("pixelSize",(int)key-48);
          canDraw = true;
        }
    }
  }
  
  
  /* Text Box Selection */
  else if(textBoxSelected.size() > 0){ 
    String name = (String)((textBoxSelected.keySet().toArray())[0]);
    /* Delete characters */
    if(key==BACKSPACE || key==DELETE){
      if(currentText.length()>0)
        currentText = currentText.substring(0, currentText.length() - 1);
      
    /* Enter characters */
    }else if(key==ENTER || key==RETURN){ // enter/return
      try{
        if(arrays.containsKey(name)){
          ArrayList<Float> temp = arrays.get(name);
          temp.set(TextBoxArrayPosition,float(currentText));
          arrays.put(name,temp);
        }else if(ints.containsKey(name)){
          ints.put(name,int(currentText));
        }else if(doubles.containsKey(name)){
          doubles.put(name,Double.parseDouble(currentText));
        }else if(floats.containsKey(name)){
          if(name.equals("overflow")) floats.put(name,pow(float(currentText),2));
          else floats.put(name,float(currentText));
        }else if(strings.containsKey(name)){
          strings.put(name,currentText);
        }
        canDraw = true;
      }catch(Exception e){}
      
      /* Unselect text box */
      textBoxSelected.clear();
      
    /* Other keys when length limit not reached */
    }else if(((arrays.containsKey(name) || ints.containsKey(name) || floats.containsKey(name)) && currentText.length()<5) || (doubles.containsKey(name) && currentText.length()<11)){
      if(key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '.' || key == '-' || key == 'E'){
        currentText+=key;
      }
    }else if(strings.containsKey(name) && currentText.length()<9){
      /* String boxes */
      /* No ',' because of comma-seperated file format */
      if(key != ',' && key!=CODED) currentText+=key;
      strings.put(name,currentText);
    }else println("Text box unknown.");
  }

  else{
    switch(key){
      case CODED:
        switch(keyCode){
          case UP:
            Scroll+=4;
            if(Scroll > 0) Scroll = 0;
            break;
          case DOWN:
            Scroll-=4;
            if(95 + Scroll + BarVLengthRight < height){
              if(95 + BarVLengthRight < height) Scroll = 0;
              else Scroll = height - BarVLengthRight - 95;
            }
            break;
        }
    }
  }
}

void keyReleased(){
  if(keyCode==ALT) isAlt=false;
  if(keyCode==CONTROL) isCtrl=false;
  if(keyCode==SHIFT) isShift=false;
}

void mouseClicked(){
  if(WhereAmI.equals("viewer")){
    if(barPosLeft == 0 && barPosRight == 0){ // makes clickbinds not work in command mode
      isTextBox = -1;
      double[] transmousepos = {(mouseX * doubles.get("ZoomDepth") * 0.002) - width*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterX"), 
                                (mouseY * doubles.get("ZoomDepth") * 0.002) - height*0.001*doubles.get("ZoomDepth") + doubles.get("ZoomCenterY")};//transl(mouseX,mouseY); // sets up for next zoom
      if(keyPressed && key==CODED && keyCode == SHIFT){
        if(bools.get("JuliaMode")){
          doubles.put("MandelCenterX",transmousepos[0]);
          doubles.put("MandelCenterY",transmousepos[1]);
        }else{
          doubles.put("JuliaCenterX",transmousepos[0]);
          doubles.put("JuliaCenterY",transmousepos[1]);
        }
      }else if (keyPressed && key==CODED && keyCode == ALT){
        bools.put("SamplePixel",!bools.get("SamplePixel"));
        if(bools.get("SamplePixel")) {
          doubles.put("SamplePixelX",transmousepos[0]);
          doubles.put("SamplePixelY",transmousepos[1]);
        }
      }else{
        doubles.put("ZoomCenterX",transmousepos[0]);
        doubles.put("ZoomCenterY",transmousepos[1]);
        if(mouseButton==LEFT){
          doubles.put("ZoomDepth",doubles.get("ZoomDepth")/2);
        }
        if(mouseButton==RIGHT){
          doubles.put("ZoomDepth",doubles.get("ZoomDepth")*2);
        }
        canDraw = true;
      }
    }
  }else if(WhereAmI.equals("menu")){
    if (WhereAmI == "menu") {
      if (mouseInRange(0.5*width,0.66*height,250,75)) {
        WhereAmI = "viewer";
      }
      else if (mouseInRange(0.5*width,0.77*height,250,75)) {
        WhereAmI = "help";
      }
    }
  }
}
