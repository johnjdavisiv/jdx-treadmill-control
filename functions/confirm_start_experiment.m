function confirm_start_experiment()

response = '';

while ~strcmpi(response, 'Y')
    fprintf(1, '***************************************************\n');
    fprintf(1, '\n');
    fprintf(1, '        PAUSE POINT! Go through checklist\n')
    fprintf(1, '\n');
    response = input('Waiting to start experiment, enter Y when ready...\n', 's');

end

fprintf(1, '***************************************************\n');
fprintf(1, '***************************************************\n');
fprintf(1, '\n');
fprintf(1, '                Beginning experiment!\n');
fprintf(1, '\n');
fprintf(1, '***************************************************\n');
fprintf(1, '***************************************************\n');