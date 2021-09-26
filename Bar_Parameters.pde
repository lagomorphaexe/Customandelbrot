int Displacement;
void drawBarParams(){
  // Bar Itself + Header Text
  fill(200);
  noStroke();
  rect(width+100-barPosRight,height/2,200,height); // bar rect.
  fill(0);
  textAlign(CENTER);
  strokeWeight(1);
  textFont(mono[1]);
  Displacement = 95 + Scroll;
  
  /* Julia mode / Mandelbrot mode */
  drawSelectionBox(width-barPosRight+60,Displacement,80,73,65,"JuliaMode",previews);
  Displacement-=20;
  drawSelectionBox(width-barPosRight+40,Displacement,120,31,31,"colorMode",gradientSelection);
  
  drawTextBox("Pixel Size",width+20-barPosRight,Displacement,"pixelSize","int");
  drawSlider(width+100-barPosRight,Displacement,1,10,"pixelSize","int");
  
  drawTextBox("Iterations",width+20-barPosRight,Displacement,"iterations","int");
  drawSlider(width+100-barPosRight,Displacement,10,4000,"iterations","int");
  
  drawTextBox("Color Rate",width+20-barPosRight,Displacement,"colorGrad","int");
  drawSlider(width+100-barPosRight,Displacement,1,500,"colorGrad","int");
  
  drawTextBox("Color Start",width+20-barPosRight,Displacement,"colorStart","float");
  drawSlider(width+100-barPosRight,Displacement,0,2,"colorStart","float");
  
  drawTextBox("Zoom Depth",width+20-barPosRight,Displacement,"ZoomDepth","double");
  drawSlider(width+100-barPosRight,Displacement,Math.pow(10,-15),10D,"ZoomDepth","double");
  
  drawListBoxes("Scale List",width+20-barPosRight,Displacement,"MultiplierList");
  
  drawListBoxes("Power List",width+20-barPosRight,Displacement,"PowerList");
  
  textAlign(LEFT);
  String name;
  if(bools.get("JuliaMode")){ 
    text("Julia Location",width+20-barPosRight,Displacement);
    name = "Julia";
  }else{
    text("Mandelbrot Location",width+20-barPosRight,Displacement);
    name = "Mandel";
  }
  Displacement += 25;
  drawTextBox("X:",width+20-barPosRight,Displacement,name+"CenterX","double");
  drawTextBox("Y:",width+20-barPosRight,Displacement,name+"CenterY","double");
  
  drawCheckBox("List Wrap",width+20-barPosRight,Displacement,"IsPowerRepeat");
  
  drawCheckBox("Mandelbar",width+20-barPosRight,Displacement,"MandelbarMode");
  
  drawCheckBox("Alt Preview",width+20-barPosRight,Displacement,"showJuliaPreview");
  
  drawCheckBox("Color Invert",width+20-barPosRight,Displacement,"inverseColoring");
  
  drawTextBox("Overflow",width+20-barPosRight,Displacement,"overflow","float");
  drawSlider(width+100-barPosRight,Displacement,1,10,"overflow","float");
  
  textAlign(LEFT);
  text("Render Center",width+20-barPosRight,Displacement);
  Displacement += 25;
  drawTextBox("X:",width+20-barPosRight,Displacement,"ZoomCenterX","double");
  drawTextBox("Y:",width+20-barPosRight,Displacement,"ZoomCenterY","double");
  
  drawTextBox("Input Power",width+20-barPosRight,Displacement,"inputTranslation","float");

  BarVLengthRight = Displacement - 95 - Scroll;
  
  fill(200);
  noStroke();
  rect(width+100-barPosRight, 15, 195, 90);
  fill(0);
  strokeWeight(1);
  textFont(mono[0]); // small font
  text("Parameters",width+100-barPosRight,50);
  stroke(0);
  if(Scroll < 0) line(width+100-barPosRight-85,60, width+100-barPosRight+85, 60);
  
  fill(150);
  int p88 = width + 100 - barPosRight + 88;
  boolean showUpArrow = Scroll != 0;
  boolean showDownArrow = !(95 + BarVLengthRight < height) && Scroll != height - BarVLengthRight - 95;
  if(showUpArrow){
    rect(p88, 68, 12, 12, 2);
    line(p88, 65, p88+3, 68);
    line(p88, 65, p88-3, 68);
  }
  if(showDownArrow){
    rect(p88, height - 12, 12, 12, 2);
    line(p88, height-9, p88+3, height-12);
    line(p88, height-9, p88-3, height-12);
  }
  if(mousePressed && abs(mouseX - (p88)) < 6){
    if(abs(mouseY - 68) <= 6 && showUpArrow){
      Scroll+=8;
      if(Scroll > 0) Scroll = 0;
    }else if(abs(mouseY - (height-12)) <= 6 && showDownArrow){
      Scroll-=8;
      if(95 + Scroll + BarVLengthRight < height){
        if(95 + BarVLengthRight < height) Scroll = 0; // if not long enough to make scrollbar
        else Scroll = height - BarVLengthRight - 95;
      }
    }
  }

}
