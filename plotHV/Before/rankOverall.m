name = 'All Problems';
TS = {'DTLZ','WFG','Minus-DTLZ','Minus-WFG','MaF','Real-World Problems (RE)','Real-World Problems (RCM)'};
label = {'1','2','3','4','5','6','7','8','9','10'};
rank = zeros(length(TS)+1,10);
rankAll = [];
for i = 1:length(TS)
    ranking = load(sprintf('./Data/Ranks/%s.mat',TS{i})).rank;
    if i<6
        rank(i,:) = mean(ranking(1:end/3,:));
        rankAll = [rankAll;ranking(1:end/3,:)];
    else
        rank(i,:) =  mean(ranking);
        rankAll = [rankAll;ranking];
    end
end
rank(end,:) = mean(rankAll);

locx = 4; locy = 11.2;

rankM = rank(end,:);
foldName = 'Figure/Rank4'; fileName = 'Overall-M3';
fileName = sprintf('./%s/%s',foldName,fileName);      
Fig = figure(...
    'Units',           'pixels',...
    'Name',            fileName,...
    'Position',       [100,100,800,396]);
fs = 30;
edgecolor = [0,0,0.3];
facecolor = [1,0,0];
x = 1:length(alg);
b = bar(x,rankM,0.5,'FaceColor','flat','EdgeColor',edgecolor,'LineWidth',1);
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
xlabel('Algorithm','FontSize',fs);
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
save(sprintf('./Data/Ranks/Overall-M3.mat'),'rankM');
close all;

Dist = zeros(size(rank,1),size(rank,1));
for i = 1:size(rank,1)
    for j = [1:i-1,i+1:size(rank,1)]
        Dist(i,j) = sum(abs(rank(i,:)-rank(j,:)));
    end
end
save('./Data/Ranks/Distance-M3.mat','Dist');
writematrix(Dist,'./Data/Ranks/Distance-M3.xlsx');
