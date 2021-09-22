%General thoughts

%Testing PAT

%Should define four(ish) protocols, based on percentages of typical run pace

%When you call the script, you input that protocol as an input
%e.g. run_JDX_protocol.m gets user input from command prompt (or GUI buttons)

%Then brings up a display of the paces and their ordering, and the protocol name (to confirm)

%Wait for user input to being (do on a cue from audio recording)

%When protocol starts, start a timer with tic/toc
%Also create a log file with a formalized name

%JDX_treadmill_log_subject_[SUBJ]_protocol_[color]_date_[ISO date]_time_[hh_mmm_ss].csv

%Iteratively fopen() and fclose() this file as we update
%Columns should be:
% timestamp, elasped_time, L_belt_speed, L_belt_accel, R_belt_speed, R_belt_accel
%Update every 1sec? Or whenever. Just need to make sure IO is not slowing down the script 

%In a while loop:

% Check elapsed time
% Check to see if we need to change the treadmill speed / advance to next segment
% ---  Probably this will work by iterating through a list of speeds and updating as time goes by
% If it's time to change treadmill speed, send a signal to readmill to change speed
% --- walking to running will have some special considerations probably
% Log current speed and acceleration in the log file
% Update progress bar
%
% Probably want to keep the TCP connection open to log stuff? 


%Errors??
%Maybe try-catch in the loop


%% Set up speed and duration vectors

intro_speed = 0; %mph
intro_dur = 1; %minutes

walk1 = 2.5; %mph
walk1_dur = 1.5; %minutes

walk2 = 3.5; %mph
walk2_dur = 1.5; %minutes

%random portion
warmup_speeds = [70, 75]; %percent
warmup_dur = [3,3]; %minutes

mid_speeds = [80,85,90,95,100,105,110,115]; %percent of typical run speed for 45min run
mid_dur = [3,3,3,3,3,3,3,3]; %in minutes

interval_speeds = [75,120,75,125,75,130]; %percent
interval_dur    = [2,2,2,2,2,1]; %minutes

walk3 = 2.5; %mph
walk3_dur = 2;  %minutes

individualized_speeds = perc_to_mph(run_pace_min_mi, [warmup_speeds, mid_speeds, interval_speeds]);

full_speeds = [intro_speed, walk1, walk2, individualized_speeds, walk3];
full_dur = [intro_dur, walk1_dur, walk2_dur, warmup_dur, mid_dur, interval_dur, walk3_dur];

trial_start_times = [0, cumsum(full_dur(1:end-1))];
trial_end_times = cumsum(full_dur);
%For reference / display
%[trial_start_times', trial_end_times']

%% Run experiment!

%Progress bar is a neat trick but might distract from the important stuff

%So it *seems* like the acceleratin parameter only affects the rate of change when velocity changes
%as in you don't need to set it to zero to keep a constant speed, you jsut update the speed as
%needed

progress_bar_first_line()

t_tic = tic;

%In the loop, if we advance through a trial, then update to a new trial! print a line, restart
%prgoress var

%For testing can interpret durations as seconds...
%While loop?

halt_exp = 0;
last_loop_trial = 1;

while ~halt_exp
    %toc always returns seconds
    elapsed_time = toc(t_tic); %convert to minutes later!
    %trial_times shows what time each trial ENDS, so current_trial(1) ends after that many minutes
    current_trial = find(trial_start_times < elapsed_time,1, 'last');
    current_speed = full_speeds(current_trial);
    
    
    %Elapsed time in this trial is difference between elapsed time and when trial started
    trial_elapsed_time = elapsed_time - trial_start_times(current_trial);
    
    %Get treadmill log
    %treadmill_log = get_treadmill_log(remote_con);
    %Write treadmill log to csv?
    
    %Is this a new trial? If so, display that we completed the last one and print a new progress bar
    %Also change treadmill speed
    if current_trial > last_loop_trial
        last_loop_trial = current_trial;
        %Update progress bar to 100
        progress_bar(100);
        %New line and new bar
        fprintf('     ****** Trial %i completed! ******     \n', current_trial-1);
        
        %Change speed
        set_treadmill_speed(current_speed/10);
        
        %New progress bar
        progress_bar_first_line()
    end
    
    
    %Percent of this trial completed is current trial elapsed time over total duration of this trial
    trial_progress = trial_elapsed_time/(trial_end_times(current_trial) - trial_start_times(current_trial));
    progress_bar(trial_progress*100);    
    %Can get timestamp with clock
    %[year month day hour minute seconds] = clock
    %c = clock
    
    pause(0.23);
    
    if elapsed_time > trial_end_times(end)
        halt_exp =1;
    end
end



%% asdfadsfadsf



%Eventually would randomize mid_speeds
% Could even do programmatically for each subject uniquely (instead of red, blu, grn, etc)
%Some error checking stuff for abnormal speeds/paces entered
disp('Starting protocol...');

for a=1:10
    fprintf(1, 'Trial %i\n', a);
    
    pause(1.5);
    
    new_speed = rand()*5;
    
    set_treadmill_speed(new_speed)
    
    
end

disp('Protocol finished!');
    




function mph_vec = perc_to_mph(run_pace_min_mi, percent_vec)

%Translate a vector of percents (as integers! e.g. 70 = 70% typical run pace)
%into miles per hour on treadmill setting 
%(eventually set to mm/s)
run_pace_mph = 1/(run_pace_min_mi/60);
mph_vec = percent_vec/100*run_pace_mph;

end
