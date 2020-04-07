function markdown(classname, outputpath)
%MARKDOWN  Build markdown files
%
%  MDBUILD(CLASS, OUTPUTDIR) parses the CLASS specified and writes a
%  document in the OUTPUTDIR specified.
%
%  OUTPUTS in CommonMark

obmeta = meta.class.fromName(classname);

fid = fopen(fullfile(outputpath, [classname, '.md']), 'w');

fprintf(fid, '%s (Generated %s)\n\n', classname, datestr(now));

if isempty(obmeta)
    
    error('Error parsing %s', classname);
    
end

%Print table of contents
fprintf(fid, '[[_TOC_]]\n\n');

%Print properties
fprintf(fid, '## Class Properties\n\n');

for iP = 1:numel(obmeta.PropertyList)
    
    fprintf(fid, '### %s\n', obmeta.PropertyList(iP).Name);
    helpstr = help([classname, '/', obmeta.PropertyList(iP).Name]);
    fprintf(fid, ' %s\n', helpstr);
    
    fprintf(fid, '  Get Access: %s\n', obmeta.PropertyList(iP).GetAccess);
    fprintf(fid, '  Set Access: %s\n', obmeta.PropertyList(iP).SetAccess);
    
    fprintf(fid, '\n');
    
end

%Methods
fprintf(fid, '## Class Methods\n\n');

for iP = 1:numel(obmeta.MethodList)
    
    fprintf(fid, '### %s\n', obmeta.MethodList(iP).Name);
    
    helpstr = help([classname, '/', obmeta.MethodList(iP).Name]);
    fprintf(fid, '%s\n\n', helpstr);
end

fclose(fid);

end