import java.util.*;
import java.util.Map;
import java.util.HashMap;
int TextBoxArrayPosition;
void drawTextBox(String name, float x, float y, String vname, String dtype){
  if(!dtype.equals("array")) Displacement += 30;
  noStroke();
  fill(0);
  textAlign(LEFT);
  if(!dtype.equals("array")) text(name,x,y+5);
  rectMode(CENTER);
  textAlign(CENTER);
  stroke(0);
  fill(255);
  /* On Mouse Click */
  if(dtype.equals("double")) rect(x+100,y,110,25,5);
  else if(dtype.equals("String")) rect(x,y,90,25,5);
  else rect(x+130,y,50,25,5);
  if(mousePressed){
    if(((dtype.equals("double")&&abs(mouseX-x-100)<55) || (abs(mouseX-x)<45 && dtype.equals("String")) || (abs(mouseX-x-130)<25 && !dtype.equals("double") && !dtype.equals("String"))) && abs(mouseY-y)<12.5){
      textBoxSelected.put(vname,1);
      if(dtype.equals("int")) currentText = str(ints.get(vname)); // dtype -> String
      else if(dtype.equals("double")){ 
        if(vname=="ZoomDepth") currentText = toString(doubles.get(vname));
        else currentText = toString(doubles.get(vname));//%6d
      }else if(dtype.equals("float")){
        if(vname.equals("overflow")) floats.put("overflow",sqrt(floats.get("overflow")));
        if(floats.get(vname) == round(floats.get(vname))) currentText = str(int(floats.get(vname)));
        else currentText = str(pow(10,4)*floats.get(vname)/(float)pow(10,4));//%4f
        if(vname.equals("overflow")) floats.put("overflow",pow(floats.get("overflow"),2));
      }else if(dtype.equals("array")){
        TextBoxArrayPosition = int(name);
        float value = arrays.get(vname).get(TextBoxArrayPosition);
        if(value==round(value)) currentText = str(int(value));
        else currentText = str(value);
      }else if(dtype.equals("String")) currentText = strings.get(vname);
    }else if((!dtype.equals("array"))||(int(name)==TextBoxArrayPosition)){
      try{
        textBoxSelected.remove(vname);
      }catch(Exception e){}
    }
  }
  /* Display Text */
  fill(0);
  if(!(textBoxSelected.containsKey(vname) && (!dtype.equals("array") || name.equals(str(TextBoxArrayPosition))))){
    if(dtype.equals("int")) text(str(ints.get(vname)),x+130,y+5);
    else if(dtype.equals("double")){
      if(vname!="ZoomDepth") text(toString(doubles.get(vname)),x+100,y+5);
      else text(toString(doubles.get(vname)),x+100,y+5);//%6d
    }else if(dtype.equals("float")){
      if(vname.equals("overflow")) floats.put("overflow",sqrt(floats.get("overflow")));
      if(floats.get(vname)==round(floats.get(vname))) text(str(int(floats.get(vname))),x+130,y+5);
      else text(str(pow(10,4)*floats.get(vname)/(float)pow(10,4)),x+130,y+5);//%4f
      if(vname.equals("overflow")) floats.put("overflow",pow(floats.get("overflow"),2));
    }else if(dtype.equals("array")){
      float value = arrays.get(vname).get(int(name));
      if(value==round(value)) text(str(int(value)),x+130,y+5);
      else text(str(value),x+130,y+5);
    }else if(dtype.equals("String")) text(strings.get(vname),x,y+5);
  }else{
    if(dtype.equals("double")) text(" "+currentText+"|",x+100,y+5);
    else if(dtype.equals("String")) text(" "+currentText+"|",x,y+5);
    else text(" "+currentText+"|",x+130,y+5);
  }
}

String toString(Double d){
  String norm = Double.toString(d);
  int Epos = norm.indexOf('E');
  if(Epos != -1) norm = norm.substring(0, min(Epos, 7)) + norm.substring(Epos);
  else norm = norm.substring(0,min(norm.length(),9));
  return norm;
}

void drawSlider(float x, float y, double min, double max, String vname, String dtype){
  Displacement+=35;
  noStroke();
  fill(150);
  rect(x,y,150,5,3);
  fill(0);
  rectMode(CENTER);
  if(dtype.equals("int")){
    rect(map(min((int)max,max((int)min,ints.get(vname))),(int)min,(int)max,x-75,x+75),y,5,15,2); // slider, in bounds if possible    
    if(mousePressed && abs(mouseX-x)<90 && abs(mouseY-y)<15){ // if slider is being clicked
      ints.put(vname,round(map(mouseX,x-75,x+75,(int)min,(int)max)));
      if(ints.get(vname)>max) ints.put(vname,(int)max); // if outside of scale bounds
      else if(ints.get(vname)<min) ints.put(vname,(int)min);
      canDraw = true;
    }
  }else if(dtype.equals("float")){
    if(vname.equals("overflow")) floats.put("overflow",sqrt(floats.get("overflow")));
    rect(map(min((float)max,max((float)min,floats.get(vname))),(float)min,(float)max,x-75,x+75),y,5,15,2); // slider, in bounds if possible
    if(mousePressed && abs(mouseX-x)<90 && abs(mouseY-y)<15){ // if slider is being clicked
      String val = str(map(mouseX,x-75,x+75,(float)min,(float)max));
      floats.put(vname,float(val.substring(0,min(5,val.length()))));
      if(floats.get(vname)>max) floats.put(vname,(float)max); // if outside of scale bounds
      else if(floats.get(vname)<min) floats.put(vname,(float)min);
      canDraw = true;
    }
    if(vname.equals("overflow")) floats.put("overflow",floats.get("overflow")*floats.get("overflow"));
  }else if(dtype.equals("double")){
    rect((float)doubleMap(Math.min(Math.log10(max),Math.max(Math.log10(min),Math.log10(doubles.get(vname)))),Math.log10(min),Math.log10(max),x-75,x+75),y,5,15,2);
    if(mousePressed && abs(mouseX-x)<90 && abs(mouseY-y)<15){ // if slider is being clicked
      doubles.put(vname,Math.pow(10,doubleMap(mouseX,x-75,x+75,Math.log10(min),Math.log10(max))));
      if(doubles.get(vname)>max) doubles.put(vname,max); // if outside of scale bounds
      else if(doubles.get(vname)<min) doubles.put(vname,min);
      canDraw = true;    
    }
  }
}

double doubleMap(double x, double smin, double smax, double emin, double emax){
  //double shx = x - (smax+smin)/2;
  //double tfx = shx / (smax-smin) * (emax-emin);
  //return tfx + (emax + emin)/2;
  return (x - (smax+smin)/2) / (smax-smin) * (emax-emin) + (emax+emin)/2;
}

void drawCheckBox(String name, float x, float y, String vname){
  Displacement += 30;
  textAlign(LEFT);
  fill(0);
  text(name,x,y+5);
  stroke(0);
  if(bools.get(vname)) fill(0,255,0);
  else fill(255);
  rect(x+142.5,y,25,25,5);
  if(mousePressed && abs(mouseX-x-142.5)<12.5 && abs(mouseY-y)<12.5 && hasCalled<0){
    bools.put(vname,!bools.get(vname));
    hasCalled=10;
    canDraw=true;
  }
}

void drawSelectionBox(float x, float y, float w, float indw, float h, String vname, PImage[] icons){
  Displacement += h + 10;
  stroke(0);
  for(int i=0; i<icons.length; i++){
    float indx = map(i,0,icons.length-1,x,x+w); // individual x pos 
    if((bools.containsKey(vname)&&(bools.get(vname)?1:0)==i) || (ints.containsKey(vname)&&ints.get(vname)==i)) fill(0,255,0);
    else fill(255); // fill either green or white based on .get(vname)
    rect(indx,y,indw,h,5); // bg rect
    noStroke();
    image(icons[i],indx,y); // img
    noFill();
    strokeWeight(4);
    if((bools.containsKey(vname)&&(bools.get(vname)?1:0)==i) || (ints.containsKey(vname)&&ints.get(vname)==i)) stroke(0,255,0);
    rect(indx,y,indw-4,h-4,5); // green border around
    stroke(0);
    strokeWeight(1);
    rect(indx,y,indw,h,5); // border
    
    if(mousePressed && abs(mouseX-indx)<indw/2 && abs(mouseY-y)<h/2){ // on tap
      if(bools.containsKey(vname)) bools.put(vname,i==1);
      else if(ints.containsKey(vname)) ints.put(vname,i);
      canDraw = true;
    }
  }
}

void drawListBoxes(String name, float x, float y, String vname){
  Displacement += 50+30*ceil(arrays.get(vname).size()/3.);
  textAlign(LEFT);
  fill(0);
  text(name,x,y+5);
  // [-] button
  if(arrays.get(vname).size()>1){
    stroke(#000000);
    fill(#ff6666);
  }else{
    stroke(#666666);
    fill(#ffcccc);
  }
  rect(x+110,y,25,25,5);
  rect(x+110,y,15,1,1);
  if(mousePressed && abs(mouseX-x-110)<12.5 && abs(mouseY-y)<12.5 && arrays.get(vname).size()>1 && hasCalled<0){
    ArrayList<Float> temp = arrays.get(vname);  
    temp.remove(temp.size()-1);
    arrays.put(vname,temp);
    hasCalled=10;
    canDraw=true;
  }
  
  // [+] button
  if(arrays.get(vname).size()<12){
    stroke(#000000);
    fill(#66ff66);
  }else{
    stroke(#666666);
    fill(#ccffcc);
  }
  rect(x+140,y,25,25,5);
  rect(x+140,y,15,1,5);
  rect(x+140,y,1,15,1);
  if(mousePressed && abs(mouseX-x-140)<12.5 && abs(mouseY-y)<12.5 && arrays.get(vname).size()<12 && hasCalled<0){
    ArrayList<Float> temp = arrays.get(vname);
    temp.add(2f);
    arrays.put(vname,temp);
    hasCalled=10;
    canDraw=true;
  }
  
  //totaldisp += 35*ceil(arrays.get(vname).size()/3.0);
  //totaldisp += 10;
  for(int i=0;i<arrays.get(vname).size();i++){
    drawTextBox(str(i),x+54*(i%3-1)-55,y+35+(int)(i/3)*30,vname,"array");
  } 
}
