function t = open_treadmill_comm()
% Adapted from smsong 2019 code

%Output

% t - A treadmill TCP connection

%This will return an error if the treadmill server is not on
%Switch it on in the settings panel of the Bertec software!

t=tcpip('localhost',4000);
set(t,'InputBufferSize',32,'OutputBufferSize',64);
fopen(t);

end