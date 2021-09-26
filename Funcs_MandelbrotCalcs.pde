import java.lang.Math;
Complex ONE = new Complex(1, 0);
double minabs = pow(10, 10);

double[] iterate(boolean jMode, double a, double b, double cx, double cy, float[] powerll, float[] multll, double[] c, int t) {
  if (bools.get("IsPowerRepeat")) 
    return(MANDEL(powerll[t%powerll.length], 
    c, 
    (jMode ? cx : a)*multll[t%multll.length], 
    (jMode ? cy : b)*multll[t%multll.length])); // square function
  else 
    return(MANDEL(powerll[min(t, powerll.length-1)], 
    c, 
    (jMode ? cx : a)*multll[min(t, multll.length-1)], 
    (jMode ? cy : b)*multll[min(t, multll.length-1)]));
}

boolean isInFractal(boolean jMode, double a, double b, double cx, double cy, int itera) { // determines whether a Complex number is Mandelbrot (a+bi)
  // Input Translation    
  double[] tmp = MANDEL(floats.get("inputTranslation"), new double[]{a, b}, 0, 0);
  a=tmp[0]; 
  b=tmp[1];  

  // Aray Inits
  double[] c = jMode ? new double[]{a, b} : new double[]{cx, cy};
  minabs = pow(10, 10);
  float overfloe = floats.get("overflow");
  
  // Default Iteration
  double[] dc = {1,0};
  double lz2 = c[0]*c[0] + c[1]*c[1];
  for (int t=0; t<itera; t++) {
    //c = iterate(jMode, a, b, cx, cy, powerll, multll, c, t);
    if(bools.get("DEM")){
      //ld2 *= 4.0*lz2;
      float d = bools.get("IsPowerRepeat") ? powerll[t%powerll.length] : powerll[min(t, powerll.length-1)];
      d = (d>900) ? 2 : d;
      if(jMode) dc = new double[]{d*(c[0]*dc[0] - c[1]*dc[1]), d*(c[0]*dc[1] + c[1]*dc[0])};
      else dc = new double[]{d*c[0]*dc[0] - d*c[1]*dc[1] + 1, d*c[0]*dc[1] + d*c[1]*dc[0]};
    }
    if (bools.get("IsPowerRepeat")) c = (MANDEL(powerll[t%powerll.length], 
      c, 
      (jMode ? cx : a)*multll[t%multll.length], 
      (jMode ? cy : b)*multll[t%multll.length])); // square function
    else                              c = (MANDEL(powerll[min(t, powerll.length-1)], 
      c, 
      (jMode ? cx : a)*multll[min(t, multll.length-1)], 
      (jMode ? cy : b)*multll[min(t, multll.length-1)]));
    
    lz2 = c[0]*c[0]+c[1]*c[1];
    if (lz2 < minabs) minabs = lz2;
    if (lz2 >= overfloe) {
      float d = bools.get("IsPowerRepeat") ? powerll[t%powerll.length] : powerll[min(t, powerll.length-1)];
      d = (d>900) ? 2 : 2;//d;
      if(bools.get("DEM")){
        double d0 = (Math.sqrt(lz2/(dc[0]*dc[0]+dc[1]*dc[1]))*Math.log(lz2));
        float d1 = (float)(d0/doubles.get("ZoomDepth"));
        if (d1 < 0) d1 = 0; else if (d1 > 1) d1 = 1;
        qucol = pow(d1*(float)ints.get("colorGrad"),0.5);
      }else{
        qucol = t - (!bools.get("smoothColoring") ? 0 : log(0.5*log((float)(c[0]*c[0]+c[1]*c[1]))/log(sqrt((overfloe==1)?1.00001:overfloe)))/log(d));
      }
      return false;
    }
  }

  // Sample Pixel
  double[] c2 = new double[2];
  arrayCopy(c, c2);
  recurseLength = -1;
  for (int t=0; t<100 && ints.get("BulbSelect")>0; t++) {
    c2 = iterate(jMode, a, b, cx, cy, powerll, multll, c2, t);
    if (Math.abs(c2[0]-c[0]) <= Math.pow(10, -6) && Math.abs(c2[1]-c[1]) <= Math.pow(10, -6)) {
      recurseLength = 1+t;
      break;
    }
  }
  return true;
}

double[] cdiv(double[] num, double[] den) {
  double invsqden = 1/(den[0]*den[0]+den[1]*den[1]);
  return(new double[]{invsqden * (num[0]*den[0]+num[1]*den[1]), invsqden * (num[1]*den[0]-num[0]*den[1])});
}

double[] MANDEL(float power, double[] c, double a, double b) { // Complex number power generator. no Complex numbers in vanilla java soo....
  if (bools.get("MandelbarMode")) c[1]=-c[1];
  //double[] q;
  if(power%1==0){
    switch((int)power){ // note only ints can be switched
      case 2:
        return(new double[]{c[0]*c[0] - c[1]*c[1] + a, 2*c[0]*c[1] + b});
      case 3:
        return(new double[]{c[0]*c[0]*c[0] - 3*c[0]*c[1]*c[1] + a, 3*c[0]*c[0]*c[1]-c[1]*c[1]*c[1] + b});
      case 4:
        return(new double[]{c[0]*c[0]*c[0]*c[0] - 6*c[0]*c[0]*c[1]*c[1] + c[1]*c[1]*c[1]*c[1]+ a, 4 * c[0]*c[0]*c[0]*c[1] - 4*c[1]*c[1]*c[1]*c[0] + b});
      case 5:
        return(new double[]{c[0]*c[0]*c[0]*c[0]*c[0] - 10*c[0]*c[0]*c[0]*c[1]*c[1] + 5*c[0]*c[1]*c[1]*c[1]*c[1]+ a, 5 * c[0]*c[0]*c[0]*c[1]*c[0] - 10*c[1]*c[1]*c[1]*c[0]*c[0] +c[1]*c[1]*c[1]*c[1]*c[1] + b});
      case 6:
        return(new double[]{c[0]*c[0]*c[0]*c[0]*c[0]*c[0] - 15*c[0]*c[0]*c[0]*c[0]*c[1]*c[1] + 15*c[0]*c[0]*c[1]*c[1]*c[1]*c[1] - c[1]*c[1]*c[1]*c[1]*c[1]*c[1]+a, 6*c[0]*c[0]*c[0]*c[0]*c[0]*c[1] - 20*c[0]*c[0]*c[0]*c[1]*c[1]*c[1] + 6*c[0]*c[1]*c[1]*c[1]*c[1]*c[1]+b});
      case -20:
        double abs = 1/(c[0]*c[0]+c[1]*c[1]);
        return(new double[]{(c[0]*c[0]-c[1]*c[1])*abs*abs + a, -2*c[0]*c[1]*abs*abs + b});
      case -1:
        double abs2 = 1/(c[0]*c[0]+c[1]*c[1]);
        return(new double[]{c[0]*abs2 + a, -c[1]*abs2 + b});
      case 0:
        return(new double[]{1+a,b});
      case 1:
        return(new double[]{c[0]+a, c[1]+b});
      case 999:
        return(new double[]{c[0]*c[0] - c[1]*c[1] + a, 2*c[0]*c[1]*((c[0]*c[1]>0)?1:-1) + b});
      case 998:
        return(new double[]{c[0]*c[0]-c[1]*c[1] + a, -2*c[0]*c[1] + b});
      case 997:
        double abs3 = 1/(c[0]*c[0]+c[1]*c[1]);
        return(new double[]{c[0]*abs3, c[1]*abs3});
      case 996:
        return(new double[]{c[0]*c[0]*c[0] - 3*c[0]*c[1]*c[1] + a, -3*c[0]*c[0]*c[1]+c[1]*c[1]*c[1] + b});
      case 995:
        if(c[0] < 0) c[0] *= -1;
        if(c[1] < 0) c[1] *= -1;
        return(new double[]{c[0]*c[0]*c[0] + 3*c[0]*c[1]*c[1] + a, 3*c[0]*c[0]*c[1]+c[1]*c[1]*c[1] + b});
      case 994:
        double[] temp = cdiv(new double[]{c[0]*c[0]-c[1]*c[1], 2*c[0]*c[1]}, new double[]{c[0]+1, c[1]});
        temp[0] += a; temp[1] += b;
        return(temp);
      case 993:
        // From Fractals Everywhere
        /** /
        return(new double[]{
          c[0]*a-c[1]*b-(c[0]>0?1:-1),
          c[0]*b+c[1]*a
        });
        /*/
        return cdiv(new double[]{c[0] - (c[0]>0?1:-1), c[1]},new double[]{a,b});
      case 992:
        // Also from above book
        //Complex z = new Complex(c[0],c[1]);
        //Complex l = new Complex(a,b*(c[0]>=0?1:-1));
        //return((z.add((c[0]<0)?1:-1)).div(l).toArray());
        double[] zs = {c[0]+((c[0]<0)?1:-1),c[1]};
        b *= (c[0]>=0?1:-1);
        double abs5 = 1/(a*a+b*b);
        return(new double[]{
          (zs[0]*a + zs[1]*b)*abs5,
          (zs[1]*a - zs[0]*b)*abs5
        });
      case 991:
        double[] z2 = {(c[0])*a-c[1]*b,c[1]*a+(c[0])*b};
        return(new double[]{
          z2[0]*(1-c[0])-z2[1]*(0-c[1]),
          z2[0]*(0-c[1])+z2[1]*(1-c[0])
        });
      default:
        double[] q;
        int fpwr = (int)Math.floor(power);
        if (fpwr >= 0) {
          q = new double[]{c[0], c[1]};
          for (int i=0; i<abs(fpwr)-1; i++) {
            q = new double[]{q[0]*c[0]-q[1]*c[1], q[1]*c[0]+q[0]*c[1]};
          }
        } else {
          c[1] *= -1;
          double abs4 = 1/(c[0]*c[0]+c[1]*c[1]);
          double[] w = new double[]{c[0]*abs4, c[1]*abs4};
          q = new double[]{1, 0};
          for (int i=0; i<abs(fpwr); ++i) {
            q = new double[]{q[0]*w[0] - q[1]*w[1], w[1]*q[0] + w[0]*q[1]};
          }
        }
        q[0]+=a;
        q[1]+=b;
        return(q); 
    }
  }else{
    double[] q;
    if(power%1 == 0.5){
      int fpwr = (int)Math.floor(power);
      if (fpwr >= 0) {
        q = new double[]{1, 0};
        for (int i=0; i<abs(fpwr); ++i) {
          q = new double[]{q[0]*c[0]-q[1]*c[1], q[1]*c[0]+q[0]*c[1]};
        }
      } else {
        c[1] *= -1;
        double abs = 1/(c[0]*c[0]+c[1]*c[1]);
        double[] w = new double[]{c[0]*abs, c[1]*abs};
        q = new double[]{1, 0};
        for (int i=0; i<abs(fpwr); ++i) {
          q = new double[]{q[0]*w[0] - q[1]*w[1], w[1]*q[0] + w[0]*q[1]};
        }
      }
      double z = Math.sqrt((c[0]*c[0]+c[1]*c[1]));
      double x = Math.sqrt((z+c[0])/2);
      if (c[1]<0) x=-x;
      double y = Math.sqrt((z-c[0])/2);
      q = new double[]{q[0]*x-q[1]*y, q[1]*x+y*q[0]};
    }else{
      double z = Math.sqrt(c[0]*c[0] + c[1]*c[1]);
      if (z==0) {
        q = new double[]{a, b};
      } else {
        double alpha;
        if (c[1]>0) {
          alpha = Math.acos(c[0]/z);
        } else {
          alpha = 2*Math.PI-Math.acos((c[0]/z));
        }
        q = new double[]{Math.pow(z, power)*Math.cos(alpha*power), Math.pow(z, power)*Math.sin(alpha*power)};
      }
    }
    q[0] += a;
    q[1] += b;
    return(q);
  }
}


color genColor(float itert, int method) { // generates the color based on iteration overflow point
  color t = color(0, 0, 255);
  float A = ints.get("colorGrad");
  if(bools.get("DEM")){
    // scol = qucol
    // credit goes to https://www.iquilezles.org/www/articles/distancefractals/distancefractals.htm for lots of help with DEM methods
    // still broken for non-deg 2 fractals; whoops
    float B = qucol;
    float[] vcol = {256*pow(B, 0.9), 256*pow(B, 1.1), 256*pow(B, 1.4)};
    //if(qucol < 0.1) return color(255,0,0);
    return color(vcol[0], vcol[1], vcol[2]);
  }
  if (method == 0) {
    /* Default yellow-blue gradient /*/
    colorMode(RGB);  
    float B = (2*itert+floats.get("colorStart")*A) % (A*2);
    float G = 0;
    float X = 256/A;
    if (B>A) {
      B=2*A-B;
      G=X*sqrt((2*A-B)*B);
    } else {
      G=X*(A-sqrt(A*A-B*B));
    }
    t=color(G, G, B*X); //*/
  } else if (method == 1) {
    /* Experimental full color gradient /*/
    colorMode(HSB);
    t = color(((itert+0.5*floats.get("colorStart")*A) % (A))*360/(A), 256, 256);
  } else if (method == 2) {
    /* Special gradient /*/
    colorMode(HSB);
    float B = (0.5*floats.get("colorStart")+itert/A);
    t=color((210+60*sin(2*PI*B))%256, 300-275*cos(2*PI*B), 700+600*cos(2*PI*B));
    //*/
  } else if (method == 3) {
    // stolen from the cool mandelbrot images on wikipedia through the powers of linear interpolation
    colorMode(RGB);
    float[] C = new float[3];
    float[][] points = {{26, 2, 20}, 
      {6, 38, 155}, 
      {81, 166, 230}, 
      {208, 244, 253}, 
      {244, 250, 203}, 
      {253, 205, 44}, 
      {237, 132, 5}, 
      {137, 54, 40}, 
      {37, 4, 49}/*,{1,6,63}*/};
    float a = (A==0)?1:A;
    float t2 = points.length *(itert/a + 0.5*floats.get("colorStart")-floor(itert/a + 0.5*floats.get("colorStart")));
    int i1 = (floor(t2)%points.length + points.length)%points.length;
    int i2 = (i1+1)%points.length;
    for (int i=0; i<3; i++) {
      C[i]=map(t2, floor(t2), floor(t2)+1, points[i1][i], points[i2][i]);
    }
    t=color(C[0], C[1], C[2]);
  } else if (method == 4) {
    /* Special gradient v3 /*/
    // is unobtainable because it sucks
    colorMode(HSB);
    float B = (0.5*floats.get("colorStart")+itert/A)%1;
    t = color(256*B-256*0.08*sin(4*PI*B+2*PI/(1.25)), 400-360*sin(2*PI*B-2*PI*5.1), 512-450*sin(2*PI*B-2*PI*1.64));
    //*/
  } else if (method == 5){
    // Welcome to ASFA, Mr. Kwong!
    float[] C = new float[3];
    float[][] points = {{0xFB, 0xBE, 0x45},
                {0x00, 0xBD, 0xDE},
                {0x9B, 0x59, 0xA0},
                {0x26, 0x22, 0x23},
                {0xFB, 0xBE, 0x45}};
    
    float a = (A==0)?1:A;
    float t2 = 4 *(itert/a + 0.5*floats.get("colorStart")-floor(itert/a + 0.5*floats.get("colorStart")));
    int i1 = (floor(t2)%4 + 4)%4;
    float k = 0.5;
    for (int i=0; i<3; i++) {
      float t3 = map(t2, floor(t2), floor(t2)+1, floor(t2)-k, floor(t2)+1+k);
      if(t3<floor(t2))t3 = floor(t2);
      if(t3>floor(t2)+1)t3 = floor(t2)+1;
      C[i]=map(t3, floor(t2), floor(t2)+1, points[i1][i], points[i1+1][i]);
    }
    t=color(C[0], C[1], C[2]);
  }
  return(t);
}
