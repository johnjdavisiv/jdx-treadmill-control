function [trial_speeds_m_s, trial_start_times, trial_end_times, walk_ind] = get_trial_speeds_from_pace(pref_run_pace_min_mi)
%Given a person's preferred run speed in minutes per mile (decimal), get trial speeds
%and trial durations in meters per second and minutes

%Eventually this will ahve to do randomization as well! Maybewith input argument?
%Or random seed?


%Output


%walk_ind - vector of zeros and ones, with 1 where a trial is walking (need both belts) or 0
%(running)

%COnvert preferred run pace to speed in meters per second
pref_run_speed_m_s = 1/(pref_run_pace_min_mi*60/1609.344);

% --- Instructions - standing on treadmill ---
intro_speed = 0; %m/s
intro_dur = 1; %minutes

% --- Walk warmup ---
walk1 = 1.1; %m/s, about 2.5 mph
walk1_dur = 1.5; %minutes
walk2 = 1.6; %m/s, about 3.5 mph
walk2_dur = 1.5; %minutes

% --- Run warmup ---
warmup_speeds = [70, 75]; %percent of typical run speed for 45min run
warmup_dur = [3,3]; %minutes

% --- Randomized block ---
mid_speeds = [80,85,90,95,100,105,110,115]; %percent
mid_dur = [3,3,3,3,3,3,3,3]; %in minutes

% --- Fast interval portion ---
interval_speeds = [75,120,75,125,75,130]; %percent
interval_dur    = [2,2,2,2,2,1]; %minutes

% --- Walk cooldown ---
walk3 = 1.3; %m/s, about 2.9 mph
walk3_dur = 2;  %minutes

%Work out the percentages of typical run speed, add to protocol
individualized_speeds = pref_run_speed_m_s*[warmup_speeds, mid_speeds, interval_speeds]/100;
trial_speeds_m_s = [intro_speed, walk1, walk2, individualized_speeds, walk3];
full_dur = [intro_dur, walk1_dur, walk2_dur, warmup_dur, mid_dur, interval_dur, walk3_dur];

%When will each trial start and end (in minutes?)
trial_start_times = [0, cumsum(full_dur(1:end-1))];
trial_end_times = cumsum(full_dur);


%Walk indicator
walk_ind = zeros(size(full_dur));

%Set walking
walk_ind(1:3) = 1; %"walk" for intro, walk1, walk2
walk_ind(end) = 1; %walk cooldown

%To column vecs
trial_speeds_m_s = trial_speeds_m_s(:);
trial_start_times = trial_start_times(:);
trial_end_times = trial_end_times(:);
walk_ind = walk_ind(:);


%Validate
if size(trial_speeds_m_s,1) ~= size(trial_start_times,1) || ...
        size(trial_speeds_m_s,1) ~= size(trial_end_times,1) || ...
        size(trial_start_times,1) ~= size(trial_end_times,1)
    error('Mismatched trial vectors! Something went wrong!');
end

end

