//Grupo 16
//Integrantes: Vitor Wunsch, Lara Granco Chaves Vidal, Larissa Britney Grinstein, Lucca.

import peasy.*;
import processing.sound.*;

PeasyCam camera;

float[] rotations = new float[3];

SoundFile song;
BeatDetector beatDetector;
FFT fft;

String[] songs = {"19th Floor - Bobby Richards.mp3","Electro Fight - Kwon.mp3", "Average - Patrick Patrikios.mp3", "Blind Memories - Cheel.mp3", "Away - Patrick Patrikios.mp3"};

int bands = 64;

PImage scenario;

float i;

float smoothingFactor = 0.2;

float[] vertex = new float[8];

float[] sum = new float[bands];

int rangeBandsAverage = bands/vertex.length;

float bandsSum;

float bandsAverage;

void setup() {
  size(1920, 1080, P3D);
  
  camera = new PeasyCam(this, 927);
  camera.setCenterDragHandler(null);
  camera.setRightDragHandler(null);
  camera.setWheelHandler(null);
  
  
  scenario = loadImage("art_4.png");
  
  song = new SoundFile(this, songs[(int) random(songs.length)]);
  song.loop();
  
  fft = new FFT(this, bands);
  fft.input(song);
  

}

void draw() {
  
  camera.beginHUD();
  
  image(scenario, 0, 0, 1920, 1080);
  
  camera.endHUD();
  
  fft.analyze();
  
  for (int i = 0; i < bands; i++) {
    
    sum[i] += (fft.spectrum[i] - sum[i]) * smoothingFactor;
  
  }
  
  for (int i = 0; i < vertex.length; i++) {
    
     for (int j = (rangeBandsAverage * i); j < rangeBandsAverage * (i + 1); j++) {
       
       bandsSum += sum[j];
       
     }
     
     bandsAverage = bandsSum/rangeBandsAverage;
     
     vertex[i] = (bandsAverage * 1000) + 75;
     
     bandsSum = 0;

  }
  
  
  strokeWeight(5);
  stroke((vertex[0] + vertex[1] + vertex[2] - 225) * 0.8, (vertex[5] + vertex[6] + vertex[7] - 225) * 11, (vertex[3] + vertex[4] - 150) * 9);
  
  rotateX(0.3);
  rotateY(i);
  fill(255);
  
  beginShape();
    
    //leftDownFront
    vertex(-vertex[3], vertex[3], vertex[3]);
  
    //leftUpFront
    vertex(-vertex[4], -vertex[4], vertex[4]);
  
    //rightUpFront
    vertex(vertex[0], -vertex[0], vertex[0]);
    
    //rightDownFront
    vertex(vertex[6], vertex[6], vertex[6]);
  endShape();
  
  beginShape();
  
    //leftDownFront
    vertex(-vertex[3], vertex[3], vertex[3]);
  
    //rightDownFront
    vertex(vertex[6], vertex[6], vertex[6]);
  
    //rightDownBack
    vertex(vertex[1], vertex[1], -vertex[1]);
  
    //leftDownBack
    vertex(-vertex[5], vertex[5], -vertex[5]);
  endShape();
  
  beginShape();
  
    //leftDownBack
    vertex(-vertex[5], vertex[5], -vertex[5]);
  
    //leftDownFront
    vertex(-vertex[3], vertex[3], vertex[3]);
  
    //leftUpFront
    vertex(-vertex[4], -vertex[4], vertex[4]);
  
    //leftUpBack
    vertex(-vertex[2], -vertex[2], -vertex[2]);
  endShape();
  
  beginShape();
    
    //rightDownBack
    vertex(vertex[1], vertex[1], -vertex[1]);
  
    //leftDownBack
    vertex(-vertex[5], vertex[5], -vertex[5]);
  
    //leftUpBack
    vertex(-vertex[2], -vertex[2], -vertex[2]);
  
    //rightUpBack
    vertex(vertex[7], -vertex[7], -vertex[7]);
  endShape();
  
  beginShape();
  
    //rightUpBack
    vertex(vertex[7], -vertex[7], -vertex[7]);
  
    //rightDownBack
    vertex(vertex[1], vertex[1], -vertex[1]);
  
    //rightDownFront
    vertex(vertex[6], vertex[6], vertex[6]);
  
    //rightUpFront
    vertex(vertex[0], -vertex[0], vertex[0]);
  endShape();
  
  beginShape();
  
    //rightUpFront
    vertex(vertex[0], -vertex[0], vertex[0]);
  
    //rightUpBack
    vertex(vertex[7], -vertex[7], -vertex[7]);
  
    //leftUpBack
    vertex(-vertex[2], -vertex[2], -vertex[2]);
  
    //leftUpFront
    vertex(-vertex[4], -vertex[4], vertex[4]);
  
    //rightUpFront
    vertex(vertex[0], -vertex[0], vertex[0]);
  endShape();
  
  if(!(mouseButton == LEFT)){
    if(i >= (PI*2)){
      i = 0;
    }
    else {
      i += 0.02;
    }
  }
  
}
