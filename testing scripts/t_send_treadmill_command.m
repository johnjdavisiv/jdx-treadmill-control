function [R_speed, L_speed, incline] = send_treadmill_command(payload,t)

%Send a TCP command to bertec treadmill
% JJD 2021-04-17 based on smsong 2019

%Inputs

% payload - a byte payload from get_payload() that specifices belt speeds and accelerations

% Outputs

% R_speed - speed of right belt in m/s (? or maybe mm?) - or may have to translate back from bytes
% L_speed - speed of left belt in m/s (?)
% incline - incline of treadmill in degrees (? or maybe centi-deg?)

%Send command via TCP
fwrite(t,payload,'uint8');

% Read reply sychronously - should yield latest packet
read_format = fread(t,1,'uint8');
speeds = fread(t,4,'int16'); %4x int16 vector for belt speed in mm/s (?)
R_speed = speeds(1);
L_speed = speeds(2);

incline = fread(t,1,'int16');
padding = fread(t,21,'uint8');

%Note - OG code has some while-loop antics to read older messages, unsure if needed

end

