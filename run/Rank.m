function res = Rank(hv)
    N=size(hv,2);
    index=1:N;
    rank=zeros(1,N);
    res=zeros(1,N);
    % Sort the hv by statistical test
    for i=1:size(hv,2)
        for j=i+1:size(hv,2)
            hvi = hv(:,i);
            hvi(hvi==-1) = [];
            hvj = hv(:,j);
            hvj(hvj==-1) = [];
            hvj(hvj==Inf) = [];
            hvj(hvj==-Inf) = [];
            if compare(hvi,hvj)<0
                hv(:,[i,j])=hv(:,[j,i]);
                index([i,j])=index([j,i]);
            end
        end
    end
    % e.g., 10, 10, 4, 6 --> 1, 1, 3, 2
    cnt=1; rank(1)=1; st=1;
    for i=2:N
        cnt=cnt+1;
        if compare(hv(:,i-1), hv(:,i))~=0
            rank(st:i-1)=(rank(st)+rank(i-1))/2;
            st=i;
        end
        rank(i)=cnt;
    end
    rank(st:N)=(rank(st)+rank(N))/2;

    for i=1:N
        res(index(i))=rank(i);
    end
end

function r=compare(x,y)
    meanx=mean(x);
    meany=mean(y);
    if meanx>meany
        r=1;
    elseif meanx<meany
        r=-1;
    else
        r=0;
    end
 end