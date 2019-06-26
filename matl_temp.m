%% plotyy format
fh=figure('visible','off');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 8])
[ax,h1,h2]= plotyy(zm_tot,Wfwhms,zm_tot,Tfwhms*1e12);hold on;
set(h1,'Marker','o','MarkerSize',3,'linestyle',':','linewidth',2)
set(h2,'Marker','p','MarkerSize',4,'linestyle',':','linewidth',2)
set(h1,'linestyle','-','linewidth',2)
set(h2,'linestyle','-','linewidth',2)
set(ax(1),'YLim',[0 40],'xlim',[0 ceil(sum(Lfibers))])
set(ax(2),'YLim',[0 12],'xlim',[0 ceil(sum(Lfibers))])

ylabel(ax(1), 'Spectral Width (nm)');
ylabel(ax(2), 'Pulse width (ps)');
xlabel('Position in cavity (m)')
set(ax(1), 'YTick',0:5:40,'Xtick',[0 sum(Lfibers(1)) sum(Lfibers(1:2)) sum(Lfibers(1:7)) sum(Lfibers(1:10)) sum(Lfibers(1:11)) ceil(sum(Lfibers))])
set(ax(2), 'YTick',0:1.5:12,'Xtick',[0 sum(Lfibers(1)) sum(Lfibers(1:2)) sum(Lfibers(1:7)) sum(Lfibers(1:10)) sum(Lfibers(1:11)) ceil(sum(Lfibers))])
grid on;
set([ax(1) ax(2)],'FontName','Times New Roman','FontSize',18)
print(fh,['./figure/Width-dense-' flnm '.png'],'-dpng','-r600')

%% generate animation

% create the video writer with 1 fps
writerObj = VideoWriter([dir_nm '/data/Spec_' flnm '.avi']);
writerObj.FrameRate = 10;
% open the video writer
open(writerObj);
figure(1)
set(gcf,'position',[100 200 1600 800])
subplot(2,1,1)
plot(ts*1e12,Itmp(kk,:),'-b','linewidth',1)
xlim([-300 300]);ylim([0 1]);title(['Roundtrip: ' num2str(kk)])
xlabel('Time (ps)')
subplot(2,1,2)    
plot(lambda_p*1e9,Iwmp(kk,:),'-m','linewidth',1);
xlim([1530 1570]);ylim([0 1]);title(['Roundtrip: ' num2str(kk)])
xlabel('Wavelength (nm)')
pause(0.1)
writeVideo(writerObj, getframe(gcf));
close(writerObj);
%%
