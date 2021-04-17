function [sub_code, pref_run_pace] = get_subject_pace()
% Get the string code of subject, and per-mile pace of typical 45min run
%Command line is fine...

%Outputs

%sub_code - subject code, string. Example 'S001'
%pref_run_pace - subject's typical run pace for a 45min training run, in minutes per mile (decimal)
%       Example: 8.5 for 8:30/mi pace

fprintf('Enter subject code. Exaple: S000\n')
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
            pref_run_pace < 15
        pace_valid = 1;
    else
        fprintf('--------------------------------------------------------\n');
        fprintf('   ***   Entry not valid, please re-enter!   ***\n');
        fprintf('--------------------------------------------------------\n');
    end
end

fprintf('--------------------------------------------------------\n');
fprintf('Preparing experimental protocol...\nSUBJECT:            %s\nPREFERRED RUN PACE: %.2f minutes per mile\n',...
    sub_code, pref_run_pace);
fprintf('--------------------------------------------------------\n');

end

