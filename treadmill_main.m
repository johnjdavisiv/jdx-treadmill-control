% Treadmil control main
% JJD
% 2021-05-21

addpath('./functions', './treadmill comms');

%Get subject code and perferred run pace in minutes per mile
[sub_code, pref_run_pace, protocol_color] = get_subject_pace();

%Error check for input pace
%validate_run_pace(pref_run_pace_min_mi);

%Get the speeds for each trial of experiment
[trial_speeds_m_s, trial_start, trial_end, walk_ind] = get_trial_speeds_from_pace(pref_run_pace, protocol_color);

%Save planned speeds
write_protocol_plan(trial_array, sub_code);

%Check the TCP/IP connection with treadmill
test_treadmill_comm();

%Print exeriment details to console
print_experiment_info(sub_code, pref_run_pace, protocol_color);

%Confirm experiment start
confirm_start_experiment();

%Open connection
t = open_treadmill_comm();

%While-loop to go through trials
run_experiment(sub_code, protocol_color, t, trial_speeds_m_s, trial_start, trial_end, walk_ind);

%Close connection
close_treadmill_comm(t);
clear t;


%Maybe the best way to do it is to just send/receive packets over the same open TCPIP connection
%Even if the speed is the same, just re-send every second or whatever

%Seems to ignore issues with opening/closing mayn TCPIP connection