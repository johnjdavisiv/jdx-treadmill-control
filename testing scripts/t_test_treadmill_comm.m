function t_test_treadmill_comm()

%Call this to connect to treadmill via TCP/IP, send a commmand to send all belts to 0, and report
%results

fprintf(1, 'Attempting to connect to treadmill...\n');
t = t_open_treadmill_comm();

%Send a speed command of 0 m/s to both treadmill belts and see if it works
accel_m_ss = 0.25; %m/s^2
speed_m_s = 0.0; %m/s

fprintf(1, 'Generating payload...\n');
%Generate payload: speed_R, speed_L, accel_R, accel_L, incline
payload = get_payload(speed_m_s, speed_m_s, accel_m_ss, accel_m_ss, 0);

%Send out treadmill payload via TCP and read response from treadmill
fprintf(1, 'Sending payload...\n');
[R_speed, L_speed, incline] = send_treadmill_command(payload,t);

%Print reported results
fprintf(1,'-----------------------------------\n');
fprintf('Treadmill packet data: \n\nRight belt speed: %.3f m/s\nLeft belt speed: %.3f m/s\nIncline: %.2f degrees\n', ...
    R_speed, L_speed, incline);
fprintf(1,'-----------------------------------\n');

%Close comms
t_close_treadmill_comm(t);
fprintf(1, 'Treadmill connection closed.\n')




end

