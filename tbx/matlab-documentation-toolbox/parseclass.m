testfile = 'D:\Projects\Linear Assignment Linker\code\tbx\lap-tracker\TrackArray.m';

outputpath = 'D:\Projects\Linear Assignment Linker\lap-cell-tracker.wiki';

[~, cname] = fileparts(testfile);

obmeta = meta.class.fromName(cname);

fid = fopen(fullfile(outputpath, [cname, '.md']), 'w');

fprintf(fid, '%s (Generated %s)\n\n', cname, datestr(now));

if isempty(obmeta)    
    
    error('Error parsing %s', cname);
    
end

%Print table of contents
fprintf(fid, '[[_TOC_]]\n\n');

%Print properties
fprintf(fid, '## Class Properties\n\n');

for iP = 1:numel(obmeta.PropertyList)
    
    fprintf(fid, '### %s\n', obmeta.PropertyList(iP).Name);
    helpstr = help([cname, '/', obmeta.PropertyList(iP).Name]);
    fprintf(fid, ' %s\n', helpstr);
        
    fprintf(fid, '  Get Access: %s\n', obmeta.PropertyList(iP).GetAccess);
    fprintf(fid, '  Set Access: %s\n', obmeta.PropertyList(iP).SetAccess);
    
    fprintf(fid, '\n');
    
end

%Methods
fprintf(fid, '## Class Methods\n\n');

for iP = 1:numel(obmeta.MethodList)
    
    fprintf(fid, '### %s\n', obmeta.MethodList(iP).Name);
    
    helpstr = help([cname, '/', obmeta.MethodList(iP).Name]);
    fprintf(fid, '%s\n\n', helpstr);
end

fclose(fid);
