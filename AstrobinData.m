classdef AstrobinData < handle
    properties (Access = public)
        title
        
        description
        
        imaging_optics
        imaging_cameras
        mounts
        filters
        accessories
        software
        guiding_scopes
        guiding_cameras
        dates
        frames
        integration
        darks
        flats
        flat_darks
        avg_moon_age
        avg_moon_phase
        bortle
        ra_center
        dec_center
        pixel_scale
        orientation
        field_radius
    end
    
    properties (Access = private)
        url
        processing
        
        instagram_user = 'chrisgnam.photos';
        instagram_account = 'https://www.instagram.com/chrisgnam.photos/';
        
        astrobin_user = 'ChrisGnam';
        astrobin_account = 'https://www.astrobin.com/users/ChrisGnam/';
        
        instagram_hashtags = '';
        imgur_hashtags = '';
    end
    
    methods
        function [self] = AstrobinData(url, key)
            
            % First verify that the key provided is valid:
            key_properties = properties(key);
            self_properties = properties(self);
            if length(key_properties) == length(self_properties)
                for ii = 1:length(key_properties)
                    if key_properties{ii} ~= self_properties{ii}
                        error(['Invalid key was provided.  Key: ', key_properties{ii}, ' has no match in this class'])
                    end
                end
            end
            
            % Get the webpage source html:
            self.url = url;
            contents = webread(url);
            
            % Remove Patterns:
            PATTERNS = {'<'+wildcardPattern+'>',...
                        };
    

            % Loop over keys and extract relevant data:
            for ii = 1:length(key_properties)
                PROPERTY = key_properties{ii};
                start_str = key.(PROPERTY){1};
                stop_str  = key.(PROPERTY){2};
                
                % Get the entries:
                VALUE = extractBetween(contents,start_str, stop_str);
                if length(VALUE) == 1
                    VALUE = VALUE{1};
                else
                    VALUE = 'N/A';
                    self.(PROPERTY) = VALUE;
                    continue
                end
                VALUE = strtrim(VALUE);
                
                % Remove large whitespaces:
                VALUE = regexprep(VALUE,'\s+',' ');
                
                % Generic cleaning of data:
                VALUE = strrep(VALUE,newline,' ');
                VALUE = strrep(VALUE,'&Prime;','"');
                VALUE = strrep(VALUE,'&prime;','"');
                VALUE = strrep(VALUE,'&times;','x');
                VALUE = strrep(VALUE,'&deg;','');
                VALUE = strrep(VALUE,'&middot;',newline);
                VALUE = strrep(VALUE, ' x ', 'x');
                VALUE = strrep(VALUE, '″','"');
                VALUE = strrep(VALUE, '′','''');
                VALUE = strrep(VALUE, '&#39;','''');
                VALUE = strrep(VALUE, '<br>',newline);
                
                VALUE = strrep(VALUE, '-&gt;', '->');
                VALUE = strrep(VALUE, '&nbsp; ', '');
                
                VALUE = strrep(VALUE,'<li>',' - ');
                VALUE = strrep(VALUE,'</li>','\n');
                VALUE = strrep(VALUE,'<strong>','**');
                VALUE = strrep(VALUE,'</strong>','**');
                
                % Delete pattern removes:
                for jj = 1:length(PATTERNS)
                    VALUE = erase(VALUE,PATTERNS{jj});
                end
                
                VALUE = strtrim(VALUE);
                
                if strcmp(PROPERTY,'filters') || strcmp(PROPERTY,'accessories') ||...
                   strcmp(PROPERTY,'software') || strcmp(PROPERTY,'dates') || ...
                   strcmp(PROPERTY,'frames')
                    tmp = strsplit(VALUE,newline);
                    VALUE = '\n';
                    for jj = 1:length(tmp)
                        VALUE = [VALUE, '   - ', strtrim(tmp{jj}), '\n'];
                    end
                end
                
                % If description, Extract the processing details:
                if strcmp(PROPERTY,'description')
                    split = strsplit(VALUE,['Processing Details:',newline]);
                    VALUE = split{1};
                    if length(split) == 2
                        self.processing = split{2};
                    else
                        self.processing = 'N/A';
                    end
                end
                
                VALUE = strtrim(VALUE);
                
                self.(PROPERTY) = VALUE;
            end
        end
    end
    
    methods (Access = public)
        function [] = reddit(self, output_file)
            str = [self.description, '\n\n',...
                   sprintf('[(Original Post on Astrobin)](%s)\n',self.url),...
                   '\n\n *** \n\n',...
                   '## Equipment: \n\n',...
                   sprintf(' - **Imaging Optics:** %s \n',  self.imaging_optics),...
                   sprintf(' - **Imaging Cameras:** %s \n', self.imaging_cameras),...
                   sprintf(' - **Mounts:** %s \n', self.mounts),...
                   sprintf(' - **Filters:** %s\n', self.filters),...
                   sprintf(' - **Accessories:** %s\n', self.accessories),...
                   sprintf(' - **Software:** %s\n', self.software),...
                   sprintf(' - **Guide Scope:** %s\n', self.guiding_scopes),...
                   sprintf(' - **Guide Cameras:** %s\n', self.guiding_cameras),...
                   '\n\n *** \n\n',...
                   '## Aquisition: \n\n',...
                   sprintf(' - **Imaging Dates:** %s \n', self.dates),...
                   sprintf(' - **Frames:** %s \n', self.frames),...
                   sprintf(' - **Total Integration Time:** %s \n', self.integration),...
                   sprintf(' - **Darks:** %s \n', self.darks),...
                   sprintf(' - **Flats:** %s \n', self.flats),...
                   sprintf(' - **Dark Flats:** %s \n', self.flat_darks),...
                   sprintf(' - **Bortle:** %s \n', self.bortle),...
                   '\n\n *** \n\n',...
                   '## Processing: \n\n',...
                   self.processing,...
                   '\n\n *** \n\n',...
                   '## Social Accounts: \n\n',...
                   sprintf('- [%s](%s) on Astrobin \n',self.astrobin_user, self.astrobin_account),...
                   sprintf('- [%s](%s) on Instagram \n',self.instagram_user, self.instagram_account),...
                   ];                   
            
            % Dump formatted string to file:
            fid = fopen(output_file,'wt');
            fprintf(fid, str);
            fclose(fid);
        end
        
        function [] = imgur(self, output_file)
            str = [self.description, '\n\n',...
                   sprintf('Taken with a %s on a %s, using the %s for tracking and %s + %s for auto-guiding.\n\n',...
                   self.imaging_cameras,self.imaging_optics,self.mounts, self.guiding_scopes, self.guiding_cameras),...
                   sprintf('Total Integration time was %s, in a Bortle %s\n\n', self.integration, self.bortle),...
                   sprintf('All details are available on the original post on Astrobin: %s\n\n', self.url),...
                   sprintf('Processed using: %s\n', self.software),...
                   sprintf('Sub Frames Taken: %s\n', self.frames),...
                   'Social Accounts: \n',...
                   sprintf('- %s on Astrobin (%s) \n',self.astrobin_user, self.astrobin_account),...
                   sprintf('- %s on Instagram (%s) \n',self.instagram_user, self.instagram_account),...
                   '\n',self.imgur_hashtags,...
                   ];
            str = erase(str,'*');
            
            % Dump formatted string to file:
            fid = fopen(output_file,'wt');
            fprintf(fid, str);
            fclose(fid);
        end
        
        function [] = instagram(self, output_file)
            str = [self.description, '\n\n',...
                   sprintf('Taken with a %s on a %s, using the %s for tracking and %s + %s for auto-guiding.\n\n',...
                   self.imaging_cameras,self.imaging_optics,self.mounts, self.guiding_scopes, self.guiding_cameras),...
                   sprintf('Total Integration time was %s, in a Bortle %s\n\n', self.integration, self.bortle),...
                  'See my Astrobin account (link in bio) for full resolution Image!\n\n',...
                   sprintf('Processed using: %s\n', self.software),...
                   sprintf('Sub Frames Taken: %s\n', self.frames),...
                   '\n',self.instagram_hashtags,...
                   ];
            str = erase(str,'*');
            str = eraseBetween(str,'(gain','\n');
            str = erase(str,'(gain');
            
            str = strtrim(str);
            
            % Dump formatted string to file:
            fid = fopen(output_file,'wt');
            fprintf(fid, str);
            fclose(fid);
        end
        
        function [] = pinterest(self, output_file)
            str = [self.description, '\n\n',...
                   sprintf('Taken with a %s on a %s, using the %s for tracking and %s + %s for auto-guiding.\n\n',...
                   self.imaging_cameras,self.imaging_optics,self.mounts, self.guiding_scopes, self.guiding_cameras),...
                   sprintf('Total Integration time was %s, in a Bortle %s\n\n', self.integration, self.bortle),...
                  'See my Astrobin account for full image, and additional aquisition details!\n\n',...
                   ];
            str = erase(str,'*');
            str = eraseBetween(str,'(gain','\n');
            str = erase(str,'(gain');
            
            str = strtrim(str);
            
            % Dump formatted string to file:
            fid = fopen(output_file,'wt');
            fprintf(fid, str);
            fclose(fid);
        end
    end
    
end