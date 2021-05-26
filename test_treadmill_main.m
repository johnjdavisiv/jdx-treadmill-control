% Test script to see treadmill stuff on tcpip echo
% JJD
% 2021-04-17

%Random note, watch out for TCPIP timeouts (10-20sec?)
% Another one, should wrap fwrite and fread in try-cathc blocks
%  that can try to correct if the connection gets dropped
%See
%https://www.mathworks.com/help/instrument/tcpclient.html#mw_5a853e8e-509f-4e25-9ae1-39d15735f1c3
%for some solutions to baking in error "correction"


%See also BytesAvailableFcn  for some potential issues
% Or use the while loop fix in whoevers' code

%On Icarus only
cd("C:\Users\johnj\Google Drive\IU Grad school\Dissertation\Code\JDX MATLAB\Treadmill control")

warning('THIS IS A NONFUNCTIONAL TEST SCRIPT!');

addpath('./functions', './treadmill comms', './testing scripts');

%Get subject code and perferred run pace in minutes per mile
[sub_code, pref_run_pace, protocol_color] = get_subject_pace();

%Error check for input pace
%validate_run_pace(pref_run_pace_min_mi);

%Get the speeds for each trial of experiment
[trial_speeds_m_s, trial_start, trial_end, walk_ind] = get_trial_speeds_from_pace(pref_run_pace, protocol_color);

%Check the TCP/IP connection with treadmill
t_test_treadmill_comm();

%Print exeriment details to console
print_experiment_info(sub_code, pref_run_pace, protocol_color);

%Confirm experiment start
confirm_start_experiment();


%Open connection
t = t_open_treadmill_comm();


%% While-loop to go through trials
run_experiment(sub_code, protocol_color, t, trial_speeds_m_s, trial_start, trial_end, walk_ind);

%Close connection
t_close_treadmill_comm(t);
clear t;
fprintf(1, '-----------------------------------------\n');
fprintf(1, '-----------------------------------------\n');
fprintf(1, 'Finished local test successfully\n');


%Maybe the best way to do it is to just send/receive packets over the same open TCPIP connection
%Even if the speed is the same, just re-send every second or whatever

%Seems to ignore issues with opening/closing mayn TCPIP connection