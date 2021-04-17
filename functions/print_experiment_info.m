function print_experiment_info(sub_code, pref_run_pace_min_mi)
%Display a summary of the experimental info to the console

pace_min = floor(pref_run_pace_min_mi);
pace_sec = floor(60*(pref_run_pace_min_mi - pace_min)); %Floor avoids edge case of 9.99 minutes

disp('**************************************************');
disp('');
fprintf(1, "Protocol for %s: preferred run pace %i:%i/mi\n", sub_code, pace_min, pace_sec);
disp('');
disp('**************************************************');

end

