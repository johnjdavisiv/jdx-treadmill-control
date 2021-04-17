function confirm_start_experiment()

response = '';

while ~matches(upper(response), 'Y')
    
    response = input('Waiting to start experiment, enter Y when ready...\n', 's');

end

disp('Beginning experiment!')
