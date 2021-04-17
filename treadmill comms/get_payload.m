function payload = get_payload(speed_R, speed_L, accel_R, accel_L, incline)
%get parsed payload of byte data to send to treadmill
%JJD 2021-04-17
% based off smsong 2019


% Inputs

% speed_R - right belt speed in m/s

% speed_L - left belt speed in m/s

% accel_R - right belt absolute rate of change when speed changes happen, in m/s^2

% accel_L - left belt absolute rate of change when speed changes happen, in m/s^2

% incline - in degrees

%All inputs are in metric. m/s, m/s^2. Internally converted to mm/s^2
%Acceleration is an aboslute value! 

% Outputs

% payload - a byte payload formatted per Bertec instructions. Send to treadmill via TCP port 4000

% "Throttle limits" - do NOT change these unless you know what you are doing!
min_accel = 0.2; % m/s^2
max_accel = 1; %m/s^2
max_speed = 5.5; %m/s - this is circa 5min mile pace
min_speed = 0; %mm/s - zero for no going in reverse (can change to -5.5 if desired)
max_incline = 0; %degrees - ECU treadmill has no incline module

%Accel is absolute value
accel_R = abs(accel_R);
accel_L = abs(accel_L);

[accel_R_mm, accel_L_mm] = check_and_convert_accel(accel_R, accel_L, min_accel, max_accel);
[speed_R_mm, speed_L_mm] = check_and_convert_speed(speed_R, speed_L, min_speed, max_speed);
incline_centi = check_and_convert_incline(incline, max_incline);

%% Formating packet payload to treadmill specification
format =0; 
speedRR = 0; %only for quadruped treadmills
speedLL = 0; %only for quadruped treadmills

accRR=0; %ditto
accLL=0; %ditto

aux=int16toBytes(round([speed_R_mm speed_L_mm speedRR speedLL accel_R_mm accel_L_mm accRR accLL incline_centi]));
actualData=reshape(aux',size(aux,1)*2,1);
secCheck=255-actualData; %Redundant data to avoid errors in comm
padding=zeros(1,27);

payload =[format actualData' secCheck' padding];

end

%% Safety checks and conversion to mm or centi-degrees

%% --- Acceleration ---
function [acc_R_mm, acc_L_mm] = check_and_convert_accel(accel_R, accel_L, min_accel, max_accel)

%Check if acceleration is too low
if accel_R < min_accel
    warning(['Requested right-belt acceleration of less than ]', num2str(min_accel), ...
        ' m/s^2. Using '  num2str(min_accel), ' m/s^2']);
    accel_R = min_accel;
end

if accel_L < min_accel
    warning(['Requested left-belt acceleration of less than ]', num2str(min_accel), ...
        ' m/s^2. Using '  num2str(min_accel), ' m/s^2']);
    accel_L = min_accel;
end

% Check if accel is too high
if accel_R > max_accel
    warning(['Requested right-belt acceleration >' num2str(max_accel) 'm/s^2. Using' num2str(max_accel) 'm/s^2'])
    accel_R = max_accel;
end

if accel_L > max_accel
    warning(['Requested left-belt acceleration >' num2str(max_accel) 'm/s^2. Using' num2str(max_accel) 'm/s^2'])
    accel_L = max_accel;
end

%Convert to mm/s^2
acc_R_mm = accel_R*1000;
acc_L_mm = accel_L*1000;

end


%% --- Speed ---
function [speed_R_mm, speed_L_mm] = check_and_convert_speed(speed_R, speed_L, min_speed, max_speed)

% -- right side
if speed_R < min_speed
    warning(['Right belt speed below minimum. Setting to ', num2str(min_speed)]);
    speed_R = min_speed;
end

if speed_R > max_speed
    warning(['Right belt speed above maximum. Setting to ', num2str(max_speed)]);
    speed_R = max_speed;
end

%-- left side
if speed_L > max_speed
    warning(['Left belt speed above maximum. Setting to ', num2str(max_speed)]);
    speed_L = max_speed;
end

if speed_L < min_speed
    warning(['Left belt speed above maximum. Setting to ', num2str(max_speed)]);
    speed_L = min_speed;
end

%Convert to mm/s
speed_R_mm = speed_R*1000;
speed_L_mm = speed_L *1000;

end


%% --- Incline --- 
function incline_centi = check_and_convert_incline(incline, max_incline)

if incline<0
    warning('Incline below zero. Setting to zero')
    incline=0;
end

if incline>max_incline
    warning(['Incline above maximum. Setting to ', num2str(max_incline)]);
    incline  = max_incline;
end

incline_centi = incline / 100;

end

