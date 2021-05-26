function print_experiment_info(sub_code, pref_run_pace, protocol_color)
%Display a summary of the experimental info to the console

%Could also midfy with "color" so I knwo waht the percents are

pace_min = floor(pref_run_pace);
pace_sec = floor(60*(pref_run_pace - pace_min)); %Floor avoids edge case of e.g 9.99 minutes

%Display a text summary of the experiment speeds and duration

%Get the speeds for each trial of experiment
[trial_speeds_m_s, trial_start, trial_end, ~] = get_trial_speeds_from_pace(pref_run_pace, protocol_color);

fprintf(1, '***************************************************\n');
fprintf(1, '***************************************************\n');
fprintf(1, '   JDX Experimental Protocol for subject %s        \n', sub_code);
fprintf(1, '\n');
fprintf(1, '         Preferred run pace: %i:%02i/mi\n', pace_min, pace_sec);
fprintf(1, '***************************************************\n');
fprintf(1, '***************************************************\n');
fprintf(1, '                 PROTOCOL SCHEDULE: \n');


fprintf(1, '  Trial  | Duration |   m/s   |   mph    |   min/mi  \n');
for a=1:length(trial_start)
    
    %Compute speeds
    this_mph = trial_speeds_m_s(a)*2.237;
    
    if this_mph > 0
        this_min_mi_dec = 1/(this_mph/60);   
        this_min = floor(this_min_mi_dec);
        this_sec = floor(60*(this_min_mi_dec - this_min));
    else
        %Really just for walk
        this_min = 0;
        this_sec = 0;
    end
    
    %fprintf('% 5d\n', 12) %
    %prints 12 in 5 characters, padding the un-used 3 leading characters with spaces.
    
    fprintf(1, '   % 4i  |  % 4.1f    | % 5.2f   |  % 5.1f   |  % 4i:%02i  \n', ...
        a, trial_end(a) - trial_start(a), trial_speeds_m_s(a), ...
        this_mph, this_min, this_sec)

end
fprintf(1, '***************************************************\n');


end

