/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 *
 *   Simple Radiohead Scene Viewer
 *  
 *   by Aaron Koblin
 *
 *   Modified by Kyle Machulis for FC Point Cloud Viewing
 *   http://www.nonpolynomial.com
 *
 *   To use-
 *      -download, extract, and open Processing Development Environment (www.processing.org)
 *      -make sure SceneViewer.pde, Control.pde, and PointCloud.pde are in a folder called "SceneViewer" 
 *      -open SceneViewer.pde in Processing 
 *      -check the box next to "set maximum available memory to" and make sure the value is at least 256
 *      -press ok
 *      -press play and load one of the files you downloaded from the FC PointCloud site.
 *
 *   UP and DOWN Arrows control zoom.
 *
 *  Copyright 2008 Aaron Koblin 
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at 
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 *
 *//////////////////////////////////////////////////////////////

import processing.opengl.*;

//VARIABLES YOU CAN PLAY WITH

//The name of the point cloud
//This file should be in the "data" directory of the SceneViewer sketch
String point_cloud_filename = "fcrun1.csv";

//The RGBI components of the point cloud renderer
int red_component = 0;
int green_component = 50;
int blue_component = 150;
int alpha_component = 150;


/********* DON'T TOUCH ANYTHING AFTER THIS UNLESS YOU'RE LIKE, INTO PROGRAMMING, AND STUFF **************/

VBPointCloud cloud;

//Since I was lazy about how I cut the appropriate portions out of the clouds, we 
//translate the starting point in the cloud to be the origin
float startX = 0.;
float startY = 0.;
float startZ = 0.;

boolean started = false;

float fov = PI/3.0;
float cameraZ = (height/2.0) / tan(PI * fov / 360.0);

void setup(){
  size(1024,768, OPENGL);
  //Can't set up the camera until we know the size of the screen
  camSetup();
  cloud = new VBPointCloud(this);
  
  cloud.loadFloats(loadPoints(point_cloud_filename));
  //cloud.loadFloats(loadPoints("fcrun2.csv"));
}

void draw(){
  background(0);
  //reset our perspective per draw. God knows what processing is doing with it otherwise
  perspective(fov, float(width)/float(height), 
            0.0001, cameraZ*10.0);

  //Recenter, since screen coordinates matter. I HATE PROCESSING.
  center();
  //Sets the color for the points. Honestly, I have no idea what this is doing.
  stroke(red_component,green_component,blue_component,alpha_component);
  //Draw the cloud
  cloud.draw();
  //Reset the camera based on the user input
  cam();
}

float[] loadPoints(String path) {
    int i = 0;
  BufferedReader r = createReader(path);
  try{
    while(r.readLine() != null) ++i;
  }
  catch(IOException ex)
  {
    println("What the hell do I do with an exception in processing?");
    return null;
  }
  println("Points to load: " + i);
  r = createReader(path);
  float[] points = new float[i * 3];
  //colors = new float[raw.length*4];
    String line;
  try{
    line = r.readLine();
  }
  catch(IOException ex)
  {
    println("What the hell do I do with an exception in processing?");
    return null;
  }
  String[] thisLine;
  int line_index = 0;
  while(line != null)
  {
    thisLine = split(line, ",");
    if(!started)
    {
      started =true;
      startX = new Float(thisLine[0]).floatValue() / -1000;
      startY = new Float(thisLine[2]).floatValue() / -1000;    
      startZ = new Float(thisLine[1]).floatValue() / 1000;    
    }
    points[line_index * 3] = (new Float(thisLine[0]).floatValue() / -1000) - startX;
    points[line_index * 3 + 1] = (new Float(thisLine[2]).floatValue() / -1000) - startY;
    points[line_index * 3 + 2] = (new Float(thisLine[1]).floatValue() / 1000) - startZ;
    ++line_index;
    //colors[i*4] = new Float(thisLine[3]).floatValue()/3f ;
    //colors[i*4+1] = new Float(thisLine[3]).floatValue()/3f ;
    //colors[i*4+2] = 0f ;
    //colors[i*4+3] = 100f ;
  try{
    line = r.readLine();
  }
  catch(IOException ex)
  {
    println("What the hell do I do with an exception in processing?");
    return null;
  }
  }
  println("Loaded: "+i+" points");
  return points;
}


