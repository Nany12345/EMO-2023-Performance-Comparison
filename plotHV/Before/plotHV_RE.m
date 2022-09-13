clc; clear;
name = 'Real-World Problems (RE)';
alg1 = {@SMSEMOA1};
alg2 = {@HypE3};
alg0 = {@NSGAII,@MOEAD,@NSGAIII,@MOEADD,@RVEA,@SParseEA,@DEAGNG,@R2HCAEMOA,@PREA};
% label = {'SMS-EMOA/HypE','NSGA-II','MOEA/D','MOEA/DD','NSGA-III','RVEA','SParseEA','DEA-GNG','PREA','R2HCA-EMOA'};
label = {'1','2','3','4','5','6','7','8','9','10'};
proDTLZ = {@RE21,@RE22,@RE23,@RE24,@RE25, ...
    @RE31,@RE32,@RE33,@RE34,@RE35,@RE36,@RE37, ...
    @RE41,@RE42,@RE61,@RE91};
popSizeRE = [100*ones(1,5),91*ones(1,7),120*ones(1,2),112,174];
objNumRE = [2*ones(1,5),3*ones(1,7),4*ones(1,2),6,9];
genInd = 2;
runNum = 21;
rDTLZ = zeros(length(proDTLZ),length(alg0)+1);

for proInd = 1:length(proDTLZ)
    M = objNumRE(proInd);
    N = popSizeRE(proInd);
    if M>5
        alg = [alg0(1:2),alg2,alg0(3:end)];
    else
        alg = [alg0(1:2),alg1,alg0(3:end)];
    end
    proName = func2str(proDTLZ{proInd});
    rowInd = proInd;
    HV = zeros(runNum,length(alg));
    for algInd = 1:length(alg)
        algName = func2str(alg{algInd});
        fileName = sprintf('./Data/HV4/M%d_%s_%s.mat',M,algName,proName);
        HVAlg = load(fileName).HV;
        HV(:,algInd) = HVAlg(:,genInd);
    end
    rDTLZ(rowInd,:) = Rank(HV);
end

locx = 1.75; locy = 11.2;

rDTLZM = mean(rDTLZ);
foldName = 'Figure/Rank4'; fileName = sprintf(name);
fileName = sprintf('./%s/%s',foldName,fileName);         
Fig = figure(...
    'Units',           'pixels',...
    'Name',            fileName,...
    'Position',       [100,100,800,350]);
fs = 30;
edgecolor = [0,0,0.3];
facecolor = [1,0,0];
x = 1:length(alg);
b = bar(x,rDTLZM,0.5,'FaceColor','flat','EdgeColor',edgecolor,'LineWidth',1);
set(gca, 'Fontname', 'Times New Roman','FontSize',fs);
box off
ax = gca;
ax.XTick = x;
ax.XTickLabel = label;
ax.YTick = 0:2:10;
ax.YLim = [0,12];
ax.XLim = [0.5,10.5];
ax.FontSize = fs;
ax.LineWidth = 2;
text(locx,locy,name,'FontSize',fs,'Fontname', 'Times New Roman');
ylabel('Average Rank','FontSize',fs);
ax2 = axes('Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
set(ax2,'YTick', []);
set(ax2,'XTick', []);
set(ax2,'LineWidth', 2);
box on
set(gcf, 'renderer', 'painters');
saveas(Fig,[Fig.Name],'png');
rank = rDTLZ;
save(sprintf('./Data/Ranks/%s.mat',name),'rank');
close all;