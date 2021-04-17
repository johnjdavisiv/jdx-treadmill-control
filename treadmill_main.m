% Treadmil control main
% JJD
% 2021-04-17

%Get subject code and perferred run pace in minutes per mile
[sub_code, pref_run_pace_min_mi] = get_subject_pace();

%Get the speeds for each trial of experiment
[speeds_m_s, durations_min] = get_trial_speeds_from_pace(pref_run_pace_min_mi);

%Print exeriment details to console
print_experiment_info(sub_code, pref_run_pace_min_mi);

%Confirm experiment start
confirm_start_experiment();

