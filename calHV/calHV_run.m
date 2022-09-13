clc; clear;
alg1 = {@NSGAII,@MOEAD,@SMSEMOA1,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};
alg2 = {@NSGAII,@MOEAD,@HypE3,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};

proNormal = {@DTLZ1,@DTLZ2,@DTLZ3,@DTLZ4,@DTLZ5,@DTLZ6,@DTLZ7,@WFG1,@WFG2,@WFG3, ...
    @WFG4,@WFG5,@WFG6,@WFG7,@WFG8,@WFG9};
proMinus2 = {@MinusDTLZ5,@MinusDTLZ6,@MinusDTLZ7,@MinusWFG1,@MinusWFG2,@MinusWFG3};

proMinus1 = {@MinusDTLZ1,@MinusDTLZ2,@MinusDTLZ3,@MinusDTLZ4,@MinusWFG4,@MinusWFG5,@MinusWFG6,@MinusWFG7,@MinusWFG8,@MinusWFG9};
proMaF = {@MaF1, @MaF2, @MaF3, @MaF4, @MaF5, @MaF6, @MaF7, @MaF8, @MaF9,...
    @MaF10, @MaF11, @MaF12, @MaF13, @MaF14, @MaF15};
proRWMOP = {@RWMOP1,@RWMOP2,@RWMOP3,@RWMOP4,@RWMOP5,@RWMOP6,@RWMOP7,@RWMOP8,@RWMOP9,@RWMOP10, ...
    @RWMOP11,@RWMOP12,@RWMOP13,@RWMOP14,@RWMOP15,@RWMOP16,@RWMOP17,@RWMOP18,@RWMOP19,@RWMOP20, ...
    @RWMOP21,@RWMOP22,@RWMOP23,@RWMOP24,@RWMOP25,@RWMOP26,@RWMOP27,@RWMOP28,@RWMOP29,@RWMOP30, ...
    @RWMOP31,@RWMOP32,@RWMOP33,@RWMOP34,@RWMOP35,@RWMOP36,@RWMOP37,@RWMOP38,@RWMOP39,@RWMOP40, ...
    @RWMOP41,@RWMOP42,@RWMOP43,@RWMOP44,@RWMOP45,@RWMOP46,@RWMOP47,@RWMOP48,@RWMOP49,@RWMOP50};
proRE = {@RE21,@RE22,@RE23,@RE24,@RE25, ...
    @RE31,@RE32,@RE33,@RE34,@RE35,@RE36,@RE37, ...
    @RE41,@RE42,@RE61,@RE91};
proDDMOP = {@DDMOP1,@DDMOP2,@DDMOP3,@DDMOP4,@DDMOP5,@DDMOP6,@DDMOP7};
popSizeRWMOP = [91,91,91,91,91,91,91,120,100,91,112,91,120,91,91,91,120,91,120,91,91,91,91,120,91,91,91,91,91,91,91,91,91,91,91,91,91,91,120,91,120,91,91,120,120,210,91,91,120,91];
objNumRWMOP = [3,3,3,3,3,3,3,4,2,3,6,3,4,3,3,3,4,3,4,3,3,3,3,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,3,4,3,3,4,4,5,3,3,4,3];
popSizeRE = [100*ones(1,5),91*ones(1,7),120*ones(1,2),112,174];
objNumRE = [2*ones(1,5),3*ones(1,7),4*ones(1,2),6,9];
popSizeDDMOP = [174,91,91,275,91,100,100];
objNumDDMOP = [9,3,3,10,3,2,2];

runNum = 21;
obj = [3,5,8,10];
genNum = 200;
popSize = [91,210,156,275];
testInd = 7;
selNum = 100;

% calHV_Test_Known(proNormal,alg1,obj,popSize,runNum,[1,2],testInd);
% calHV_Test_Known(proNormal,alg2,obj,popSize,runNum,[3,4],testInd);
% calHV_Test_Known(proMinus1,alg1,obj,popSize,runNum,[1,2],testInd);
% calHV_Test_Known(proMinus1,alg2,obj,popSize,runNum,[3,4],testInd);
% calHV_Test_Unknown(proMinus2,alg1,obj,popSize,runNum,[1,2],testInd);
% calHV_Test_Unknown(proMinus2,alg2,obj,popSize,runNum,[3,4],testInd);
% calHV_Test_Known(proMaF,alg1,obj,popSize,runNum,[1,2],testInd);
% calHV_Test_Known(proMaF,alg2,obj,popSize,runNum,[3,4],testInd);
% calHV_Real(proRWMOP,alg1,objNumRWMOP,popSizeRWMOP,runNum,testInd,false);
% calHV_Real(proRWMOP,alg2,objNumRWMOP,popSizeRWMOP,runNum,testInd,true);
% calHV_Real(proRE,alg1,objNumRE,popSizeRE,runNum,testInd,false);
% calHV_Real(proRE,alg2,objNumRE,popSizeRE,runNum,testInd,true);
% calHV_Real(proDDMOP,alg1,objNumDDMOP,popSizeDDMOP,runNum,testInd,false);
% calHV_Real(proDDMOP,alg2,objNumDDMOP,popSizeDDMOP,runNum,testInd,true);

calHV_Test_Known_RUEA(proNormal,alg1,obj,selNum,runNum,[1,2]);
calHV_Test_Known_RUEA(proNormal,alg2,obj,selNum,runNum,[3,4]);
calHV_Test_Known_RUEA(proMinus1,alg1,obj,selNum,runNum,[1,2]);
calHV_Test_Known_RUEA(proMinus1,alg2,obj,selNum,runNum,[3,4]);
calHV_Test_Unknown_RUEA(proMinus2,alg1,obj,selNum,runNum,[1,2]);
calHV_Test_Unknown_RUEA(proMinus2,alg2,obj,selNum,runNum,[3,4]);
calHV_Test_Known_RUEA(proMaF,alg1,obj,selNum,runNum,[1,2]);
calHV_Test_Known_RUEA(proMaF,alg2,obj,selNum,runNum,[3,4]);
calHV_Real_RUEA(proRWMOP,alg1,objNumRWMOP,selNum,runNum,false);
calHV_Real_RUEA(proRWMOP,alg2,objNumRWMOP,selNum,runNum,true);
calHV_Real_RUEA(proRE,alg1,objNumRE,selNum,runNum,false);
calHV_Real_RUEA(proRE,alg2,objNumRE,selNum,runNum,true);
calHV_Real_RUEA(proDDMOP,alg1,objNumDDMOP,selNum,runNum,false);
calHV_Real_RUEA(proDDMOP,alg2,objNumDDMOP,selNum,runNum,true);