$fa=1;
$fs=0.2;

centralPlateLength = 12.8;
centralPlateWidth = 8.7;

crossHoleLength= 7.5;
crossHoleWidth=  5.5;
crossHoleClipGaps= 3.5 ;

yBarWidth = 1 ;
yBarLength = 11.5 ;

lockingPinLength = 3;
lockingPinWidth = 4.5 ;
lockingPinHeight = 3 ;

indexSpringHeight = 3; 

module centralPlate () {
  module plate() {
    cube ([centralPlateLength,centralPlateWidth,1.4]);
  }
  module crossHole () {
    union () {
      cube ([crossHoleLength,3.5,4]) ;
      translate ([1.,-1,0]) {
        cube ([crossHoleClipGaps,crossHoleWidth,4]) ;
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
        translate ([3.3,3,-1])
          crossHole ();
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
  translate ([centralPlateLength/2-yBarWidth,-lockingPinWidth,0]) {
    cube ([lockingPinLength+1,lockingPinWidth,lockingPinHeight]);
  }
}

module indexSpring () {
  translate ([-centralPlateLength/2,0,0]) {
    union () {
    cube ([centralPlateLength,.7,indexSpringHeight]);
  translate ([centralPlateLength/2,0,2]) {
  cylinder (d=2,h=1);
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

module batteryLock () {
  union () {
    centralPlate ();
    frontBar();
    rearBar() ;
    lockingPin ();
    leftIndexSpring() ;
    rightIndexSpring() ; 
  }
}

batteryLock () ;
