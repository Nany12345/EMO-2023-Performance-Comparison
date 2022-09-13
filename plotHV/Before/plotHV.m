clc; clear;
alg = {'NSGAII','MOEAD','NSGAIII','MOEADD','MNSGAII','DEAGNG'};
proReg = {'DTLZ1','DTLZ2','DTLZ3','DTLZ4','WFG4','WFG5',...
    'WFG6','WFG7','WFG8','WFG9'};
proMin = proReg;
for proInd = 1:length(proReg)
    proMin{proInd} = ['Minus',proReg{proInd}];
end
proRe = {'RE21','RE22','RE23','RE24','RE25', ...
    'RE31','RE32','RE33','RE34','RE35','RE36','RE37', ...
    'RE41','RE42','RE61','RE91'};
pro = proReg;
genInd = 3;
runNum = 21;
obj = [3,5,8,10];
genNum = 5000;
popSize = [91,210,156,275];
rReg = zeros(4*length(pro),length(alg));
for objInd = 1:4
    M = obj(objInd);
    N = obj(objInd);
    for proInd = 1:length(pro)
        proName = pro{proInd};
        rowInd = (objInd-1)*length(pro)+proInd;
        HV = zeros(runNum,length(alg));
        for algInd = 1:length(alg)
            algName = alg{algInd};
            fileName = sprintf('./Data/HV/M%d_%s_%s',M,algName,proName);
            HVAlg = load(fileName).HV;
            HV(:,algInd) = HVAlg(:,genInd);
        end
        rReg(rowInd,:) = Rank(HV);
    end
end

pro = proMin;
genInd = 3;
runNum = 21;
obj = [3,5,8,10];
genNum = 5000;
popSize = [91,210,156,275];
rMin = zeros(4*length(pro),length(alg));
for objInd = 1:4
    M = obj(objInd);
    N = obj(objInd);
    for proInd = 1:length(pro)
        proName = pro{proInd};
        rowInd = (objInd-1)*length(pro)+proInd;
        HV = zeros(runNum,length(alg));
        for algInd = 1:length(alg)
            algName = alg{algInd};
            fileName = sprintf('./Data/HV/M%d_%s_%s',M,algName,proName);
            HVAlg = load(fileName).HV;
            HV(:,algInd) = HVAlg(:,genInd);
        end
        rMin(rowInd,:) = Rank(HV);
    end
end

pro = proRe;
genInd = 3;
runNum = 21;
genNum = 5000;
rRe = zeros(length(pro),length(alg));
for proInd = 1:length(pro)
    if proInd<=5
        M = 2;
        N = 100;
    elseif proInd>5 && proInd<=12
        M = 3;
        N = 91;
    elseif proInd>12 && proInd<=14
        M = 4;
        N = 120;
    elseif proInd==15
        M = 6;
        N = 112;
    elseif proInd==16
        M = 9;
        N = 174;
    end
    proName = pro{proInd};
    rowInd = proInd;
    HV = zeros(runNum,length(alg));
    for algInd = 1:length(alg)
        algName = alg{algInd};
        fileName = sprintf('./Data/HV/M%d_%s_%s',M,algName,proName);
        HVAlg = load(fileName).HV;
        HV(:,algInd) = HVAlg(:,genInd);
    end
    rRe(rowInd,:) = Rank(HV);
end

% for objInd = 1:4
%     M = obj(objInd);
%     N = obj(objInd);
%     for proInd = 1:length(pro)
%         proName = pro{proInd};
%         rowInd = (objInd-1)*length(pro)+proInd;
%         foldName = 'Figure/Rank'; fileName = sprintf('M%d_%s',M,proName);
%         fileName = sprintf('./%s/%s',foldName,fileName);         
%         Fig = figure(...
%             'Units',           'pixels',...
%             'Name',            fileName,...
%             'Position',       [100,100,500,500]);
%         fs = 20;
%         edgecolor = [0,0,0.3];
%         facecolor = [1,0,0];
%         x = 1:length(alg);
%         b = bar(x,rReg(rowInd,:),'FaceColor',facecolor,'EdgeColor',edgecolor,'LineWidth',2);
%         xtips1 = b(1).XEndPoints;
%         ytips1 = b(1).YEndPoints;
%         labels1 = string(b(1).YData);
%         text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%             'VerticalAlignment','bottom','FontSize',fs);
%         set(gca, 'Fontname', 'Times New Roman','FontSize',fs);
%         ax = gca;
%         ax.XTick = x;
%         ax.XTickLabel = {'NSGA-II','MOEA/D','NSGA-III','MOEA/DD','M-NSGA-II','DEAGNG'};
%         ax.YTick = 0:length(alg);
%         ax.XTickLabelRotation = 45;
%         ax.YLim = [0,length(alg)+0.5];
%         grid on;
%         ax.GridLineStyle = '-.';
%         ax.FontSize = fs;
%         ax.Box = 'on';
%         ax.LineWidth = 1.5;
%         set(gcf, 'renderer', 'painters');
%         ylabel('Rank','FontSize',fs);
%         title(sprintf('M%d %s',M,proName));
%         saveas(Fig,[Fig.Name],'png');
%         close all;
%     end
% end

rReg = mean(rReg);
rMin = mean(rMin);
rRe  = mean(rRe);
rTotal = [rReg',rMin',rRe'];
foldName = 'Figure/Rank'; fileName = sprintf('Total');
fileName = sprintf('./%s/%s',foldName,fileName);         
Fig = figure(...
    'Units',           'pixels',...
    'Name',            fileName,...
    'Position',       [100,100,750,600]);
fs = 20;
edgecolor = [0,0,0.3];
facecolor = [1,0,0];
x = 1:length(alg);
b = bar(x,rTotal,'FaceColor','flat','EdgeColor',edgecolor,'LineWidth',2);
b(1).CData = 1;
b(2).CData = 2;
xtips1 = b(1).XEndPoints+0.09;
ytips1 = b(1).YEndPoints+0.35;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Rotation',90);
xtips2 = b(2).XEndPoints+0.09;
ytips2 = b(2).YEndPoints+0.35;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Rotation',90);
xtips3 = b(3).XEndPoints+0.09;
ytips3 = b(3).YEndPoints+0.35;
labels3 = string(b(3).YData);
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Rotation',90);
set(gca, 'Fontname', 'Times New Roman','FontSize',fs);
ax = gca;
ax.XTick = x;
ax.XTickLabel = {'NSGA-II','MOEA/D','NSGA-III','MOEA/DD','M-NSGA-II','DEAGNG'};
ax.YTick = 0:length(alg);
ax.XTickLabelRotation = 45;
ax.YLim = [0,length(alg)+0.5];
grid on;
ax.GridLineStyle = '-.';
ax.FontSize = fs;
ax.Box = 'on';
ax.LineWidth = 1.5;
set(gcf, 'renderer', 'painters');
ylabel('Rank','FontSize',fs);
legend({'Normal Problems','Minus Problems','RE Problems'});
saveas(Fig,[Fig.Name],'png');
close all;