// BACKWARD FACING STEP

h = 0.04;
H = 0.0267;
L = 25*h;
l = 10*h;

Point(1) = {0,0,0};
Point(2) = {0,-H,0};
Point(3) = {L,-H,0};
Point(4) = {L,0,0};
Point(5) = {L,h,0};
Point(6) = {0,h,0};
Point(7) = {-l,h,0};
Point(8) = {-l,0,0};

Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {6,7};
Line(7) = {7,8};
Line(8) = {8,1};

Line(9) = {4,1};
Line(10) = {6,1};

nPc = 200;
nPh = 70;
nPH = 70;
nPs = 250;

pc = 1.02974;
bh = 0.02;
bH = 0.04;
ps = 1.02708;

// CHANNEL BLOCK

Transfinite Line{8} = nPc Using Progression 1/pc;
Transfinite Line{6} = nPc Using Progression pc;

Transfinite Line{7} = nPh Using Bump bh;
Transfinite Line{10} = nPh Using Bump bh;

Line Loop(1) = {8,-10,6,7};
Plane Surface(1) = {1};
Transfinite Surface{1};


// BOTTOM BLOCK

Transfinite Line{1} = nPH Using Bump bH;
Transfinite Line{3} = nPH Using Bump bH;

Transfinite Line{2} = nPs Using Progression ps;
Transfinite Line{9} = nPs Using Progression 1/ps;

Line Loop(2) = {1,2,3,9};
Plane Surface(2) = {2};
Transfinite Surface{2};

// TOP BLOCK

Transfinite Line{4} = nPh Using Bump bh;

Transfinite Line{5} = nPs Using Progression 1/ps;

Line Loop(3) = {4,5,10,-9};
Plane Surface(3) = {3};
Transfinite Surface{3};

Recombine Surface{1,2,3};


// EXTRUSION

surfaceVector1[] = Extrude {0,0,0.01} {

Surface{1};
Layers{1};
Recombine;

};

surfaceVector2[] = Extrude {0,0,0.01} {

Surface{2};
Layers{1};
Recombine;

};


surfaceVector3[] = Extrude {0,0,0.01} {

Surface{3};
Layers{1};
Recombine;

};



Physical Volume("VOLUME") = {surfaceVector1[1], surfaceVector2[1], surfaceVector3[1]};
Physical Surface("FRONT") = {surfaceVector1[0], surfaceVector2[0], surfaceVector3[0]};
Physical Surface("BACK") = {1,2,3};
Physical Surface("WALL") = {surfaceVector1[2], surfaceVector1[4], surfaceVector2[2], surfaceVector2[3], surfaceVector3[3]};
Physical Surface("INLET") = {surfaceVector1[5]};
Physical Surface("OUTLET") = {surfaceVector2[4],surfaceVector3[2]};

Mesh.MshFileVersion = 2.2;

