/* Dictionaries */
HashMap<String,Integer> ints, textBoxSelected;
HashMap<String,Boolean> bools;
HashMap<String,Float> floats;
HashMap<String,Double> doubles;
HashMap<String,String> strings;
HashMap<String,ArrayList<Float>> arrays;

HashMap<Class,HashMap<String,Object>> Defaults = new HashMap<Class,HashMap<String,Object>>();

void LoadVariables(){
 
  ints = new HashMap<String,Integer>();
  bools = new HashMap<String,Boolean>();
  textBoxSelected = new HashMap<String,Integer>();
  floats = new HashMap<String,Float>();
  doubles = new HashMap<String,Double>();
  arrays = new HashMap<String,ArrayList<Float>>();
  strings = new HashMap<String,String>();
  
  
  ints.put("pixelSize",2);
  ints.put("iterations",500);
  ints.put("colorMode",3);
  ints.put("colorGrad",250);
  ints.put("BulbSelect",0);
  
  Defaults.put(Class("Integer"), new HashMap<String,Object>());
  for(String i : ints.keySet()) Defaults.get(Class("Integer")).put(i, ints.get(i));
  
  floats.put("colorStart",0.2);
  floats.put("overflow",4f);
  floats.put("inputTranslation",1f);
  floats.put("inpAVtrans",1f);
 
  Defaults.put(Class("Float"), new HashMap<String,Object>());
  for(String i : floats.keySet()) Defaults.get(Class("Float")).put(i, floats.get(i));
  
  doubles.put("PreviewZoomDepth",4D);
  doubles.put("ZoomDepth",1.5D);
  doubles.put("ZoomCenterX",0D);
  doubles.put("ZoomCenterY",0D);
  doubles.put("MandelCenterX",0D);
  doubles.put("MandelCenterY",0D);
  doubles.put("JuliaCenterX",-0.765D);
  doubles.put("JuliaCenterY",-0.085D);
  doubles.put("SamplePixelX",0D);
  doubles.put("SamplePixelY",0D);
  
  Defaults.put(Class("Double"), new HashMap<String,Object>());
  for(String i : doubles.keySet()) Defaults.get(Class("Double")).put(i, doubles.get(i));
  
  bools.put("JuliaMode",false);
  bools.put("IsPowerRepeat",true);
  bools.put("MandelbarMode",false);
  bools.put("showJuliaPreview",false);
  bools.put("TestMousePos",true);
  bools.put("SamplePixel",false);
  bools.put("inverseColoring",false);
  bools.put("inverseColorNotInSet",false);
  bools.put("smoothColoring", false);
  bools.put("DEM", false);
  
  Defaults.put(Class("Boolean"), new HashMap<String,Object>());
  for(String i: bools.keySet()) Defaults.get(Class("Boolean")).put(i, bools.get(i));
  
  
  strings.put("textToSave","");
  
  ArrayList<Float> t = new ArrayList<Float>();
  t.add(1f);
  arrays.put("MultiplierList",(ArrayList<Float>)t.clone());
  t.set(0,2f);
  arrays.put("PowerList",(ArrayList<Float>)t.clone());
  
  Defaults.put(t.getClass(),new HashMap<String,Object>());
  for(String i : arrays.keySet()){
    FloatList fl = new FloatList();
    for(float j : arrays.get(i)){
      fl.append(j);
    }
    Defaults.get(t.getClass()).put(i, fl);
  }
}

Class Class(String s){
  try{
    return Class.forName("java.lang." + s);
  }catch(ClassNotFoundException e){
    e.printStackTrace();
    return null;
  }
}
