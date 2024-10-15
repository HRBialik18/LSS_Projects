function [y1sig, y2sig] = lab1sim(A, B, L, sig)
    tau1 = (sqrt((B^2)+(L-A)^2))/343;
    tau2 = (sqrt((B^2)+(L-2*A)^2))/343;

    y1sig = @(t) sig(t-tau1);
    y2sig = @(t) sig(t-tau2);
