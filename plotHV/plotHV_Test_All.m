function plotHV_Test_All(pro,alg1,alg2,obj,runNum,objIndList,name,label,locxy)
    rA = zeros(length(pro),length(alg1),2);
    folderNames = {'HV','HV-Sel'};
    for folderInd = 1:length(folderNames)
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
                    fileName = sprintf('./Data/%s/M%d_%s_%s.mat', ...
                        folderNames{folderInd},M,algName,proName);
                    HVAlg = load(fileName).HV;
                    if folderInd==1
                        HVAlg = HVAlg(:,end);
                        HV(:,algInd) = HVAlg;
                    else
                        HV(:,algInd) = HVAlg';
                    end
                end
                rA(rowInd,:,folderInd) = Rank(HV);
            end
        end
    end
    locx = locxy(1); locy = locxy(2);
    
    r = zeros(2,length(alg1));
    for i = 1:2
        r(i,:) = mean(rA(:,:,i));
    end
    foldName = 'Figure/Rank-All'; fileName = sprintf(name);
    mkdir(foldName)
    fileName = sprintf('./%s/%s',foldName,fileName);         
    Fig = figure(...
        'Units',           'pixels',...
        'Name',            fileName,...
        'Position',       [100,100,800,350]);
    fs = 30;
    edgecolor = [0,0,0.3];
    x = 1:length(alg);
    bar(x,r(1,:),0.5,'FaceColor','flat','EdgeColor',edgecolor,'LineWidth',1);
    hold on;
    bar(x,r(2,:),0.25,'FaceColor','red','EdgeColor',edgecolor,'LineWidth',1);
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
    
    for objInd = objIndList
        M = obj(objInd);
        r = zeros(2,length(alg1));
        for i = 1:2
            r(i,:) = mean(rA((objInd-1)*length(pro)+1:length(pro)*objInd,:,i));
        end
        foldName = 'Figure/Rank-All'; fileName = sprintf('%s_M%d',name,M);
        fileName = sprintf('./%s/%s',foldName,fileName);         
        Fig = figure(...
            'Units',           'pixels',...
            'Name',            fileName,...
            'Position',       [100,100,800,350]);
        fs = 30;
        edgecolor = [0,0,0.3];
        x = 1:length(alg);
        bar(x,r(1,:),0.5,'FaceColor','flat','EdgeColor',edgecolor,'LineWidth',1);
        hold on;
        bar(x,r(2,:),0.25,'FaceColor','red','EdgeColor',edgecolor,'LineWidth',1);
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