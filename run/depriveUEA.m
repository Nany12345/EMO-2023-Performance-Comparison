alg = {'NSGAII','MOEAD','NSGAIII','MOEADD','DEAGNG','RVEA','PREA','SparseEA','R2HCAEMOA'};

for algInd = 1:length(alg)
    algName = alg{algInd};
    folder = sprintf('./Data/%s',algName);
    list = dir(fullfile(folder));
    fileNum = size(list,1)-2;
    for fileInd = 3:fileNum
        fileName = list(fileInd).name;
        if ~contains(fileName,'_M10_')
            try
                data = load(fileName);
                POP = data.POP;
                runtime = data.runtime;
                save(sprintf('%s/%s',folder,fileName),'POP','runtime');
                disp(fileName);
            catch
                fprintf(2,'%s\n',fileName);
            end
        end
    end
end