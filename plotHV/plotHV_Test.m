function plotHV_Test(pro,alg1,alg2,obj,runNum,objIndList,testInd,name,label,locxy)
    rA = zeros(length(pro),length(alg1));
    for objInd = objIndList
        M = obj(objInd);
        if M>5
            alg = alg2;
        else
            alg = alg1;
        end
        for proInd = 1:length(pro)
            proName = func2str(pro{proInd});
            rowInd = (objInd-1)*length(pro)+proInd;
            HV = zeros(runNum,length(alg));
            for algInd = 1:length(alg)
                algName = func2str(alg{algInd});
                fileName = sprintf('./Data/HV/M%d_%s_%s.mat',M,algName,proName);
                HVAlg = load(fileName).HV;
                HV(:,algInd) = HVAlg(:,testInd);
            end
            rA(rowInd,:) = Rank(HV);
        end
    end
    locx = locxy(1); locy = locxy(2);
    
    r = mean(rA);
    foldName = 'Figure/Rank'; fileName = sprintf(name);
    mkdir(foldName)
    fileName = sprintf('./%s/%s',foldName,fileName);         
    Fig = figure(...
        'Units',           'pixels',...
        'Name',            fileName,...
        'Position',       [100,100,800,350]);
    fs = 30;
    edgecolor = [0,0,0.3];
    facecolor = [1,0,0];
    x = 1:length(alg);
    b = bar(x,r,0.5,'FaceColor','flat','EdgeColor',edgecolor,'LineWidth',1);
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
    rank = rA;
    save(sprintf('./Data/Ranks/%s.mat',name),'rank');
    close all;
    
    for objInd = objIndList
        M = obj(objInd);
        r = mean(rA((objInd-1)*length(pro)+1:length(pro)*objInd,:));
        foldName = 'Figure/Rank'; fileName = sprintf('%s_M%d',name,M);
        fileName = sprintf('./%s/%s',foldName,fileName);         
        Fig = figure(...
            'Units',           'pixels',...
            'Name',            fileName,...
            'Position',       [100,100,800,350]);
        fs = 30;
        edgecolor = [0,0,0.3];
        facecolor = [1,0,0];
        x = 1:length(alg);
        b = bar(x,r,0.5,'FaceColor','flat','EdgeColor',edgecolor,'LineWidth',1);
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
        close all;
    end
end