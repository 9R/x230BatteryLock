$fa=1;
$fs=0.5;

centralPlateLength = 12.8;
centralPlateWidth = 8.7;

yBarWidth = 1 ;
yBarLength = 11.5 ;

lockingPinLength = 3;
lockingPinWidth = 4 ;
lockingPinHeight = 3 ;

module centralPlate () {
  module crossHole () {
    union () {
      cube ([7.5,3.5,4]) ;
      translate ([1.,-1,0]) {
        cube ([3,5.5,4]) ;
      }
    }
  }
  module plate() {
    cube ([centralPlateLength,centralPlateWidth,1.4]);
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

module batteryLock () {
  union () {
    centralPlate ();
    frontBar();
    rearBar() ;
    lockingPin ();
  }
}

batteryLock () ;
