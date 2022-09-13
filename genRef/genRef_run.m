clc; clear;
alg1 = {@NSGAII,@MOEAD,@SMSEMOA1,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};
alg2 = {@NSGAII,@MOEAD,@HypE3,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};

proMinus = {@MinusDTLZ5,@MinusDTLZ6,@MinusDTLZ7,@MinusWFG1,@MinusWFG2,@MinusWFG3};
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

% generateRef_Real(proRE,alg1,objNumRE,popSizeRE,runNum,testInd,false)
% generateRef_Real(proRE,alg2,objNumRE,popSizeRE,runNum,testInd,true)
generateRef_Real(proRWMOP,alg1,objNumRWMOP,popSizeRWMOP,runNum,testInd,false)
generateRef_Real(proRWMOP,alg2,objNumRWMOP,popSizeRWMOP,runNum,testInd,true)
% generateRef_Real(proDDMOP,alg1,objNumDDMOP,popSizeDDMOP,runNum,testInd,false)
% generateRef_Real(proDDMOP,alg2,objNumDDMOP,popSizeDDMOP,runNum,testInd,true)
% generateRef_Test(proMinus,alg1,obj,popSize,runNum,[1,2],testInd)
% generateRef_Test(proMinus,alg2,obj,popSize,runNum,[3,4],testInd)