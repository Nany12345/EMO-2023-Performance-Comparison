lc; clear;
alg1 = {@NSGAII,@MOEAD,@SMSEMOA1,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};
alg2 = {@NSGAII,@MOEAD,@HypE3,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};

proNormal = {@DTLZ1,@DTLZ2,@DTLZ3,@DTLZ4,@DTLZ5,@DTLZ6,@DTLZ7,@WFG1,@WFG2,@WFG3, ...
    @WFG4,@WFG5,@WFG6,@WFG7,@WFG8,@WFG9};
proMinus = {@MinusDTLZ1,@MinusDTLZ2,@MinusDTLZ3,@MinusDTLZ4,@MinusDTLZ5,@MinusDTLZ6,@MinusDTLZ7...
    @MinusWFG1,@MinusWFG2,@MinusWFG3,@MinusWFG4,@MinusWFG5,@MinusWFG6,@MinusWFG7,@MinusWFG8,@MinusWFG9};
proMaF = {@MaF1, @MaF2, @MaF3, @MaF4, @MaF5, @MaF6, @MaF7, @MaF8, @MaF9,...
    @MaF10, @MaF11, @MaF12, @MaF13, @MaF14, @MaF15};
proRWMOP = {@RWMOP1,@RWMOP2,@RWMOP3,@RWMOP4,@RWMOP5,@RWMOP6,@RWMOP7,@RWMOP8,@RWMOP9,@RWMOP10, ...
    @RWMOP11,@RWMOP12,@RWMOP13,@RWMOP14,@RWMOP15,@RWMOP16,@RWMOP17,@RWMOP18,@RWMOP19,@RWMOP20, ...
    @RWMOP21};
proRE = {@RE21,@RE22,@RE23,@RE24,@RE25, ...
    @RE31,@RE32,@RE33,@RE34,@RE35,@RE36,@RE37, ...
    @RE41,@RE42,@RE61,@RE91};
popSizeRWMOP = [91*ones(1,7),120,100,91,112,91,120,91,91,91,120,91,120,91,91];
objNumRWMOP = [3*ones(1,7),4,2,3,6,3,4,3,3,3,4,3,4,3,3];
popSizeRE = [100*ones(1,5),91*ones(1,7),120*ones(1,2),112,174];
objNumRE = [2*ones(1,5),3*ones(1,7),4*ones(1,2),6,9];

runNum = 21;
obj = [3,5,8,10];
genNum = 200;
popSize = [91,210,156,275];


genRefRealFunc(proRE,alg1,objNumRE,runNum,false);
genRefRealFunc(proRWMOP,alg1,objNumRWMOP,runNum,false);
genRefRealFunc(proRE,alg2,objNumRE,runNum,true);
genRefRealFunc(proRWMOP,alg2,objNumRWMOP,runNum,true);

% genRefTestFunc(proNormal,alg1,obj,runNum,[1,2]);
% genRefTestFunc(proMinus,alg1,obj,runNum,[1,2]);
% genRefTestFunc(proMaF,alg1,obj,runNum,[1,2]);
% 
% genRefTestFunc(proNormal,alg2,obj,runNum,[3,4]);
% genRefTestFunc(proMinus,alg2,obj,runNum,[3,4]);
% genRefTestFunc(proMaF,alg2,obj,runNum,[3]);