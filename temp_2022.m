clear all
close all
clc
%% Temp
path0='D:\trabajo\CENTINELA\reporte_oceanografico';
fn='2022_04_26.nc';
fns=fullfile(path0,fn);

lon=double(ncread(fns,'longitude'));
lat=double(ncread(fns,'latitude'));
time=double(ncread(fns,'time'))./24;
[loni,lati]=meshgrid(lon,lat);

[yr,mo,da,hr,mi,se]=datevec(time+datenum(1950,1,1,1,0,0));
%% promedio

sst=double(ncread(fns,'thetao'));

sst1=permute(sst,[1 2 4 3]);
sst1=nanmean(sst1,3);

%% figure
labels_x={'86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};

figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

[c,d]=shaperead(depfns);
for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
end
%%plot
pcolor(lon,lat,sst1(:,:)');
hold on
[c,h]=contour(lon,lat,sst1',[15:1:25],'k:');
clabel(c,h,'Fontsize',8);
colorbar; caxis([14 30]);
%title(datestr(datenum(yr(ii),mo(ii),30,0,0,0)));
title('TSM PERU 01/04/2022 - 26/04/2022','fontsize',12)
ylim([-20 0]);
 hold on
 [c,d]=shaperead(depfns);
 for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
 end
plot(lonpuertos,latpuertos,'b.');
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-86:2:-68],'xticklabel',labels_x,'xlim',[-86 -68]);
text(-85.5,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
%         text(-82.55,-18.5,'COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-85.5,-19,'Procesamiento: CENTRO DE MONITOREO','color','black','fontweight','bold','fontsize',9);
text(-82.55,-19.35,'PESQUERA CENTINELA','color','black','fontweight','bold','fontsize',9);
shading flat
colormap jet
hold on
%         pause(1)
figure_map=[sprintf('abril_%d',1),'.png'];
print(figure_map,'-dpng','-r500');

%% anom

% 
sst1=sst1';
sstanom=sst1-ssts(:,:,4);
%% plot
load('SST1993_2019.mat')
labels_x={'86ºW','84ºW','82ºW','80ºW','78ºW','76ºW','74ºW','72ºW','70ºW','68ºW'};
labels_y={'20ºS','18ºS','16ºS','14ºS','12ºS','10ºS','8ºS','6ºS','4ºS','2ºS','0ºN'};


figure
P=get(gcf,'position');
P(3)=P(3)*1.5;
P(4)=P(4)*2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');


pcolor(lon,lat,sstanom(:,:));
hold on
[c,h]=contour(lon,lat,sstanom,[-6:1:6],'k:');
clabel(c,h,'Fontsize',8);
colorbar; caxis([-6 6]);
%title(datestr(datenum(yr(ii),mo(ii),30,0,0,0)));
title('ATSM PERU 01/04/2022 - 26/04/2022','fontsize',12)
ylim([-20 0]);
 hold on
 [c,d]=shaperead(depfns);
 for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
 end
%         plot(lonpuertos,latpuertos,'b.');
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-86:2:-68],'xticklabel',labels_x,'xlim',[-86 -68]);
text(-85.5,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
%         text(-82.55,-18.5,'COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-85.5,-19,'Procesamiento: CENTRO DE MONITOREO','color','black','fontweight','bold','fontsize',9);
text(-82.55,-19.35,'PESQUERA CENTINELA','color','black','fontweight','bold','fontsize',9);
shading flat
colormap jet
hold on
figure_map=[sprintf('ATSM_%d',4),'.png'];
print(figure_map,'-dpng','-r500');