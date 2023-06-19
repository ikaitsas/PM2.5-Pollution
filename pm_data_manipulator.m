%--- PM DATA ANALYSH  ---%

format longG
fsize=15;


%-- VALE TO ARXEIO EDW --%
t_able=readtable('4_Kardia.csv');

%hourtable
htable=table2timetable(t_able); 

%daytable
dtable=retime(htable,'daily','mean'); 

%monthtable
mtable=retime(dtable,'monthly','mean');


% plotarisma twn meswn(?) wriaiwn timwn
hav=htable{:,1}; 
figure(1)
hbar=bar(hav,'r');
ylim([0 88])
xticks([1 745 1441 2184 2905 3648 4368 5112 5856 6576 7321 8041])
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
title('Hourly Graph')
xlabel('Hours','Fontsize',fsize);
ylabel('PM2.5 (μg/m^3)','Fontsize',fsize);
grid minor


% plotarisma twn meswn hmerhsiwn timwn
dav=dtable{:,1};
days=length(dav);
figure(2)
dbar=bar(dav,'r'); 
ylim([0 58])
xticks([1 32 61 92 122 153 183 214 245 275 306 336])
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
title('Daily Graph')
xlabel('Days','Fontsize',fsize);
ylabel('PM2.5 (μg/m^3)','Fontsize',fsize);
grid minor


% plotarisma twn meswn mhniaiwn timwn
mav=mtable{:,1};
figure(3)
mbar=bar(mav,'r');
xticks([1 2 3 4 5 6 7 8 9 10 11 12])
title('Monthly Graph')
xlabel('Month','Fontsize',fsize);
ylabel('PM2.5 (μg/m^3)','Fontsize',fsize);
grid minor


% epoxikh metavolh - plotarisma auths
winter=(mav(1)+mav(2)+mav(12))/3; 
spring=(mav(3)+mav(4)+mav(5))/3;
summer=(mav(6)+mav(7)+mav(8))/3;
autumn=(mav(9)+mav(10)+mav(11))/3;
seasons=[winter spring summer autumn];
figure(4)
sbar=bar(seasons, 'r');
xticks([1 2 3 4])
xticklabels({'Winter','Spring','Summer','Autumn'})
title('Seasonal Graph')
xlabel('Season','Fontsize',fsize);
ylabel('PM2.5 (μg/m^3)','Fontsize',fsize);
grid minor


% enedohmerhsia metavolh

% apomonwsh twn wrwn ths hmeromhnias kathe sthlhs
hour_number=hour(htable.LocalTime); % meta thn teleia mpainei to onoma ths datetime sthlhs/metavlhths
% euresh meswn endohmerhsiwn meswn timwn
hourly_mean=grpstats(htable.PM2_5_ug_m3_,hour_number,'mean');

% gia thermh periodo
warm_table=table(t_able{2184:7320,1},t_able{2184:7320,2}); % na dhmiourghsw onomata metablhtwn edw
warm_table.Properties.VariableNames={'localtime_warm','pm25warm'}; % vazw onomata metavlhtwn stis sthles
warm_htable=table2timetable(warm_table);
warm_hour_number=hour(warm_htable.localtime_warm);
warm_hourly_mean=grpstats(warm_htable.pm25warm,warm_hour_number,'mean');

% gia psyxrh periodo
cold_table_part1=table(t_able{1:2183,1},t_able{1:2183,2}); % ianouarios-martios
cold_table_part2=table(t_able{7321:8784,1},t_able{7321:8784,2}); % noembrios-dekembrios
cold_table=[cold_table_part1;cold_table_part2]; % enwsh twn apo panw
cold_table.Properties.VariableNames={'localtime_cold','pm25cold'};
cold_htable=table2timetable(cold_table);
cold_hour_number=hour(cold_htable.localtime_cold);
cold_hourly_mean=grpstats(cold_htable.pm25cold,cold_hour_number,'mean');



% plotarisma endohmerhsiwn timwn
figure(5)
endohmerhsio_graph=plot(hourly_mean,'-og');
hold on
endohmerhsio_warm_graph=plot(warm_hourly_mean,'-ob');
hold on 
endohmerhsio_cold_graph=plot(cold_hourly_mean,'-or');
ylim([0 29])
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24])
xticklabels({'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'})
title('Per Hour of Day Graph')
xlabel('Hour','Fontsize',fsize);
ylabel('PM2.5 (μg/m^3)','Fontsize',fsize);
grid minor
legend('All Year','Warm Period','Cold Period','Location','northwest')
