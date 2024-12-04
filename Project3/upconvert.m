function st = upconvert(m, Gc, fs, fc, fh)
    MessageSignalRF = resample(m, fh, fs); %upconvert the message signal
    t = (0:length(MessageSignalRF)-1) / fh; %create the carrier signal for relevant values of t
    c = Gc * cos(2 * pi * fc * t);
    st = c.* MessageSignalRF; %create the modulated signal
