clc; clear;
name = 'DTLZ';
alg1 = {@SMSEMOA1};
alg2 = {@HypE3};
alg0 = {@NSGAII,@MOEAD,@NSGAIII,@MOEADD,@RVEA,@SParseEA,@DEAGNG,@R2HCAEMOA,@PREA};
% label = {'SMS-EMOA/HypE','NSGA-II','MOEA/D','MOEA/DD','NSGA-III','RVEA','SParseEA','DEA-GNG','PREA','R2HCA-EMOA'};
label = {'1','2','3','4','5','6','7','8','9','10'};
proDTLZ = {@DTLZ1,@DTLZ2,@DTLZ3,@DTLZ4,@DTLZ5,@DTLZ6,@DTLZ7};
genInd = 2;
runNum = 21;
obj = [3,5,8];
rDTLZ = zeros(3*length(proDTLZ),length(alg0)+1);
for objInd = 1:3
    M = obj(objInd);
    N = obj(objInd);
    if M>5
        alg = [alg0(1:2),alg2,alg0(3:end)];
    else
        alg = [alg0(1:2),alg1,alg0(3:end)];
    end
    for proInd = 1:length(proDTLZ)
        proName = func2str(proDTLZ{proInd});
        rowInd = (objInd-1)*length(proDTLZ)+proInd;
        HV = zeros(runNum,length(alg));
        for algInd = 1:length(alg)
            algName = func2str(alg{algInd});
            fileName = sprintf('./Data/HV4/M%d_%s_%s.mat',M,algName,proName);
            HVAlg = load(fileName).HV;
            HV(:,algInd) = HVAlg(:,genInd);
        end
        rDTLZ(rowInd,:) = Rank(HV);
    end
end
locx = 4.6; locy = 11.2;

rDTLZM = mean(rDTLZ);
foldName = 'Figure/Rank4'; fileName = sprintf(name);
% mkdir(foldName)
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

for objInd = 1:3
    M = obj(objInd);
    N = obj(objInd);
    rDTLZM = mean(rDTLZ((objInd-1)*length(proDTLZ)+1:length(proDTLZ)*objInd,:));
    foldName = 'Figure/Rank4'; fileName = sprintf('%s_M%d',name,M);
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
end