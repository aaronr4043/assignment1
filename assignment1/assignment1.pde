/* Assignment due 07/12 
Have menu to select differant graphs
Option to change between views and subs
*/
ArrayList<Stats> subscribers = new ArrayList<Stats>();
ArrayList<Stats> views = new ArrayList<Stats>();


//Delcaring my gloabal Variables
float average = 0;
float windowRange = 0;
float dataRange = 0;
float point1[];
int i = 0;
float border = width*0.5f;
float min = 1000000;
float max = 0;
float temp = 0;
float scale = 0;
boolean orbits;
float rot = 0.0f;
float offset = 0.0f; 
float bigradius = 1;

void setup()
{
  background(0);
  orbits = false;
  fill(0, 120, 120);
  rect(0, 0, width/2, 20);
  fill(0, 200, 200);
  rect(width/2, 0, width, 20);
  
  size(1000, 650);
  stroke(255);
  
  loadStats();  
}

//Gets called when the mouse is pressed, checks where the mouse is and if the mouse is in the right area it will call a function
void mousePressed() 
{
  if(mouseY<height*0.03f)
  {
    orbits = false;
    
    if(mouseX>0 && mouseX<width/4)
    {
      drawLineGraphSubs(); // Draws the line graph showing subscribers per day
    }
  
    if(mouseX>=width/4 && mouseX<width/2)
    {
      drawLineGraphViews(); // Draws the line graph showing views per day
    }
  
    if(mouseX<=(width/4)*3 && mouseX>width/2)
    {
      drawScatterplot(subscribers); // Draws the scatterplot useing Views and Subscribers
    }
    
    if(mouseX>=(width/4)*3 && mouseX<width)
    {
      orbits = true; // Since I want Orbits to animate I had to allow it to run in draw using a boolean variable
    }
  }
}

void draw()
{
  if(orbits == true)
  {
    background(0);
    float cx = width/2; //Finds the centre points
    float cy = height/2;
    float smallradius = 2;
    float min2 = 1000000; // Sets min and max to values where they will get 
    float max2 = 0;
    
    for (int i = 0 ; i < views.size() ; i ++) // Finding max and min values for views
    {
      float temp = views.get(i).viewings;
      if(min > temp)
      {
        min = temp;
      }
      
      if(max < temp)
      {
        max = temp;
      }
    }
    
    for (int i = 0 ; i < subscribers.size() ; i ++) // Finding max and min values for Subscribers
    {
      temp = subscribers.get(i).subs;
      if(min2 > temp)
      {
        min2 = temp;
      }
    
      if(max2 < temp)
      {
        max2 = temp;
      }
    }
    
    for(int i = 0; i<subscribers.size(); i++) // This draws the points as if they were planets orbiting a centre point
    {
      offset += 0.000009f; // Sets the speed the 
      rot += TWO_PI/subscribers.size();
      
      for(float theta = 0; theta < TWO_PI; theta += TWO_PI)
      { 
        bigradius = map(views.get(i).viewings, min, max, 20, 250);
        smallradius = map(subscribers.get(i).subs, min2, max2, 0, 20);
        
        float x = cx + sin(theta + offset + rot) * bigradius; 
        float y = cy -cos(theta + offset + rot) * bigradius;
        fill(67, 179, 61);
        stroke(67, 179, 61);
        
        ellipse(x, y, smallradius, smallradius);
      }
    }
    rot = 0;
    
    //Draws the circles showing how many views things are orbiting at
    noFill();
    stroke(255, 255, 255, 40);
    ellipse(cx, cy, 40, 40);
    textAlign(CENTER);
    fill(255);
    noFill();
    text(floor(min), cx, cy-20);
    
    bigradius = map(max, min, max, 20, 250);
    ellipse(cx, cy, bigradius, bigradius);
    text(floor(max/2), cx, cy-(bigradius/2));
    
    bigradius = map(max, min, max, 20, 250);
    ellipse(cx, cy, bigradius*2, bigradius*2);
    text(floor(max), cx, cy-bigradius);
    
    stroke(67, 179, 61);
    ellipse(width*0.1f, height*0.1f, 30, 30);
    text("Views", (width*0.1f)-35, height*0.1f);
    
    fill(255);
    stroke(255);
    ellipse(width*0.1f, height*0.15f, 30, 30);
    text("Subs", (width*0.1f)-35, height*0.15f);
  }
  
  
  //Draws the Menu - Runs all the time
  fill(0, 51, 204);
  rect(0, 0, width/4, height*0.03);
  fill(71, 117, 255);
  rect(width/4, 0, (width/4)*2, height*0.03);
  fill(133, 163, 255);
  rect((width/4)*2, 0, (width/4)*3, height*0.03);
  fill(133, 224, 255);
  rect((width/4)*3, 0,(width/4)*4, height*0.03);
  
  //Labels the Menu - Runs all the time
  textAlign(CENTER);
  fill(255);
  textSize(10);
  text("Subscribers Line Graph", width*0.125, height*0.023);
  text("Video Views Line Graph", width*0.375, height*0.023);
  text("Scatterplot Diagram", width*0.625, height*0.023);
  text("My Orbiting Thing", width*0.875, height*0.023);
}

void loadStats() // The function for loading in all the Data
{
  String[] lines = loadStrings("achievementhunter.csv");

  for (int i = 0 ; i < lines.length ; i ++)
  {
    Stats subscriber = new Stats(lines[i]);
    subscribers.add(subscriber);
  }
  
  for (int i = 0 ; i < lines.length ; i ++)
  {
    Stats view = new Stats(lines[i]);
    views.add(view);
  }
}

void drawLineGraphSubs() // The Function for drawing the Subscriber line graph
{
  background(0); //Draws the border
  stroke(255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border + 5);
  min = 1000000;
  max = 0;
  average = 0;
  
  textAlign(CENTER); // Tells you what graph you are looking at
  fill(255);
  textSize(14);
  text("Subscribers Gained Per Day", width/2, height*0.1);
  
  for (int i = 0 ; i < subscribers.size() ; i ++) // Find the mininum, maxinum and average values for Subscribers 
  {
    temp = subscribers.get(i).subs;
    if(min > temp)
    {
      min = temp;
    }
    
    if(max < temp)
    {
      max = temp;
    }
    
    average += temp;
  }
 
  //Drawing the line showing the average Subscribers Gained per day
  average = average / subscribers.size();
  println(average);
  temp = map(average, min, max, height-border, border);
  stroke(139, 101, 215, 40);
  fill(255);
  line(border, temp, width-border, temp);
  textSize(14);
  textAlign(RIGHT);
  text("Average = ", width/2, temp);
  textAlign(LEFT);
  text(floor(average), width/2, temp);
  
  //Drawing the actual line graph
  
  for (int i = 1 ; i < subscribers.size() ; i ++)
  {
    stroke(0, 255, 255);
    float x1 = map(i - 1, 0, subscribers.size() - 1, border, width - border);
    float y1 = map(subscribers.get(i - 1).subs, min, max, height - border, border);
    float x2 = map(i, 0, subscribers.size() - 1, border, width - border);
    float y2 = map(subscribers.get(i).subs, min, max, height - border, border);
    line(x1, y1, x2, y2);
  }  
  
  stroke(255);
  textSize(8);
  
  scale = max/4;
  textAlign(RIGHT);
  
  for(int i=0; i<5; i++) // Labels the y axis
  {
    temp = map(i, 0, 4, height-border, border);
    line(border, temp, border-5, temp);
    text(floor(scale*i), border-3, temp-3);
  }
  
  scale = subscribers.size()/4.0;
  textAlign(CENTER);
  
  for(int i=0; i<5; i++) // labels the x axis
  {
    temp = map(i, 0, 4, border, width-border);
    line(temp, height-border+5, temp, height-border);
    text(scale*i, temp, (height+13) - border);
  }
}

void drawLineGraphViews() // Function for drawing the views line graph
{
  background(0); 
  stroke(255);  
  line(border - 5, height - border, width - border, height - border); // Draws the border
  line(border, border, border, height - border + 5);
  min = 1000000;
  max = 0;
  average = 0;
  
  textAlign(CENTER); // Gives the name of the graph
  fill(255);
  textSize(14);
  text("Video Views Per Day", width/2, height*0.1);
  
  for (int i = 0 ; i < views.size() ; i ++) // Finds the mininum, maxinum and average values for Views
  {
    float temp = views.get(i).viewings;
    if(min > temp)
    {
      min = temp;
    }
    
    if(max < temp)
    {
      max = temp;
    }
    
    average += temp;
  }
  
  //Drawing the line showing average views
  average = average / subscribers.size();
  println(average);
  temp = map(average, min, max, height-border, border);
  stroke(139, 101, 215, 40);
  fill(255);
  line(border, temp, width-border, temp);
  textSize(14);
  textAlign(RIGHT);
  text("Average =", width/2, temp);
  textAlign(LEFT);
  text(floor(average), width/2, temp);
  
  //Drawing the actual Line Graph
  for (int i = 1 ; i < views.size() ; i ++)
  {
    stroke(0, 255, 255);
    float x1 = map(i - 1, 0, views.size() - 1, border, width - border);
    float y1 = map(views.get(i - 1).viewings, min, max, height - border, border);
    float x2 = map(i, 0, views.size() - 1, border, width - border);
    float y2 = map(views.get(i).viewings, min, max, height - border, border);
    line(x1, y1, x2, y2);
  }  
  
  stroke(255);
  textSize(8);
  
  scale = max/4;
  textAlign(RIGHT);
  
  for(int i=0; i<5; i++) // Labels the y axis
  {
    temp = map(i, 0, 4, height-border, border);
    line(border, temp, border-5, temp);
    text(floor(scale*i), border-3, temp-3);
  }
  
  scale = subscribers.size()/4.0;
  textAlign(CENTER);
  
  for(int i=0; i<5; i++)// labels the x axis
  {
    temp = map(i, 0, 4, border, width-border);
    line(temp, height-border+5, temp, height-border);
    text(scale*i, temp, (height+13) - border);
  }
  
}

void drawScatterplot(ArrayList<Stats> data) // Function for drawing the scatterplot
{
  background(0); 
  stroke(255);  
  line(border - 5, height - border, width - border, height - border); // Draws the borders
  line(border, border, border, height - border + 5);
  min = 1000000;
  max = 0;
  float min2 = 1000000;
  float max2 = 0;
  average = 0;
  
  textAlign(CENTER);
  fill(255);
  textSize(14);
  text("Scatterplot Diagram", width/2, height*0.1); // Gives the name of the diagram
  
  for (int i = 0 ; i < subscribers.size() ; i ++) // Finds maxinumn, mininum and average values for Subscribers
  {
    temp = subscribers.get(i).subs;
    if(min > temp)
    {
      min = temp;
    }
    
    if(max < temp)
    {
      max = temp;
    }
  }
  
  for (int i = 0 ; i < views.size() ; i ++) // Finds maxinum, mininum and average values for Views 
  {
    temp = views.get(i).viewings;
    if(min2 > temp)
    {
      min2 = temp;
    }
    
    if(max2 < temp)
    {
      max2 = temp;
    }
  }
  
  // Plots all the points
  
  for (int i = 0 ; i < subscribers.size() ; i ++)
  {
    stroke(0, 255, 255);
    float x1 = map(views.get(i).viewings, 0, max2, border, width - border);
    float y1 = map(subscribers.get(i).subs, 0, max, height - border, border);
    fill(0, 255, 255);
    ellipse(x1, y1, 2, 2);
  }  
  
  stroke(255);
  textSize(8);
  
  scale = max/6;
  textAlign(RIGHT);
  
  for(int i=0; i<6; i++) //labels the y axis
  {
    temp = map(i, 0, 5, height-border, border);
    line(border, temp, border-5, temp);
    text(floor(scale*i), border-3, temp-3);
  }
  
  scale = max2/4;
  textAlign(CENTER);
  
  for(int i=0; i<5; i++) // Labels the x axis
  {
    temp = map(i, 0, 4, border, width-border);
    line(temp, height-border+5, temp, height-border);
    text(floor(scale*i), temp, (height+13) - border);
  }
}