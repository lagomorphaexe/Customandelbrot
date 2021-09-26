
/* Setup Variables */
PFont mono[] = new PFont[4]; // fonts
PImage[] previews;
PImage[] gradientSelection = new PImage[4];
String WhereAmI = "viewer";//"menu";//"menu";
Boolean SamplePixelPrompt = false;

/* Mandelbrot Render Variables */
PImage currentSet;
float qucol = 0;
float endabs = 0;
double cenit=0.05;
boolean canDraw  = true;
boolean invalidateDraw = false;
PImage juliaPreview;
int size = 49;
double[][] SamplePixels = new double[size][2];


/* Menu Variables */
float theta = 0; // CUSTOMANDELBROT menu text
int op; // current menuimage
PImage placeholder;
PImage[] renders = new PImage[30];

/* Help Variables */
String[] tabsText = {"Menu","Mandelbrot","Params 1","Params 2","Navigation","Saving Sets"};
int whichHelp = 1;
PImage[] helpText = new PImage[6];

/* Parameter Variables */

boolean isPowerRepeat;// for speed so don't have to be set 2,000,000 times each render
boolean mandelbar;
float[] powerll;
float[] multll;
float it = 0.2;
int recurseLength = 0;

/* Bar Variables */
int barPosRight = 0; // bar positions
int isTextBox = -1; // which text box ID is being used?
String currentText = "";// current text being typed
int hasCalled = 0;// to make sure a single click doesn't register 10 times
int totalLowerDisp = 0;
int Scroll = 0;
int BarVLengthRight = 0;

int barPosLeft = 0;
boolean FILEUPDATE = true; // update file listings?
String[] fileNames; // names of saved sets
int[] savedFractalDisp; // file name list color disp.
String filefeedback = "~"; 
boolean exists = false;

/* Special keys held */
boolean isShift, isAlt, isCtrl = false;

/* Sample Pixel */
boolean samplePixel = false;
double[] samplePixelCoords = {0,0};
