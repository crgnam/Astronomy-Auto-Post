classdef AstrobinKey < handle
    properties
        % Keys for Start/Stop patterns of each segment:
        title           = {'<title>', '</title>'};
        
        description     = {['Description',newline,'</h4></div><div class="body">'], '</div>'};
        
        imaging_optics  = {'Imaging Telescopes Or Lenses</dt><dd>', '</dd>'};
        
        imaging_cameras = {'Imaging Cameras</dt><dd>', '</dd>'};
        mounts          = {'Mounts</dt><dd>',          '</dd>'};
        filters         = {'Filters</dt><dd>',         '</dd>'};
        accessories     = {'Accessories</dt><dd>',     '</dd>'};
        software        = {'Software</dt><dd>',        '</dd>'};
        
        guiding_scopes  = {'Guiding Telescopes Or Lenses</dt><dd>', '</dd>'};
        guiding_cameras = {'Guiding Cameras</dt><dd>',              '</dd>'};
        
        dates           = {'Dates:</dt><dd>',       '</dd>'};
        frames          = {'Frames:</dt><dd>',      '</dd>'};
        integration     = {'Integration:</dt><dd>', '</dd>'};
        darks           = {'Darks:</dt><dd>',       '</dd>'};
        flats           = {'Flats:</dt><dd>',       '</dd>'};
        flat_darks      = {'Flat darks:</dt><dd>',  '</dd>'};
        
        avg_moon_age    = {'Avg. Moon age:</dt><dd>',         '</dd>'};
        avg_moon_phase  = {'Avg. Moon phase:</dt><dd>',       '</dd>'};
        bortle          = {'Bortle Dark-Sky Scale:</dt><dd>', '</dd>'};
        
        ra_center       = {'RA center:</strong>',    '</abbr>'};
        dec_center      = {'DEC center:</strong>',   '</abbr>'};
        pixel_scale     = {'Pixel scale:</strong>',  '</p><p>'};
        orientation     = {'Orientation:</strong>',  '</p><p>'};
        field_radius    = {'Field radius:</strong>', '</p><p>'};
    end
    
    methods
        function [self] = AstrobinKey()
            
        end
    end
end