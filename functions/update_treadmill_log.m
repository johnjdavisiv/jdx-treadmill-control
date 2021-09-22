function update_treadmill_log(log_fname, timestamp, elapsed_time, ...
    speed_commands, treadmill_packet)
%update the treadmill log csv with the most recent packet

%Will have to check if the fopen and fclose are significant performance barriers

%One possibility if file writing is too slow is to store these in a matrix that is preallocated
%Then dump matrix to csv at end of the session


fid = fopen(log_fname, 'a'); %a for append

%Write the line of data - packets report R first then L
fprintf(fid, '%f, %f, %f, %f, %i, %i, %i\n', timestamp, elapsed_time, ...
    speed_commands(1), speed_commands(2), ...
    treadmill_packet(1), treadmill_packet(2), treadmill_packet(3));

fclose(fid);

end

