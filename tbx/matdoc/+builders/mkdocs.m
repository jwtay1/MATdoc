function mkdocs(classname, outputpath)
%MKDOCS  Outputs files compatible with MkDocs
%
%  MKDOCS(CLASS, OUTPUT)

%First calls the markdown builder
builders.markdown(classname, outputpath)

%Move to a 'docs' folder
movefile(outputpath, fullfile(outputpath, 'docs'));

%Create an index.md
fid = fopen(fullfile(outputpath, 'docs', 'index.md'), 'w');
fclose(fid);

%Write the mkdocs.yml file
fid = fopen(fullfile(outputpath, 'mkdocs.yml'), 'w');

fprintf(fid, 'site_name: Test Site\n');

%Print navigation
fprintf(fid, 'nav:\n');
%fprintf(fid, '    - ''index.md''\n');

files = dir(fullfile(outputpath, 'docs', '*.md'));

for ii = 1:numel(files)
    fprintf(fid, '    - ''%s''\n', files(ii).name);
end

fclose(fid);
end