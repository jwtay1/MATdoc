function matlabhelp2md(classname, outputFile)

methodsList = methods(classname);

fid = fopen(outputFile, 'w');

fprintf(fid, 'Methods list for class %s\n=====\n', classname);

for iM = 1:numel(methodsList)
    
    fprintf(fid, '\n%s\n-----\n\n', methodsList{iM});
    
    helpstr = help([classname, '/', methodsList{iM}]);
    fprintf(fid, '%s', helpstr);
    
end

fclose(fid);


end