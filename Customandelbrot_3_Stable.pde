/* Code Written By Eli Mrug 2020-2021
**
** This program may be run in conjunction with:
**  - HyperbolIFS generator [link]
**  - NewtonFractal generator [link]
** Note that fractals are computationally heavy. It is especially easy to hang the app by requiring too many calculations.
** Processing does not allow for any other code to run when draw() is running. I.e., there is no easy way to loop out of this, unless frame-skipping is implementing.
** Thus, in this case, close out of the program and rerun it. It is not efficient, but it is the best method.
**
** Powerlist can take arguments for special fractals, namely:
**  - 999: Burning Ship          a+bi -> (|a| + |b|i)^2 + c
**  - 998: Mandelbar (3)            z -> (z*)^2 + c
**  - 997: Inv. Mandelbar           z -> (z*)^{-2} + c
**  - 996: Mandelbar (4)            z -> (z*)^3 + c
**  - 995: City-blocks           a+bi -> a^3 - ab^2i - a^2b + b^3i + c
**  - 994:                          z -> z^2/(z+1) + c
**  - 993:                          z -> (z - sgn(Re(z)))/l
**  - 992:                          z -> ( z - 1 )/l or (z + 1)/l* based on sgn(Re(z))
**  - 991: Logistic Map             z -> zc(1-z)
** 
*/


/*Setup*/
void setup(){
  
  /*Set up screen and aligns*/
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  fullScreen();
  //size(600,400);
  noStroke();
  
  /* Load Variables */
  LoadVariables();
  
  /* Placeholders */
  background(0);
  PImage placeholder = loadImage("Asset-images/placeholder.png");
  image(placeholder,width/2,height/2,placeholder.width/2,placeholder.height/2);
  text("Loading Assets...",width/2,height/2+100);
  
  /*Load Fonts*/
  mono[0] = createFont("DialogInput.plain",30);
  mono[1] = createFont("DialogInput.plain",15);
  mono[2] = createFont("DialogInput.plain",10);
  mono[3] = createFont("DialogInput.plain",100);
    
  //frameRate(30);
  
  /* Load Mandel/Julia placeholder sprites */
  previews = new PImage[]{loadImage("Asset-images/mandelbrot-preview.png"),loadImage("Asset-images/julia-preview.png")};
  for(int i=0; i<previews.length; i++){
    previews[i].resize(previews[i].width/7,previews[i].height/7);  
  }
  
  /* Load coloring sprites */
  for(int i=0; i<gradientSelection.length; i++){
    gradientSelection[i] = createImage(30,30,RGB);
    gradientSelection[i].loadPixels();
    for(int j=0; j<30; j++){
      for(int k=0; k<30; k++){
        gradientSelection[i].pixels[j*30+k]=genColor(float(k)/30*256,i);
      }
    }
    gradientSelection[i].updatePixels();
  }
  
  /* Sample set images */
  /*for (int i=1; i<31; i++){
    renders[i-1] = loadImage("Asset-images/Sample-images/Mandelbrot-"+str(i)+".png");
  }*/
  
  /* Help text */
  helpText[0] = new PImage(5,5);
  helpText[1] = loadImage("Asset-images/Help-images/Mandelbrot.png");
  helpText[2] = loadImage("Asset-images/Help-images/Parameters-01.png");
  helpText[3] = loadImage("Asset-images/Help-images/Parameters-02.png");
  helpText[4] = loadImage("Asset-images/Help-images/Navigations.png");
  helpText[5] = loadImage("Asset-images/Help-images/Save-Load.png");
  
  for(int i=0; i<6; i++){
    helpText[i].resize(int(0.8*helpText[i].width),int(0.8*helpText[i].height));
  }
  
  for(int i=0; i<size; ++i)
    SamplePixels[i] = new double[]{0,0};
  
  // Check that savedSets.hd.txt exists
  try{
    HashMap<String,Object> t = (HashMap<String,Object>)ReadObjectFromFile("savedSets.hd.txt");
    t.keySet();
  }catch(NullPointerException e){
    HashMap<String,Object> t = new HashMap<String,Object>();
    DumpObjectToFile(t);
  }
}
  
void draw(){
  background(0,0,0); 
       if(WhereAmI.equals("menu")) DRAW_MENU();
  else if(WhereAmI.equals("viewer")) DRAW_MANDELBROT();
  else if(WhereAmI.equals("help")) DRAW_HELPTEXT();
  hasCalled--; // to make check boxes not switch at mach 1

  /* Display FPS Counter */

}

int fps=0;
int fctr = 0;
int fcPsec = second();