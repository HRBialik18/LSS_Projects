function st = upconvert(m, Gc, fs, fc, fh)
    MessageSignalRF = resample(m, fh, fs);
    t = 0:1/fh:(1/fh)*(length(MessageSignalRF)-1); %chana two of the same thing
    % t = (0:length(MessageSignalRF)-1) / fh;
    c = Gc * cos(2 * pi * fc * t);
    st = c.* MessageSignalRF;
