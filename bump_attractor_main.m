clear all
close all
clc
%%
ecc = [3 8 13];
delay = [500 1000 1500 2000 3000 4000 5000];
for ee = 1%:length(ecc)
    for dd = 7%1:length(delay)
        [response{ee,dd},output{ee,dd}] = bump_attractor_1d(ecc(ee),delay(dd));
    end
end

%%
response1 = response; output1 = output;
for dd = 1:3
response{3,dd} = response1{1,dd};
response{1,dd} = response1{3,dd};
output{3,dd} = output1{1,dd};
output{1,dd} = output1{3,dd};
end
%%
save('response1.mat','response','output')

%% random walk
ecc = [3 8 13];
delay = [1500 2000 3000];
ind = randi(size(response{1,1},1),1,20); 
ind = sort(ind);
f1 = figure(1);clf
for ee = 1:3
    for dd = 1:3
subplot(3,3,dd+3*(ee-1))
temp = response{ee,dd};
for ii = ind
plot([1:2:delay(dd)],temp(ii,:),'color','k')
hold on
end
xlabel('Delay Time (ms)')
ylabel('Response (rad)')
title(num2str(dd+3*(ee-1)))
set(gca,'FontSize',20)
    end
end
saveas(f1,'random_walk.jpg')
%% distribution
% distribution of errors at the end of the delay
f2 = figure(2);clf
for ee = 1:3
    for dd = 1:3
subplot(3,3,dd+3*(ee-1))
temp = response{ee,dd};
for tt = [1,floor(size(temp,2)/2),size(temp,2)]
x = temp(:,tt);
x(abs(x)>=2)=[];
[m,s] = normfit(x);
y = normpdf(x,m,s);
plot(x,y,'.'); 
hold on
end
xlabel('Response (rad)')
ylabel('Probability')
set(gca,'FontSize',16)
    end
end
legend('beginning','middle','end')
saveas(f2,'distribution_phasesOfDelay.jpg')
%% distribution: eccentricity and delay
c1 = colorGradient([250,128,114]/255,[128,0,0]/255,3);
c2 = colorGradient([135,206,250]/255,[0,0,139]/255,3);
c3 = colorGradient([124,252,0]/255,[0,100,0]/255,3);
color = [c1;c2;c3];
%%
f3 = figure(3);clf
for ee = 1:3
    for dd = 1:3
x = sort(output{ee,dd});
% pd = fitdist(x,'kernel');
% y = normpdf(pd,x);
x(abs(x)>=2)=[];
[m,s] = normfit(x);
y = normpdf(x,m,s);
plot(x,y,'LineWidth',2,'color',color(dd+3*(ee-1),:)); 
hold on
xlabel('Response (rad)')
ylabel('Probability')
set(gca,'FontSize',16)
    end
end
legend('delay1,ecc1','delay2,ecc1','delay3,ecc1',...
    'delay1,ecc2','delay2,ecc2','delay3,ecc2',...
    'delay1,ecc3','delay2,ecc3','delay3,ecc3')
saveas(f3,'districution_delay_eccentricity.jpg')

%% systematic and unsystematic error: eccentricity and delay

for ee = 1:3
    for dd = 1:3
       temp = output{ee,dd};
       temp(abs(temp)>2) = [];
sys(ee,dd) = mean(temp);
unsys(ee,dd) = std(temp);
    end
end

f4 = figure(4);clf
subplot(1,2,1)
bar(abs(sys))
set(gca,'XTickLabel',{'3 deg','8 deg','13 deg'})
title('Systematic Error (mean)')
set(gca,'FontSize',20)
subplot(1,2,2)
bar(unsys)
set(gca,'XTickLabel',{'3 deg','8 deg','13 deg'})
title('Unsystematic Error (std)')
set(gca,'FontSize',20)
saveas(f4,'error_eccentricity_delay.jpg')
%%
f5 = figure(5);clf
subplot(2,2,1)
bar(mean(abs(sys)))
set(gca,'XTickLabel',{'1.5s','2s','3s'})
title('Systematic Error (mean)')
set(gca,'FontSize',20)

subplot(2,2,2)
bar(mean(unsys))
set(gca,'XTickLabel',{'1.5s','2s','3s'})
title('Unsystematic Error (std)')
set(gca,'FontSize',20)

subplot(2,2,3)
bar(mean(abs(sys),2))
set(gca,'XTickLabel',{'3 deg','8 deg','13 deg'})
title('Systematic Error (mean)')
set(gca,'FontSize',20)

subplot(2,2,4)
bar(mean(unsys,2))
set(gca,'XTickLabel',{'3 deg','8 deg','13 deg'})
title('Unsystematic Error (std)')
set(gca,'FontSize',20)
saveas(f5,'error_all.jpg')