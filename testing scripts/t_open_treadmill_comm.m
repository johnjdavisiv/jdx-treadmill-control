function t = t_open_treadmill_comm()
% Adapted from smsong 2019 code

%Test version with tcpip echo

%Output

% t - A treadmill TCP connection
echotcpip('on', 4000);

t=tcpip('localhost',4000);


set(t,'InputBufferSize',32,'OutputBufferSize',64);
fopen(t);

end