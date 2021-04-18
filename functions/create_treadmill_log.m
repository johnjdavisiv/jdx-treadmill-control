function log_fname = create_treadmill_log(sub_code, exp_start_time)

%Create a log file as csv for this treadmill session, return file name and path

save_path = 'treadmill logs/';

iso_date = datestr(exp_start_time, 'yyyy_mm_dd');
start_time_str = datestr(exp_start_time, 'HH_MM_SS');

%Troubleshooting
%log_fname = [save_path, 'foobar.csv'];

%Original
log_fname = [save_path,'JDX_treadmill_log_subject_', sub_code, '_protocol_XXX_', ...
    'date_', iso_date, '_time_', start_time_str, '.csv'];

%Create the log file
fid = fopen(log_fname, 'w');

%Write first line
fprintf(fid, '%s, %s, %s, %s, %s, %s, %s\n', 'posix_timestamp', ...
    'elapsed_time', 'R_speed_command', 'L_speed_command', ... 
    'R_belt_speed', 'L_belt_speed', 'incline');

fclose(fid);

%JDX_treadmill_log_subject_[SUBJ]_protocol_[color]_date_[ISO date]_time_[hh_mmm_ss].csv

%Iteratively fopen() and fclose() this file as we update
%Columns should be:
% timestamp, elasped_time, R_belt_speed, L_belt_speed, incline


end

