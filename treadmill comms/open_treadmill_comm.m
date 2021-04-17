function t = open_treadmill_comm()
% Adapted from smsong 2019 code

%Output

% t - A treadmill TCP connection
t=tcpip('localhost',4000);
set(t,'InputBufferSize',32,'OutputBufferSize',64);
fopen(t);

end