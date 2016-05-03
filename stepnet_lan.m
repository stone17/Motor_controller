fprintf(s,'%s\r', '1 s r0x24 0')
pause(1)
readout = fscanf(s,'%c',s.BytesAvailable)