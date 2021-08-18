function write_protocol_plan(trial_array, sub_code)
%Input is usually
%trial_array = [trial_speeds_m_s, trial_start, trial_end, walk_ind]

protocol_table = array2table(trial_array, ...
    'VariableNames', {'trial_speeds_m_s','trial_start','trial_end','walk_ind'});


save_path = 'protocol logs/';

today_time = datetime('now');
iso_date = datestr(today_time, 'yyyy_mm_dd');
start_time_str = datestr(today_time, 'HH_MM_SS');

%Original
log_fname = [save_path,'JDX_treadmill_log_subject_', sub_code, ...
    '_protocol_', protocol_color, ...
    '_date_', iso_date, '_time_', start_time_str, '.csv'];

writetable(protocol_table, log_fname);

end

