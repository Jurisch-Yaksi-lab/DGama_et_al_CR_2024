function filt_trace=EY_LP_bw_Filt(trace,cutoff);
samprate=10000;


[b,a]=butter(2,cutoff/(2*samprate),'low');

filt_trace=zeros(size(trace));

for i=1:size(trace,2)
    
filt_trace(:,i)=filtfilt(b,a,trace(:,i)); %no phase shift, but a sharper filter

end
% filt_trace=filter(b,a,trace); %there is a bit of phase shit, but a smoother filter

% figure(3);
% plot(filt_trace,'b','linewidth',2)
% hold on 
% plot(trace,'r','linewidth',1)
% hold off
% 
% 
% % h1=dfilt.df2(b,a);
% fvtool(b,a);