function [y1sig, y2sig] = lab1sim(A, B, L, sig)
    speed_of_sound = 343;
    tau1 = (sqrt((B^2)+(L-A)^2))/speed_of_sound; %calculate taus based on derivation from part a
    tau2 = (sqrt((B^2)+(L-2*A)^2))/speed_of_sound;

    y1sig = @(t) sig(t-tau1); %create y1(t) = s(t-tau1). This is returned back to the caller.
    y2sig = @(t) sig(t-tau2);%create y2(t) = s(t-tau2). This is returned back to the caller.
