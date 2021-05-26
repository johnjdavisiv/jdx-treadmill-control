function [sub_code, pref_run_pace, protocol_color] = get_subject_pace()
% Get the string code of subject, and per-mile pace of typical 45min run
%Command line is fine...

%Outputs

%sub_code - subject code, string. Example 'S001'
%pref_run_pace - subject's typical run pace for a 45min training run, in minutes per mile (decimal)
%       Example: 8.5 for 8:30/mi pace

fprintf('Enter subject code. Example: S000\n')
fprintf('--------------------------------------------------------\n');
sub_code = input('Subject code: ', 's');

pace_valid = 0;

while ~pace_valid
    fprintf('Enter preferred run pace in minutes per mile. \nExample: 8.5 for 8:30/mi pace\n');
    fprintf('--------------------------------------------------------\n');
    pref_run_pace = str2double(input('Preferred run pace: ', 's'));

    %Check for valid numbers
    if isa(pref_run_pace, 'float') && ...
            ~isnan(pref_run_pace) && ...
            max(size(pref_run_pace)) == 1 && ...
            pref_run_pace > 5 && ...
            pref_run_pace < 16
        pace_valid = 1;
    else
        fprintf('--------------------------------------------------------\n');
        fprintf('   ***   Entry not valid, please re-enter!   ***\n');
        fprintf('--------------------------------------------------------\n');
    end
end


%Get randomized protocol
protocol_valid = 0;

while ~protocol_valid
    fprintf('Which speed protocol has been assigned to this subject?\n(one of RED, BLU, GRN, YEL)\n');
    fprintf('--------------------------------------------------------\n');
    protocol_color = upper(input('Assigned protocol: ', 's'));

    
    %Check for valid numbers
    if strcmp(protocol_color, 'RED') || ...
            strcmp(protocol_color, 'BLU') || ...
            strcmp(protocol_color, 'GRN') || ...
            strcmp(protocol_color, 'YEL')
        protocol_valid = 1;
    else
        fprintf('--------------------------------------------------------\n');
        fprintf('   ***   Entry not valid, please re-enter!   ***\n');
        fprintf('--------------------------------------------------------\n');
    end
end


fprintf('--------------------------------------------------------\n');
fprintf('Preparing experimental protocol...\n\nSUBJECT:               %s\nPREFERRED RUN PACE:    %.2f minutes per mile\nPROTOCOL:              %s\n',...
    sub_code, pref_run_pace, protocol_color);
fprintf('--------------------------------------------------------\n');

end

