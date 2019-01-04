$fa=1;
$fs=0.2;

centralPlateLength = 12.8;
centralPlateWidth = 8.7;

crossHoleLength= 7.5;
crossHoleWidth=  3.5;
crossHoleClipGapDepth=  1.3 ;
crossHoleClipGapLength= 3.5 ;

yBarWidth = 1 ;
yBarLength = 12.5 ;

lockingPinLength = 3.6;
lockingPinWidth = 4.5 ;
lockingPinHeight = 2.4 ;

indexSpringHeight = 3; 

slidingGuideDiameter = 1 ;



module centralPlate () {
  module plate() {
    cube ([centralPlateLength,centralPlateWidth,1.4]);
  }

  module crossHole() {
    union () {
      translate ([-crossHoleLength/2,-crossHoleWidth/2,0]){
        cube ([crossHoleLength,crossHoleWidth,4]) ;
      }
      translate ([-crossHoleClipGapLength/2-1,-crossHoleWidth/2-crossHoleClipGapDepth]) {
        cube ([crossHoleClipGapLength,crossHoleWidth+2*crossHoleClipGapDepth,4]) ;
      }
    }
  }

  // combine
  translate ([-centralPlateLength/2,-centralPlateWidth/2,0]) {
    difference () {
      union () {
        plate () ;
      }
      union () {
        translate ([centralPlateLength/2+0.7,centralPlateWidth/2+0.4,-1]) {
          crossHole() ;
        }
      }
    }
  }
}

module yBar () {
  translate ([0,-yBarLength/2,0]) {
    cube ([yBarWidth,yBarLength,3]) ;
  }
}
module frontBar () {
  translate ([centralPlateLength/2-yBarWidth,0,0]) {
    yBar() ;
  }
}
module rearBar () {
  translate ([-centralPlateLength/2,,0]) {
    yBar() ;
  }
}

module lockingPin () {
  translate ([centralPlateLength/2-yBarWidth,-lockingPinWidth-0,0]) {
    cube ([lockingPinLength+1,lockingPinWidth,lockingPinHeight]);
  }
}

module indexSpring () {
  translate ([-centralPlateLength/2,0,0]) {
    union () {
      difference () {
      cube ([centralPlateLength,.7,indexSpringHeight]);
      translate ([centralPlateLength/2,0,-1]) {
      rotate ([90,0,0]) {
        scale ([1.25,0.9,1]) {
      cylinder (d=centralPlateLength/2, h= indexSpringHeight,center=true) ;
  }
      }
      }
      }
      translate ([centralPlateLength/2,0,2]) {
      scale ([1.1,0.9,1]) {
        cylinder (d=2,h=1);
        }
      }    
    }
  }
}

module leftIndexSpring () {
  translate ([0,-yBarLength/2,0]) {
    indexSpring ();
  }
}

module rightIndexSpring () {
  translate ([0,yBarLength/2,0]) {
    mirror ([0,1,0]){
      indexSpring ();
    }
  }
}

module slidingGuides() {
  for (x=[-1:2:1],y=[-1:2:1]){
    translate ([x*(centralPlateLength/2-slidingGuideDiameter),y*yBarLength/2,0]) {
      scale ([1.3,0.6,1]) {
      cylinder (d=slidingGuideDiameter);
      }
    }
  }
}

module batteryLock () {
  union () {
    centralPlate ();
    frontBar();
    rearBar() ;
    lockingPin ();
    leftIndexSpring() ;
    rightIndexSpring() ;
    slidingGuides();
  }
}

batteryLock () ;

