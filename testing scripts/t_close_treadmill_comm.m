function t_close_treadmill_comm(t)
% Closes TCP connection to treadmill
%JJD adapted from smsong 2019

%Testing version on localhost

%Input
%t - a treadmill TCP connection opened via open_treadmill_comms()

fclose(t);
echotcpip('off')
delete(t);

end

