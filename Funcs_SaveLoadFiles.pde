import java.io.*;
/* Loads a Named Set */
void loadSet(String setName){ // loads a set.
  HashMap<String,Object> SetMap = (HashMap<String,Object>)ReadObjectFromFile("savedSets.hd.txt");
  HashMap<String,Object> TypeMap = (HashMap<String,Object>)SetMap.get(setName);
  
  HashMap<String,Integer> intsI = (HashMap<String,Integer>)TypeMap.get("ints");
  for(String k : ints.keySet()){
    if(!intsI.containsKey(k)){
      if(Defaults.get(Class("Integer")).containsKey(k)){
        intsI.put(k, (Integer)Defaults.get(Class("Integer")).get(k));
      }else{
        k = "";
      }
    }
    if(!k.equals("")){
      ints.put(k,intsI.get(k));
    }
  }
  
  HashMap<String,Float> floatsI = (HashMap<String,Float>)TypeMap.get("floats");
  for(String k : floats.keySet()){
    if(!floatsI.containsKey(k)){
      if(Defaults.get(Class("Float")).containsKey(k)){
        floatsI.put(k, (Float)Defaults.get(Class("Float")).get(k));
      }else{
        k = "";
      }
    }
    if(!k.equals("")){
      floats.put(k,floatsI.get(k));
    }
  }
  
  HashMap<String,Double> doublesI = (HashMap<String,Double>)TypeMap.get("doubles");
  for(String k : doubles.keySet()){
    if(!doublesI.containsKey(k)){
      if(Defaults.get(Class("Double")).containsKey(k)){
        doublesI.put(k, (Double)Defaults.get(Class("Double")).get(k));
      }else{
        k = "";
      }
    }
    if(!k.equals("")){
      doubles.put(k,doublesI.get(k));
    }
  }
  
  HashMap<String,Boolean> boolsI = (HashMap<String,Boolean>)TypeMap.get("bools");
  for(String k : bools.keySet()){
    if(!boolsI.containsKey(k)){
      if(Defaults.get(Class("Boolean")).containsKey(k)){
        boolsI.put(k, (Boolean)Defaults.get(Class("Boolean")).get(k));
      }else{
        k = "";
      }
    }
    if(!k.equals("")){
      bools.put(k,boolsI.get(k));
    }
  }
  
  HashMap<String,ArrayList<Float>> arraysI = (HashMap<String,ArrayList<Float>>)TypeMap.get("arrays");
  for(String k : arrays.keySet()){
    if(!arraysI.containsKey(k)){
      if(Defaults.get(new ArrayList<Float>().getClass()).containsKey(k)){
        arraysI.put(k, (ArrayList<Float>)Defaults.get(new ArrayList<Float>().getClass()).get(k));
      }else{
        k="";
      }
    }
    if(!k.equals("")){
      arrays.put(k, arraysI.get(k));
    }
  }
  
  DumpObjectToFile(SetMap, "savedSets.hd.txt"); 
  canDraw = true;
}

/* Gets a list of all set names in the file */
String[] getSetNamesFromFile(){ // list of saved file names
  HashMap<String,Object> SetMap = (HashMap<String,Object>)ReadObjectFromFile("savedSets.hd.txt");
  if(SetMap == null) SetMap = new HashMap<String,Object>();
  Set<String> keys = SetMap.keySet();
  return(keys.toArray(new String[keys.size()]));
}

/* Writes the current set to file */
void writeToFile(String setName){ // writes
  HashMap<String,Object> SetMap = (HashMap<String,Object>)ReadObjectFromFile("savedSets.hd.txt");
  
  HashMap<String,Object> SaveData = new HashMap<String,Object>();
  SaveData.put("bools",bools);
  SaveData.put("ints",ints);
  SaveData.put("floats",floats);
  SaveData.put("doubles",doubles);
  SaveData.put("arrays",arrays);
  
  SetMap.put(setName,SaveData);
  
  DumpObjectToFile(SetMap, "savedSets.hd.txt");
}

/* Attempts to delete a named set from the file */
/* Returns whether anything was deleted */
boolean tryToDeleteFromFile(String setName){
  HashMap<String,Object> SetMap = (HashMap<String,Object>)ReadObjectFromFile("savedSets.hd.txt");
  if(SetMap.containsKey(setName)){
    SetMap.remove(setName);
    DumpObjectToFile(SetMap,"savedSets.hd.txt");
    return true;
  }
  else return false;
}

Object ReadObjectFromFile(String fileName){
  /* Note: you will need to cast from Object to the type the data represents.
  ** Also the file must be a hex dump file or you will get errors
  ** Also adds the .hd.txt file extension if no extension is given
  */
  if(fileName.equals(null)) fileName = "savedSets.hd.txt";
  BufferedReader r = createReader(fileName + (fileName.contains(".") ? "" : ".hd.txt"));
  String line;
  try{
    while((line=r.readLine())!= null){
      Object obj = ReadHexDump(line);
      if (obj == null) return new HashMap<String,Object>();
      else return obj;
    }
  } catch(IOException e){
    e.printStackTrace();
  }
  return null;
}

void DumpObjectToFile(Object o, String... filenames){
  /* WARNING: DELETES ALL TEXT CURRENTLY IN FILE
  ** Make sure to call ReadObjectFromFile to store what is currently present
  ** Also adds the .hd.txt file extension if no extension is given
  */
  String[] files = filenames.length>0 ? filenames : new String[]{"savedSets.hd.txt"};
  String hexDump = WriteHexDump(o);
  PrintWriter w;
  
  for(String fileName : files){
    w = createWriter(fileName + (fileName.contains(".") ? "" : ".hd.txt"));
    w.print(hexDump);
    w.flush();
    w.close();
  }
}

String WriteHexDump(Object o){
  ByteArrayOutputStream bos = new ByteArrayOutputStream();
  ObjectOutputStream out = null;
  byte[] byteArray;
  try {
    out = new ObjectOutputStream(bos);   
    out.writeObject(o);
    out.flush();
    byteArray = bos.toByteArray();
  } catch(IOException e){
    e.printStackTrace();
    return(null);
  } finally {
    try {
      bos.close();
    } catch (IOException ex) {
      //
    }
  }
  
  String out2 = "";
  for(byte b : byteArray){
    out2 += String.format("%02X",b);
  }
  return(out2);
}

Object ReadHexDump(String s){
  int len = s.length();
  byte[] data = new byte[len / 2];
  for (int i = 0; i < len; i += 2) {
      data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                           + Character.digit(s.charAt(i+1), 16));
  }
  
  ByteArrayInputStream bis = new ByteArrayInputStream(data);
  ObjectInput in = null;
  try {
    in = new ObjectInputStream(bis);
    Object o = in.readObject(); 
    return o;
  } catch (IOException e) {
    //e.printStackTrace();
    return null;
  } catch (ClassNotFoundException e){
    e.printStackTrace();
    return null;
  } finally {
    try {
      if (in != null) {
        in.close();
      }
    } catch (IOException e) {
      // ignore close exception
    }
  }
}
