class Rotation
{
  float rotation ;
  float angle  ;
  
  Rotation () { }
  
  void actualisation (float cX, float cY, float vR)
  {
    rotation += vR ;
    if ( rotation > 360 ) { rotation = 0 ; }
    float angle = rotation ;
    miroir.translate (cX, cY) ;
    miroir.rotate (radians(angle) ) ;
  }
}  

class Spirale extends Rotation 
{  
  
  Spirale () 
  {
  super () ;
  }
  void affichage (int n, int nMax, float h, float l, float z, color cIn, color cOut, float e, int mode) 
  {
    n = n-1 ;
    int puissance = nMax-n ;
    float ap = pow (z,puissance) ;
    
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) miroir.noFill() ; else miroir.fill (cIn) ;
    if ( alphaOut == 0) {
      miroir.noStroke() ;
    } else {
      miroir.stroke ( cOut ) ; 
      if( e < 0.1 ) e = 0.1 ; //security for the negative value
      miroir.strokeWeight ( e / ap) ;
    }
    
    //display Mode
    if (mode == 0 )      miroir.rect (0,0, h, l ) ;
    else if (mode == 1 ) miroir.ellipse (0,0,h,l) ;
    
    miroir.translate (2,0 ) ;
    miroir.rotate ( PI/6 ) ;
    miroir.scale(z) ; 

    if ( n > 0) { affichage (n, nMax, h, l, z, cIn, cOut, e, mode ) ; }
  }
  
  void affichageBezier (color cIn, color cOut, PVector pos, float e, int z, float b1, float b2, float b3, float b4, float b5, float b6, float b7, float b8)
  {
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) miroir.noFill() ; else miroir.fill (cIn) ;
    if ( alphaOut == 0) {
      miroir.noStroke() ;
    } else {
      miroir.stroke ( cOut ) ; 
      if( e < 0.1 ) e = 0.1 ; //security for the negative value
      miroir.strokeWeight (e) ;
    }
    /*
    float zy = map (z, 0, 101, 0, height/2) ;
    float posYH = height / 2 - zy ;
    float posYB = height / 2 + zy ;
    float posXG = -zy ;
    float posXD = width + zy ;
    */
    float zy = map (z, 0, 101, 0, pos.y/2) ;
    float posYH = pos.x / 2 - zy ;
    float posYB = pos.y / 2 + zy ;
    float posXG = -zy ;
    float posXD = pos.x + zy ;
    miroir.beginShape();
    miroir.vertex(posXG, 0);
    miroir.bezierVertex(b1, b2, b3, b4,
                posXD, 0 );  
    miroir.bezierVertex(b5, b6, b7, b8,  
                posXG, 0);
    miroir.endShape();
    miroir.noStroke() ;
  }
  
  //DIFFERENT DISPLAY MODE
  void baliseDisc (color cIn, color cOut, float e, float amp, float varx, float vary, PVector sizeBalise, int max )
  {
    pushMatrix() ;
    miroir.rectMode(CENTER) ;
    
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector inputResult = new PVector ( (input.left.get(i)*varx), (input.right.get(i)*vary) ) ;
      PVector posBalise = new PVector ( amp * inputResult.x, amp * inputResult.y ) ;
      //check the opacity of color
      int alphaIn = (cIn >> 24) & 0xFF; 
      int alphaOut = (cOut >> 24) & 0xFF; 
      // to display or not
      if ( alphaIn == 0 ) miroir.noFill() ; else miroir.fill (cIn) ;
      if ( alphaOut == 0) {
        miroir.noStroke() ;
      } else {
        miroir.stroke ( cOut ) ; 
        if( e < 0.1 ) e = 0.1 ; //security for the negative value
        miroir.strokeWeight (e) ;
      }
      miroir.ellipse(posBalise.x, posBalise.y, sizeBalise.x *abs(inputResult.x*50), sizeBalise.y * abs(inputResult.y*50) ) ;
    }
    miroir.rectMode(CORNER) ;
    popMatrix() ;
    miroir.noStroke() ;
  }
  
    void baliseRect (color cIn, color cOut, float e, float amp, float varx, float vary, PVector sizeBalise, int max )
  {
    pushMatrix() ;
    miroir.rectMode(CENTER) ;
    
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector inputResult = new PVector ( (input.left.get(i)*varx), (input.right.get(i)*vary) ) ;
      PVector posBalise = new PVector ( amp * inputResult.x, amp * inputResult.y ) ;
      //check the opacity of color
      int alphaIn = (cIn >> 24) & 0xFF; 
      int alphaOut = (cOut >> 24) & 0xFF; 
      // to display or not
      if ( alphaIn == 0 ) miroir.noFill() ; else miroir.fill (cIn) ;
      if ( alphaOut == 0) {
        miroir.noStroke() ;
      } else {
        miroir.stroke ( cOut ) ; 
        if( e < 0.1 ) e = 0.1 ; //security for the negative value
        miroir.strokeWeight (e) ;
      }
      miroir.rect(posBalise.x, posBalise.y, sizeBalise.x *abs(inputResult.x*50), sizeBalise.y * abs(inputResult.y*50) ) ;
    }
    miroir.rectMode(CORNER) ;
    popMatrix() ;
    miroir.noStroke() ;
  }
}
