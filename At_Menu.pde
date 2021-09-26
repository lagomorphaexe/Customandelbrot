void DRAW_MENU(){
    background(0);
  
  // Banner text
  fill(255);
  pushMatrix();
  translate(width/2,height*0.13);
  rotate(PI/100*sin(theta));
  text("Customandelbrot",0,0);
  popMatrix();
  
  theta += 0.03;
  
  // image gallery + bounding rect
  imageMode(CENTER);
  //image(renders[(int)(frameCount/90) % 30],width/2,0.75*height/2,610,400);
  
  stroke(255);
  strokeWeight(5);
  op = 255 - 45*abs(frameCount - 90*round((float)frameCount/90));
  fill(255,op);
  rect(width/2,0.75*height/2,610,400,10);  

  // begin button
  
  codeButton("Begin",0.5*width,0.66*height,250,75);
  codeButton("Instructions",0.5*width,0.77*height,250,75);
  textFont(mono[3]);
}

/* Codes for a button */
void codeButton(String dText, float xcoord, float ycoord, float xsize, float ysize){
  int boolMouseHere = 0;
  if (mouseInRange(xcoord,ycoord,xsize,ysize)) {
    boolMouseHere = 1;
  }
  fill(255*boolMouseHere);
  rect(xcoord,ycoord,xsize,ysize,10);
  fill(255-255*boolMouseHere);
  textFont(mono[0]);
  text(dText,xcoord,ycoord+15);
  
  
}
boolean mouseInRange(float xcoord, float ycoord, float xsize, float ysize){
  return(mouseX > xcoord-0.5*xsize && mouseX < xcoord+0.5*xsize) && (mouseY > ycoord-0.5*ysize && mouseY < ycoord+0.5*ysize); 
}
