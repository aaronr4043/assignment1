/* Assignment due 07/12 
Have menu to select differant graphs
Option to change between views and subs
*/
ArrayList<Stats> subscribers = new ArrayList<Stats>();

void setup()
{
  size(500, 500);
  background(0);
  stroke(255);
  
  String [] lines = loadStrings("achievementhunter.csv");
  
  for(int i=0; i< lines.length; i++)
  {
     Stats subscriber = new Stats(lines[i]);
     subscribers.add(subscriber);
  }
}

void draw()
{
  
}

