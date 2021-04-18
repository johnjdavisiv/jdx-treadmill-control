function [speed_commands, treadmill_packet] = set_treadmill_speed(t, speed_m_s, accel_m_s2, both_belts)
%Sets the speed of the treadmill

%Input

% speed_m_s - desired speed, in m/s.

% accel_m_s2 - desired acceleration, in m/s^2

% both_belts - 0 for just right belt, 1 for both

%Outputs

% speed_commands - two element vector as [R_speed, L_speed] in m/s, speeds sent to treadmill

% treadmill_packet - [R_speed_report, L_speed_report, incline_report] vector
                        %units are [mm/s, mm/s, 0.01 deg]

%Safety margins - send treadmill comm also does this but more safety never hurts
min_speed = 0; %Do not allow going in reverse
max_speed = 6; %This is under 5min mile pace! Too fast!
%Acceleration limit (absolute value, used for acceleration and deceleration)
accel_limit = 1.0; %m/s^2
%can adjust as needed BUT BE CAREFUL! Treadmill is very powerful.

%% Check input

if max([size(speed_m_s), size(accel_m_s2), both_belts]) ~= 1
    error('Problem setting speed: Please input only scalars, not vectors!');
end

accel_m_s2 = abs(accel_m_s2);

if speed_m_s < min_speed
    speed_m_s = min_speed;
    warning('Speed below zero, overriding with speed = 0 m/s');
end

if speed_m_s > max_speed
    speed_m_s = 0;
    warning('Speed above upper limit, overriding with speed = 0 m/s');
end

if accel_m_s2 > accel_limit
    accel_m_s2 = accel_limit;
    warning(['Requested acceleration above upper limit, overriding with acceleration = ', ...
        num2str(accel_limit), ' m/s^2']);
end

%% One belt or both?

if both_belts
    R_speed = speed_m_s;
    L_speed = speed_m_s;
else
    R_speed = speed_m_s;
    L_speed = 0;
end

speed_commands = [R_speed, L_speed];

%% Get payload and send/receive

% Ordering to payload is: get_payload(speed_R, speed_L, accel_R, accel_L, incline)
payload = get_payload(R_speed, L_speed, accel_m_s2, accel_m_s2, 0);

%Inside try-catch in case errors happen
try
    [R_speed_report, L_speed_report, incline_report] = send_treadmill_command(payload,t);
catch exc
    warning('Caught an exception when sending command!');
    disp(exc); %?? not sure if useful
    
    R_speed_report = NaN;
    L_speed_report = NaN;
    incline_report = NaN;
end

%fprintf(1, 'Setting treadmill speed to %.3f m/s\n', speed_m_s)

%Empty for now
treadmill_packet = [R_speed_report, L_speed_report, incline_report];

end