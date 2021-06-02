function [trial_speeds_m_s, trial_start_times, trial_end_times, walk_ind] = get_trial_speeds_from_pace(pref_run_pace_min_mi, protocol_color)
%Given a person's preferred run speed in minutes per mile (decimal), get trial speeds
%and trial durations in meters per second and minutes

%21 May 2021
%Updated with latest protocol speeds and durations


%Output


%walk_ind - vector of zeros and ones, with 1 where a trial is walking (need both belts) or 0
%(running)

%COnvert preferred run pace to speed in meters per second
pref_run_speed_m_s = 1/(pref_run_pace_min_mi*60/1609.344);

% --- Instructions - standing on treadmill ---
%Note: this program does not start at the same time as the audio! 
%The "instructions" portion of this script is SHORTER. at audio 2:30, we start this program.
%So for 5min of instructions, this program only runs for 2.5 minutes.
intro_speed = 0; %m/s
intro_dur = 2.5; %minutes

% --- Walk warmup ---
walk1 = 1.12; %m/s, about 2.5 mph
walk1_dur = 1.5; %minutes
walk2 = 1.56; %m/s, about 3.5 mph
walk2_dur = 1.5; %minutes

% --- Run warmup ---
warmup_speeds = [70, 75]; %percent of typical run speed for 45min run
warmup_dur = [3,3]; %minutes

% --- Randomized block ---

switch protocol_color
    case 'RED'
        mid_speeds = [90,85,105,95,115,80,100,110];
    case 'BLU'
        mid_speeds = [105,90,85,110,100,80,95,115];
    case 'GRN'
        mid_speeds = [85,80,90,95,115,100,110,105];
    case 'YEL'
        mid_speeds = [110,95,100,85,90,115,105,80];
    otherwise
        error('Protocol color not recognized!')
end

mid_dur = [3,3,3,3,3,3,3,3]; %in minutes

% --- Fast interval portion ---
interval_speeds = [80,120,80,125]; %percent
interval_dur    = [2,2,2,2]; %minutes

% --- Walk cooldown ---
walk3 = 1.12; %m/s, about 2.5 mph
walk3_dur = 2;  %minutes

% --- Ending jumps and end insructions ---
ending_speed = 0;
ending_dur = 1.5;

%Work out the percentages of typical run speed, add to protocol
individualized_speeds = pref_run_speed_m_s*[warmup_speeds, mid_speeds, interval_speeds]/100;
trial_speeds_m_s = [intro_speed, walk1, walk2, individualized_speeds, walk3, ending_speed];
full_dur = [intro_dur, walk1_dur, walk2_dur, warmup_dur, mid_dur, interval_dur, walk3_dur, ending_dur];

%When will each trial start and end (in minutes?)
trial_start_times = [0, cumsum(full_dur(1:end-1))];
trial_end_times = cumsum(full_dur);


%Walk indicator
walk_ind = zeros(size(full_dur));

%Set walking
walk_ind(1:3) = 1; %"walk" for intro, walk1, walk2
walk_ind(end-1:end) = 1; %walk cooldown, also "walk" for ending instructions

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

