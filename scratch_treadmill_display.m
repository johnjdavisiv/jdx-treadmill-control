% Play around with some simulations of what the treadmill control might look like

imax = 31;

bar_width = 32; %progress bar width in charcaters
first_line = ['Trial progress: ', repelem('-', bar_width-1), ' %3d%%\n'];
fprintf(1, first_line, 0.00);
%% asdfadsf

progress_bar_first_line()

for k = 1:imax
	prog = 100*(k/imax);
    %Shopped out to an external function
    progress_bar(prog)    
    
	%fprintf(1,'\b\b\b\b%3.0f%%',prog); 
    pause(0.1); % Deleting 4 characters (The three digits and the % symbol)
end
fprintf('\n'); % To go to a new line after reaching 100% progress



%% Not jittering

imax = 100;
prog = 0;
fprintf(1,'Computation Progress: %3d%%\n',prog);
for k = 1:1:imax
	prog = ( 100*(k/imax) );
	fprintf(1,'\b\b\b\b%3.0f%%',prog); pause(0.1); % Deleting 4 characters (The three digits and the % symbol)
end
fprintf('\n'); % To go to a new line after reaching 100% progress
