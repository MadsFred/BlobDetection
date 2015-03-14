import processing.core.PApplet;
import blobDetection.BlobDetection;
import processing.video.*; 
import blobDetection.*;

Capture cam;
BlobDetection theBlobDetection;

public void setup() {

  size(640, 480);
  cam = new Capture(this, 640, 480);
  cam.start();
  theBlobDetection=new BlobDetection(cam.width, cam.height); 
  theBlobDetection.setThreshold(0.6f); // Threshold for blob detectiion
}

void captureEvent(Capture cam) {
  cam.read();
}

public void draw() {

  cam.loadPixels();
  image(cam, 0, 0, width, height); 
  theBlobDetection.computeBlobs(cam.pixels); 
  drawEdges();
}

void drawEdges() { 
  strokeWeight(3); 
  stroke(0, 255, 0); 
  Blob b;
  EdgeVertex eA, eB;
  for (int n=0; n<theBlobDetection.getBlobNb (); n++) {
    b=theBlobDetection.getBlob(n); 
    if (b!=null) {
      for (int m=0; m<b.getEdgeNb (); m++) { 
        eA = b.getEdgeVertexA(m);
        eB = b.getEdgeVertexB(m);
        if (eA !=null && eB !=null)
          line( eA.x*width, eA.y*height, eB.x*width, eB.y*height );
      }
    }
  }
}

