function [Response,final_response] = bump_attractor_1d(eccentricity,delay)

num_trials = 200;

%%%%% PARAMETERS

N=CMF(eccentricity); % number of "neurons" in the rate model
npop=8; 	% number of cues presented

totalTime=2200+delay;	% total time of the simulation in ms
dt=2; 		% integration step in ms

tauE=20;	% time constant of rate equation for excitatory neurons
tauI=10;	% time constant of rate equation for inhibitory neurons

kappa=1.5;	% parameter defining concentration of e-to-e connectivity
GEE=6;	 	% strength of excitation to excitatory neurons
GEI=4;		% strength of excitation to inhibitory neurons
GIE=3.4;	% strength of inhibition to excitatory neurons
GII=0.85;	% strength of inhibition to inhibitory neurons

I0E=0.2;	% external bias current to excitatory neurons
I0I=0.5;	% external bias current to inhibitory neurons

sigE=1;		% standard deviation of additive noise in rate equation of e-cells
sigI=3;		% standard deviation of additive noise in rate equation of i-cells

stimon = 200;	% time when external stimulus is applied in ms
stimoff = 450;	% time when external stimulus ceases in ms
stim = 250;  	% strength of external stimulus
delayend=450+delay;	% time when delay ends in ms, and external input is applied to erase memory

%%%%% PRELIMINARY CALCULATIONS

rE=zeros(N,1);
rI=zeros(N,1);
nsteps=floor(totalTime/dt);
delayPop=zeros(N,1);

% E-to-E connectivity
theta = [0:N-1]/N*2*pi;
v = exp(kappa*cos(theta));
v = v/sum(v);
WE = gallery('circul',v);

% stimulus parameters
theta=theta-pi;
v = exp(kappa*cos(theta));
v = v/sum(v);
stimulus = stim*v';
stimon = floor(stimon/dt);
stimoff = floor(stimoff/dt);
delayend = floor(delayend/dt);
delaywin = floor(100/dt); %100 ms window

% input-output function for all cells, as used previously (Brunel, Cereb Cortex 13:1151, 2003)
f = inline('x.*x.*(x>0).*(x<1)+sqrt(4*x-3).*(x>=1)');

% population vector decoder given the rates r for neurons with selectivity th
decode = inline('atan2(sum(r.*sin(th)),sum(r.*cos(th)))','r','th');

nbl=floor(N/npop);

%%%% SIMULATION LOOP

for t=1:num_trials
        display(['Simuluating trial: ',num2str(t,'%.3d')]);
 for i=1:nsteps   
  % additive noise for each population
  noiseE = sigE*randn(N,1);
  noiseI = sigI*randn(N,1);
  
  % current input to each population
  IE=GEE*WE*rE+(I0E-GIE*mean(rI))*ones(N,1);
  II=(GEI*mean(rE)-GII*mean(rI)+I0I)*ones(N,1);
  
  % external task-dependent inputs
  if i>stimon & i<stimoff, 
    IE=IE+stimulus; % cue stimulus before delay
  end
  if i>delayend & i<delayend+(stimoff-stimon),
    IE=IE-stim;  % erasing global input after delay
  end

  if i>delayend-delaywin & i<=delayend,
    delayPop = delayPop + rE/delaywin;
  end

  % integration with time-step dt: Newton method
  rE = rE + (f(IE) - rE + noiseE)*dt/tauE;
  rI = rI + (f(II) - rI + noiseI)*dt/tauI;

  % get decoded angle from network activity  
  ang=decode(rE,theta');
  % if delay is over, record decoded angle in response variable, discretize
  % for comparison to experimental data
  if (i>stimoff) && (i<=delayend), response(i-stimoff)=ang; end % response of each time point
  if i==delayend, final_response(t,1)=ang; end % final response of a trial
 end
     %display(['Output: ',num2str(final_response(t,1))]);
     Response(t,:)= response;
end
end

