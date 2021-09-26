void DRAW_HELPTEXT(){
  
  textFont(mono[0]);
  rectMode(CENTER);
  textAlign(CENTER);
  
  /* q controls button coloring */
  int[] q = {0,255};
  if(abs(mouseX-150)<75 && abs(mouseY-90)<25){
    q=new int[]{255,0};
    if(mousePressed){
      WhereAmI = "menu";
    }
  }
  
  /* buttons */
  stroke(255);
  strokeWeight(3);
  fill(q[0]);
  rect(150,90,150,50,10);
  fill(q[1]);
  text("< Back",150,100);
  
  /* help tabs */
  for(int tab=1; tab<tabsText.length; tab++){
    textAlign(CENTER);
    q = new int[]{0,255};
    if(abs(mouseX-125-tab*215)<100 && abs(mouseY-90)<25){
      q = new int[]{255,0};
      if(mousePressed){
        whichHelp = tab;
      }
    }
    fill(q[0]);
    rect(125+tab*215,90,200,50,10);
    fill(q[1]);
    text(tabsText[tab],125+tab*215,100);
    
    fill(255);
    imageMode(CORNER);
    image(helpText[whichHelp],75,175);
    
  }
}
