class Stats
{
  float subs;
  float totalsubs;
  String date;
  String day;
  float views;
  float totalviews;
   
  Stats(String lines)
  {
    String[] parts = lines.split(";");
    subs = Float.parseFloat(parts[0]);
    totalsubs = Float.parseFloat(parts[1]);
    date = parts[2];
    day = parts[3];
    views = Float.parseFloat(parts[4]);
    totalviews = Float.parseFloat(parts[5]);
    
  }  
}
