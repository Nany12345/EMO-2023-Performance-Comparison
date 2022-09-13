function d = Obtain_Distance(proName,algNum,isAll,isSel)
    rank = zeros(length(proName)+1,algNum);
    rankAll = [];
    for i = 1:length(proName)
        if isSel
            ranking = load(sprintf('./Data/Ranks-Sel-LGI/%s.mat',proName{i})).rank;
        else
            ranking = load(sprintf('./Data/Ranks/%s.mat',proName{i})).rank;
        end
        if i<6
            if isAll
                rank(i,:) = mean(ranking);
                rankAll = [rankAll;ranking];
            else
                rank(i,:) = mean(ranking(1:end/4,:));
                rankAll = [rankAll;ranking(1:end/4,:)];
            end
        else
            rank(i,:) =  mean(ranking);
            rankAll = [rankAll;ranking];
        end
    end
    rank(end,:) = mean(rankAll);
    d = zeros(size(rank,1));
    for i = 1:size(rank,1)
        for j = [1:i-1,i+1:size(rank,1)]
            d(i,j) = sum(abs(rank(i,:)-rank(j,:)));
        end
    end
end