function treadmill_packet = set_treadmill_speed(speed_m_s)
%Sets the speed of the treadmill

%speed_m_s - desired speed, in METERS PER SECOND.

%Acceleration limit (absolute value, used for acceleration and deceleration)
accel_m_ss = 0.25; %m/s^2
%can adjust as needed BUT BE CAREFUL! Treadmill is very powerful.

lower_limit = 0; %Do not allow going in reverse
upper_limit = 5.4; %This is 5min mile pace! Too fast!

if speed_m_s < lower_limit
    speed_m_s = lower_limit;
    warning('Speed below zero, overriding with speed = 0 m/s');
end

if speed_m_s > upper_limit
    speed_m_s = 0;
    warning('Speed above upper limit, overriding with speed = 0 m/s');
end

packet_speed = speed_m_s*1000;
packet_accel = accel_m_ss*1000;

try
    %communicate_with_treadmill()
catch exc
    warning('Caught an exception!')
end

%SetTreadmillSpeed(packet_speed, packet_accel)
%Set the speed using the TCP/IP connection...

fprintf(1, 'Setting treadmill speed to %.3f m/s\n', speed_m_s)

%Empty for now
treadmill_packet = [1,2,3]';

end