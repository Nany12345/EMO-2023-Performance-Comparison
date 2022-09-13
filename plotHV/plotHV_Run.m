clc; clear;
alg1 = {@NSGAII,@MOEAD,@SMSEMOA1,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};
alg2 = {@NSGAII,@MOEAD,@HypE3,@NSGAIII,@MOEADD,@RVEA,@SparseEA,@DEAGNG,@R2HCAEMOA,@PREA};

proDTLZ = {@DTLZ1,@DTLZ2,@DTLZ3,@DTLZ4,@DTLZ5,@DTLZ6,@DTLZ7};
proWFG  = {@WFG1,@WFG2,@WFG3,@WFG4,@WFG5,@WFG6,@WFG7,@WFG8,@WFG9};
proMinusDTLZ = {@MinusDTLZ1,@MinusDTLZ2,@MinusDTLZ3,@MinusDTLZ4,@MinusDTLZ5,@MinusDTLZ6,@MinusDTLZ7};
proMinusWFG  = {@MinusWFG1,@MinusWFG2,@MinusWFG3,@MinusWFG4,@MinusWFG5,@MinusWFG6,@MinusWFG7,@MinusWFG8,@MinusWFG9};
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

proName = {'DTLZ','WFG','MinusDTLZ','MinusWFG','MaF','Real-World Problems (RE)','Real-World Problems (DDMOP)','Real-World Problems (RCM)'};

runNum = 21;
obj = [3,5,8,10];
genNum = 200;
popSize = [91,210,156,275];
testInd = 7;
label = {'1','2','3','4','5','6','7','8','9','10'};
locxy = [4.6,11.2; ...
         4.7,11.2; ...
         4.1,11.2; ...
         4.2,11.2; ...
         4.7,11.2; ...
         1.75,11.2; ...
         1.85,11.2; ...
         1.65,11.2;];

% plotHV_Test(proDTLZ,alg1,alg2,obj,runNum,[1,2,3,4],testInd,'DTLZ',label,locxy(1,:));
% plotHV_Test(proWFG, alg1,alg2,obj,runNum,[1,2,3,4],testInd,'WFG',label,locxy(2,:));
% plotHV_Test(proMinusDTLZ,alg1,alg2,obj,runNum,[1,2,3,4],testInd,'MinusDTLZ',label,locxy(3,:));
% plotHV_Test(proMinusWFG, alg1,alg2,obj,runNum,[1,2,3,4],testInd,'MinusWFG',label,locxy(4,:));
% plotHV_Test(proMaF,alg1,alg2,obj,runNum,[1,2,3,4],testInd,'MaF',label,locxy(5,:));
% plotHV_Real(proRWMOP,alg1,alg2,objNumRWMOP,runNum,testInd,'Real-World Problems (RCM)',label,locxy(6,:));
% plotHV_Real(proRE,alg1,alg2,objNumRE,runNum,testInd,'Real-World Problems (RE)',label,locxy(7,:));
% plotHV_Real(proDDMOP,alg1,alg2,objNumDDMOP,runNum,testInd,'Real-World Problems (DDMOP)',label,locxy(8,:));
% % 
% plotHV_Test_RUEA(proDTLZ,alg1,alg2,obj,runNum,[1,2,3,4],'DTLZ',label,locxy(1,:));
% plotHV_Test_RUEA(proWFG, alg1,alg2,obj,runNum,[1,2,3,4],'WFG',label,locxy(2,:));
% plotHV_Test_RUEA(proMinusDTLZ,alg1,alg2,obj,runNum,[1,2,3,4],'MinusDTLZ',label,locxy(3,:));
% plotHV_Test_RUEA(proMinusWFG, alg1,alg2,obj,runNum,[1,2,3,4],'MinusWFG',label,locxy(4,:));
% plotHV_Test_RUEA(proMaF,alg1,alg2,obj,runNum,[1,2,3,4],'MaF',label,locxy(5,:));
% plotHV_Real_RUEA(proRWMOP,alg1,alg2,objNumRWMOP,runNum,'Real-World Problems (RCM)',label,locxy(6,:));
% plotHV_Real_RUEA(proRE,alg1,alg2,objNumRE,runNum,'Real-World Problems (RE)',label,locxy(7,:));
% plotHV_Real_RUEA(proDDMOP,alg1,alg2,objNumDDMOP,runNum,'Real-World Problems (DDMOP)',label,locxy(8,:));

d = Obtain_Distance(proName,length(alg1),true,true);
writematrix(d,'./Data/Ranks-Sel-LGI/Distance.xlsx');
d = Obtain_Distance(proName,length(alg1),true,false);
writematrix(d,'./Data/Ranks/Distance.xlsx');
d = Obtain_Distance(proName,length(alg1),false,true);
writematrix(d,'./Data/Ranks-Sel-LGI/Distance-M3.xlsx');
d = Obtain_Distance(proName,length(alg1),false,false);
writematrix(d,'./Data/Ranks/Distance-M3.xlsx');

% plotHV_Test_All(proDTLZ,alg1,alg2,obj,runNum,[1,2,3,4],'DTLZ',label,locxy(1,:));
% plotHV_Test_All(proWFG, alg1,alg2,obj,runNum,[1,2,3,4],'WFG',label,locxy(2,:));
% plotHV_Test_All(proMinusDTLZ,alg1,alg2,obj,runNum,[1,2,3,4],'MinusDTLZ',label,locxy(3,:));
% plotHV_Test_All(proMinusWFG, alg1,alg2,obj,runNum,[1,2,3,4],'MinusWFG',label,locxy(4,:));
% plotHV_Test_All(proMaF,alg1,alg2,obj,runNum,[1,2,3,4],'MaF',label,locxy(5,:));
% plotHV_Real_All(proRWMOP,alg1,alg2,objNumRWMOP,runNum,'Real-World Problems (RCM)',label,locxy(6,:));
% plotHV_Real_All(proRE,alg1,alg2,objNumRE,runNum,'Real-World Problems (RE)',label,locxy(7,:));
% plotHV_Real_All(proDDMOP,alg1,alg2,objNumDDMOP,runNum,'Real-World Problems (DDMOP)',label,locxy(8,:));