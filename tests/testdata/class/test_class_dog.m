classdef test_class_dog
    %TEST_CLASS_DOG  A test class for testing matdoc
    %
    %  OBJ = TEST_CLASS_DOG creates a new object
    
    properties
        
        name char = 'Rover';
        age double = 1;
        
    end
    
    properties (SetAccess = private)
        
        isBarking logical = false;
        
    end
    
    methods
        
        function obj = test_class_dog(varargin)
            %test_class_dog  Class constructor
            %
            %  obj = test_class_dog(NAME, AGE) creates a new dog object
            %  with specified name and age
            if ~isempty(varargin) && numel(varargin) == 2
                
                obj.name = varargin{1};
                obj.age = varargin{2};
                
            end
            
        end
        
        function obj = bark(obj)
            %BARK  Start/stop barking
            %
            %  OBJ = BARK(OBJ) toggles the isBarking state.
            
            obj.isBarking = ~obj.isBarking;
            
        end
        
    end
    
end