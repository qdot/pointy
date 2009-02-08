/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
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

float xPosition;
float yPosition;
float zPosition;
float yrot;
float xLookAt;
float yLookAt;
float zLookAt;

void camSetup()
{
  //Since we translated the cloud to the origin, just back off the origin for the initial camera position
 xPosition = width/2;
 yPosition = height/2;
 zPosition = 20.0;
 yrot = 180.;
 xLookAt = 0;
 yLookAt = 0;
 zLookAt = -1;
}

void cam()
{
   camera(xPosition, yPosition, zPosition, xPosition + xLookAt, yPosition, zPosition + zLookAt, 0, 1., 0);  
}

void center(){
  translate(width/2, height/2);  
}

void keyPressed(){
  if(keyCode == RIGHT || key == 'd'){
      yrot -= 0.5f;
      xLookAt = (float)sin(radians(yrot));
      zLookAt = (float)cos(radians(yrot));
  }
  if(keyCode == LEFT || key == 'a'){
    yrot += 0.5;
     xLookAt = (float)sin(radians(yrot));
      zLookAt = (float)cos(radians(yrot));
  }
  if(keyCode == DOWN || key == 's'){
    xPosition -= (float)sin(radians(yrot)) * 0.5f;			// Move On The X-Plane Based On Player Direction
    zPosition -= (float)cos(radians(yrot)) * 0.5f;			// Move On The Z-Plane Based On Player Direction
  }
  if(keyCode == UP || key == 'w'){
     xPosition += (float)sin(radians(yrot)) * 0.5f;			// Move On The X-Plane Based On Player Direction
	zPosition += (float)cos(radians(yrot)) * 0.5f;			// Move On The Z-Plane Based On Player Direction
  }
  if(key == 'e')
  {
    yPosition -= .3;
  }
  if(key == 'c')
  {
    yPosition += .3;
  }
}
