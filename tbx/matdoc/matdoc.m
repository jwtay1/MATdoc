function matdoc(varargin)
%MATDOC  Generate documentation for MATLAB classes
%
%  MATDOC build generates documentation for files in the current folder. It
%  generates a list of Markdown files that can then be uploaded to a
%  Github/Gitlab wiki. Eventually, the goal is to generate files that are
%  compatible with a static site generator.

if ~isempty(varargin)
    
    switch lower(varargin{1})
        
        case 'build'
            %BUILD  Build documentation
            %Syntax: matdoc build [-options] [input_dir] [output_dir]
            
            %Set default settings
            buildopts.builder = 'markdown';
            buildopts.inputdir = pwd;
            buildopts.outputdir = fullfile(pwd, 'docs');
                        
            %Parse input variables
            iArg = 2;
            while iArg <= numel(varargin)
                
                %Parse options ('-')
                if strcmpi(varargin{iArg}(1), '-')
                    switch lower(varargin{iArg})
                        
                        case '-markdown'
                            buildopts.builder = 'markdown';
                            
                        case '-mkdocs'
                            buildopts.builder = 'mkdocs';
                            
                    end
                    
                    %Move the pointer
                    iArg = iArg + 1;
                else
                    %These should be input/output directories
                    
                    %input directory is the second to last or last
                    if iArg == numel(varargin)
                        
                        buildopts.inputdir = varargin{iArg};
                        iArg = iArg + 1;
                    elseif iArg == (numel(varargin) - 1)
                        
                        buildopts.inputdir = varargin{iArg};
                        buildopts.outputdir = varargin{iArg + 1};
                        iArg = iArg + 2;
                    else
                        error('matdoc:build:TooManyInputArguments', ...
                            'Too many input arguments. Expected input/output directory to be the last arguments.');
                    end
                    
                end
                
            end

            %Create a 'docs' folder
            if ~exist('docs', 'dir')
                mkdir('docs');                
            end
            
            %Locate m-files in the directory
            files = dir('*.m');
            
            for iF = 1:numel(files)
                
                [~, classname] = fileparts(files(iF).name);
                
                strExec = sprintf('builders.%s(classname, buildopts.outputdir);', buildopts.builder);
                eval(strExec);
                
            end
           
        otherwise
            error('matdoc:UnrecognizedCommand', ...
                '''%s'' is not a recognized command. Call help matdoc to view the documentation.', ...
                varargin{1});
        
    end
    
else
    
    warning('matdoc:InsufficientInputArguments', ...
        'Please supply a command.')
    help matdoc
    
end





end