//import java.util.Math;
//import java.util.*;
//import java.lang.*;

public class Complex {
  double re, im;
  
  Complex(double r, double i){
    re = r;
    im = i;
  }
  double re(){return(re);}
  double im(){return(im);}
  double sqabs(){
    return(re*re+im*im);
  }
  Complex add(Complex c){
    return(new Complex(c.re()+re,c.im()+im));
  }
  Complex add(double d){
    return(new Complex(re()+d,im()));
  }
  Complex sub(double d){
    return(new Complex(re()-d,im()));
  }
  Complex sub(Complex c){
    return(new Complex(re-c.re(),im-c.im()));
  }
  Complex mult(Complex c){
    return(new Complex(c.re()*re-c.im()*im,c.re()*im+c.im()*re));
  }
  Complex mult(double d){
    return(new Complex(re*d,im*d));
  }
  Complex div(Complex c){
  double abs = c.re()*c.re()+c.im()*c.im();
    Complex inv = new Complex(c.re()/abs,-c.im()/abs);
    return(inv.mult(new Complex(re,im)));
  }
  Complex pwr2(){
    return(new Complex(re*re-im*im,2*re*im));
  }
  Complex pwr(Complex c){
    double a = Math.sqrt(re*re+im*im);
    double alpha = Math.acos(re/a);
    if(im<0) alpha*=-1;
    double b = Math.sqrt(c.re()*c.re()+c.im()*c.im());
    double beta = Math.acos(c.re()/b);
    if(c.im()<0) beta*=-1;
    
    double abs = b*Math.log(a)*Math.cos(beta)-alpha*b*Math.sin(beta); 
    double arg = b*Math.log(a)*Math.sin(beta)+alpha*b*Math.cos(beta);
    return(new Complex(Math.exp(abs)*Math.cos(arg),Math.exp(abs)*Math.sin(arg)));
  } 
  Complex pwr(double d){
    double a = Math.sqrt(re*re+im*im);
    double alpha = Math.acos(re/a);
    if(im<0) alpha*=-1;
    return(new Complex(Math.pow(a,d)*Math.cos(d*alpha), Math.pow(a,d)*Math.sin(d*alpha)));
  }
  Complex pwr(int p){
    Complex out = new Complex(1,0);
    for(int i=0; i<Math.abs(p); ++i){
      out = out.mult(new Complex(re,im));
    }
    if(p<0){//invert
      double abs = out.re()*out.re()+out.im()*out.im();
      return(new Complex(out.re()/abs,-out.im()/abs));
    }
    return(out);
  }
  
  Complex csin(){
    double real = 0.5*Math.sin(re)*(Math.exp(im)+Math.exp(-im));
    double imag = 0.5*Math.cos(re)*(Math.exp(im)-Math.exp(-im));
    return(new Complex(real, imag));
  }
  Complex ccos(){
    double real = 0.5*Math.cos(re)*(Math.exp(im)+Math.exp(-im));
    double imag =-0.5*Math.sin(re)*(Math.exp(im)-Math.exp(-im));
    return(new Complex(real, imag));
  }
  Complex sqrt(){
    double ab = Math.sqrt(re*re+im*im);
    double xp = Math.sqrt((ab+re)/2);
    double yp = Math.sqrt((ab-re)/2);
    if(im<0){xp*=-1;}
    return(new Complex(xp,yp));
  }
}
