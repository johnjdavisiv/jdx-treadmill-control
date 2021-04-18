function progress_bar(prog)
% Display a progress bar
% prog: percent progress, float between 0 and 1
bar_width = 32;

%Programmatically generate progress bar
complete_bars = round(prog/100*bar_width);
incomplete_bars = bar_width - complete_bars;

%If we overmax, threshold
if complete_bars > bar_width
    complete_bars = bar_width;
    incomplete_bars = 0;
end

%Weirdness when no bars
if complete_bars > 0
    complete_str = repelem('=', complete_bars - 1);
    incomplete_str = repelem('-', incomplete_bars);
else
    complete_str = '';
    incomplete_str = repelem('-', incomplete_bars-1);
end

bar_str = [complete_str, '>', incomplete_str, ' %3.0f%%\n'];

erase_str = strcat(repmat('\b',1,bar_width+6), bar_str);

fprintf(erase_str, min([prog,100]));
end

