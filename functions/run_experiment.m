function run_experiment(trial_speeds_m_s, trial_start, trial_end, walk_ind)
%Run treadmill protocol given speeds in m/s and trial start/end times


%Inputs




%Outputs




%Log start time
experiment_start_time = datetime('now', 'TimeZone', 'local');

%Start timer
t_tic = tic;
halt_exp = 0;
last_loop_trial = 1;

while ~halt_exp
    %Elapsed time and timestamp
    
    %Toc always returns float seconds
    elapsed_time = toc(t_tic); %IMPORTANT --- do *60 to convert to minutes for actual trial
    timestamp = posixtime(datetime('now', 'TimeZone', 'local'));
    
    %What trial are we on?
    current_trial = find(trial_start < elapsed_time, 1,'last');
    current_speed_m_s = trial_speeds_m_s(current_trial);

    %Elapsed time in this trial is difference between elapsed time and when trial started
    trial_elapsed_time = elapsed_time - trial_start(current_trial);
    
    %Trial progress (as a float from 0 to 1)
    trial_progress = trial_elapsed_time/(trial_end(current_trial) - trial_start(current_trial));

    if current_trial > last_loop_trial
        last_loop_trial = current_trial; 
        fprintf(1, '   ****** Trial %i completed! *******', current_trial-1);
    end
    
    %Do this in a function, with try-catch functionality
    
    
    %Also need to know if walking or running, because belts!
    treadmill_packet = set_treadmill_speed(current_speed_m_s);
    
    %Pause/delay
    pause(0.5);
    

end



end

