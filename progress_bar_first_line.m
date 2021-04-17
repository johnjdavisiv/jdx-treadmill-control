function progress_bar_first_line()
%Print first line of the progress bar
bar_width = 32; %progress bar width in charcaters
first_line = ['Trial progress: ', repelem('-', bar_width-1), ' %3d%%\n'];
fprintf(1, first_line, 0.00);

end

