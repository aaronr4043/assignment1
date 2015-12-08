class Stats
{
  float subs;
  float totalsubs;
  String date;
  String day;
  float viewings;
  float totalviews;
   
  Stats(String lines)
  {
    String[] parts = lines.split(";"); //Despite being saved as a .csv excel decided to stick in semi colons
    subs = Float.parseFloat(parts[0]);
    totalsubs = Float.parseFloat(parts[1]);
    date = parts[2];
    day = parts[3];
    viewings = Float.parseFloat(parts[4]);
    totalviews = Float.parseFloat(parts[5]);  
  }  
}