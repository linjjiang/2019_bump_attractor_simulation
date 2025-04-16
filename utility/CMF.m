function density = CMF(eccentricity)
% Use cortical magnification factor to calculate neuronal density from
% visual eccentricities
% Linjing Jiang
M0 = 22.5; E2 = .785;
b = 1/(M0*E2); c = 1/M0;
M = 1./(b*eccentricity+c);
% Actual density
% density = M^2*255897;
density = floor(M*200);
end

