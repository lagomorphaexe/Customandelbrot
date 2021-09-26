
/* Filing Bar */
void drawBarSaveLoad(){
  
  /* Bar Itself and Header Text */
  fill(200); 
  noStroke();
  rect(barPosLeft-100,height/2,200,height); // bar rect.
  fill(0);
  textFont(mono[0]); // small font
  textAlign(CENTER);
  text("Saved\nFractals",barPosLeft-100,50);
  
  /* Normal Fonts and Align */
  stroke(0);
  textFont(mono[1]);
  textAlign(LEFT);
  
  /* Input Text Box */
  drawTextBox("",barPosLeft-130,150,"textToSave","String");
  
  /* (-) button */
  if(fileNames.length>0){
    stroke(#000000);
  }else{
    stroke(#666666);
  }
  if(fileNames.length>0){
    fill(#ff6666);
  }else{
    fill(#ffcccc);
  }
  rect(barPosLeft-65,150,25,25,5);
  rect(barPosLeft-65,150,15,1,1);
 
 /* Delete A Named Set */
 if(mousePressed && mouseX < barPosLeft-65+12.5 && mouseX > barPosLeft-65-12.5 && mouseY > 150-12.5 && mouseY < 150+12.5 && hasCalled < 0){
   if(tryToDeleteFromFile(strings.get("textToSave"))){
     filefeedback = "~"+strings.get("textToSave") + " was deleted.";
     FILEUPDATE=true;
   }else{
     filefeedback="!That set does not exist";
   }
   hasCalled = 10;
 }
 
 
 /* (+) button */
 stroke(0);
 fill(#66ff66);
 rect(barPosLeft-34,150,25,25,5);
 fill(#000000);
 rect(barPosLeft-34,150,15,1,1);
 rect(barPosLeft-34,150,1,15,1);
 
 /* Add Named Set */
 if(mousePressed && mouseX < barPosLeft-34+12.5 && mouseX > barPosLeft-34-12.5 && mouseY > 150-12.5 && mouseY < 150+12.5 && hasCalled < 0){
   
   /* If Named Set Is Already In File */
   /* And If Name is Not Entirely Whitespace */
   if(!strings.get("textToSave").trim().equals("")){
     boolean exists = false;
     for(int i=0; i<fileNames.length; i++){
       if(fileNames[i].equals(strings.get("textToSave"))){
         exists = true;
       }
     }
     if(!exists){
       /* Write Current Render To File */
       writeToFile(strings.get("textToSave"));
       FILEUPDATE = true;
       hasCalled = 10;
       filefeedback="~"+strings.get("textToSave") + " written to file";
       
       /* If Something Goes Wrong */
     }else{
       filefeedback="!Set "+strings.get("textToSave")+" already exists";
     }
   }else{
     filefeedback="!Name cannot be blank";
   }
 }
 
 /* (v) Button */
 stroke(0);
 fill(#ffee66);
 rect(barPosLeft-34,180,25,25,5);
 fill(#000000);
 rect(barPosLeft-34,178,1,11,1);
 stroke(0,0,0);
 strokeWeight(2);
 line(barPosLeft-39,180,barPosLeft-35,184);
 line(barPosLeft-30,180,barPosLeft-34,184);
 strokeWeight(1);
 rect(barPosLeft-34,188,15,1,1);
 
 /* Save as png if none saved to that name */
 if(mousePressed && mouseX < barPosLeft-34+12.5 && mouseX > barPosLeft-34-12.5 && mouseY > 180-12.5 && mouseY < 180+12.5 && hasCalled < 0){
   if(strings.get("textToSave").equals("")){
     String[] date = {Integer.toString(year()),Integer.toString(month()),Integer.toString(day()),Integer.toString(hour()),Integer.toString(minute()),Integer.toString(second())};
     currentSet.save("Saved-images/SavedFractal-"+join(date,"-")+".png");
     filefeedback = "~Downloaded with timestamp";
   }else{
     currentSet.save("Saved-images/"+strings.get("textToSave")+".png");
     filefeedback = "~Downloaded as png.";
   }
 }
 
 /* Write out currently saved sets */
 fill(200);
 for(int i=0; i<fileNames.length; i++){
   
   /* Make set brighter if mouse is on it, darker otherwise */
   if(mouseX > barPosLeft-175 && mouseX < barPosLeft-10 && savedFractalDisp[i]<56 && mouseY < 235+30*i && mouseY > 205+30*i){
     savedFractalDisp[i] += 8; 
   }else if(savedFractalDisp[i]>0 && (mouseX <= barPosLeft-175 || mouseX >= barPosLeft-10 || mouseY >= 235+30*i || mouseY <= 205+30*i)){
     savedFractalDisp[i] -= 8;
   }
   
   /* Box itself */
   fill(200+savedFractalDisp[i]-1);
   rect(barPosLeft-100,220+30*i,150,30);
   fill(0);
   text(fileNames[i],barPosLeft-100,226+30*i);
   
 }
   
   /* If Saved Set Clicked */
  if(mousePressed && hasCalled<0 && mouseX > barPosLeft-175 && mouseX < barPosLeft-10 && mouseY < 205+30*fileNames.length && mouseY > 205){
   hasCalled = 10;
   loadSet(fileNames[(int)((mouseY-205)/30)]);
   filefeedback = "~Set " +fileNames[(int)((mouseY-205)/30)]+" loaded";
   canDraw = true;
   currentText = fileNames[(int)((mouseY-205)/30)];
  }
  
  /* Write out feedback on action */
  /* ~ means a successful operation */
  /* ! means an error occured */
  if(filefeedback.substring(0,1).equals("~")){
    fill(0,100,0);
  }else{
    fill(255,0,0);
  }
  textFont(mono[2]);
  text(filefeedback.substring(1),barPosLeft-100,185);
 
}
