matlabrc; clc; close all;

% url = 'https://www.astrobin.com/2qp1rf/'; % Crescent Nebula
% url = 'https://www.astrobin.com/1svns4/'; % Horsehead Nebula (IC 434)
% url = 'https://www.astrobin.com/ph38kj/'; % Rosette Nebula (C 49)
% url = 'https://www.astrobin.com/h0senn/'; % Monkey Head Nebula (NGC 2174)
url = 'https://www.astrobin.com/x00qjq/'; % Comet C/2022 e3
% url = 'https://www.astrobin.com/au6pxd/'; % Pleiades

astrobin_data = AstrobinData(url, AstrobinKey);

astrobin_data.reddit('reddit.md');

astrobin_data.imgur('imgur.txt');

astrobin_data.instagram('instagram.txt');

astrobin_data.pinterest('pinterest.txt');