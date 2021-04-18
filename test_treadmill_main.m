% Test script to see treadmill stuff on tcpip echo
% JJD
% 2021-04-17

%On Icarus only
cd("C:\Users\johnj\Google Drive\IU Grad school\Dissertation\Code\JDX MATLAB code\Treadmill control")

addpath('./functions', './treadmill comms', './testing scripts');

%Get subject code and perferred run pace in minutes per mile
[sub_code, pref_run_pace] = get_subject_pace();

%Get the speeds for each trial of experiment
[trial_speeds_m_s, trial_start, trial_end, walk_ind] = get_trial_speeds_from_pace(pref_run_pace);

%Print exeriment details to console
print_experiment_info(sub_code, pref_run_pace);

%Check the TCP/IP connection with treadmill
t_test_treadmill_comm();

%Open connection
t = t_open_treadmill_comm();

%Confirm experiment start
confirm_start_experiment();

%% While-loop to go through trials
run_experiment(sub_code, t, trial_speeds_m_s, trial_start, trial_end, walk_ind);

%Close connection
t_close_treadmill_comm(t);
clear t;
fprintf(1, '-----------------------------------------\n');
fprintf(1, '-----------------------------------------\n');
fprintf(1, 'Finished local test successfully\n');


%Maybe the best way to do it is to just send/receive packets over the same open TCPIP connection
%Even if the speed is the same, just re-send every second or whatever

%Seems to ignore issues with opening/closing mayn TCPIP connection