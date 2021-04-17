function [R_speed, L_speed, incline] = sendTreadmillPacket(payload,t)


fwrite(t,payload,'uint8');

% Read reply
read_format = fread(t,1,'uint8');
speeds = fread(t,4,'int16');
R_speed = speeds(1);
L_speed = speeds(2);

incline = fread(t,1,'int16');
padding = fread(t,21,'uint8');

end

