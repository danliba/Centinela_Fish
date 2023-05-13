%%Promedio mensual de SAL
clc
clear all
close all

%% %% %shapes file
%departamentos del Peru
deppath='D:\CIO\Kelvin-cromwell\clorofila\departamentos';
depfn='DEPARTAMENTOS.shp';
depfns=fullfile(deppath,depfn);

%puertos del peru
puertopath='D:\CIO\Kelvin-cromwell\clorofila\puerto';
puertofn='puerto.shp';
puertofns=fullfile(puertopath,puertofn);

%% shape file departamentos
[c,d]=shaperead(depfns);
        for j=1:1:size(c,1)
            plot(c(j).X,c(j).Y,'k');
            hold on
        end
        
%% shapefile puertos
[a,b]=shaperead(puertofns);

for i=1:1:size(a,1)
plot(a(i).X,a(i).Y,'k.');
lonpuertos(i,:)=a(i).X;
latpuertos(i,:)=a(i).Y;
nombrepuertos{i,:}=b(i).NOMPUERT;
text(lonpuertos(i),latpuertos(i),nombrepuertos{i,:},'fontsize',7);
hold on
end

indx=[3,5,10,12,13,14,15,22,25,30,31,33,36,38,50];
%puertos ya seleccionados
puertoselect=nombrepuertos(indx,:);
%callao nombre cambiar
puertoselect(2,:)={'CALLAO'};
lonpuertosi=lonpuertos(indx);
latpuertosi=latpuertos(indx);
%% Temp
path0='D:\trabajo\CENTINELA\reporte_oceanografico';
fn='2022_04.nc';
fns=fullfile(path0,fn);

lon=double(ncread(fns,'longitude'));
lat=double(ncread(fns,'latitude'));
time=double(ncread(fns,'time'))./24;
[loni,lati]=meshgrid(lon,lat);

[yr,mo,da,hr,mi,se]=datevec(time+datenum(1950,1,1,1,0,0));

%% sss
sal=double(ncread(fns,'so'));
sal=permute(sal,[1 2 4 3]);
sal=nanmean(sal,3);

%% grafico TEMP
load('WM_peru');
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
pcolor(lon,lat,sal(:,:,1)');
hold on
[c,h]=contour(lon,lat,sal',[33:0.2:36],'k:');
clabel(c,h,'Fontsize',8);
colorbar; caxis([33 35.5]);
%title(datestr(datenum(yr(ii),mo(ii),30,0,0,0)));
title('SSM PERU 01/04/2022 - 26/04/2022','fontsize',12)
ylim([-20 0]);
 hold on
 [c,d]=shaperead(depfns);
 for j=1:1:size(c,1)
    plot(c(j).X,c(j).Y,'k');
    hold on
 end
hold on
text(lonpuertosi,latpuertosi,puertoselect,'fontsize',8,'fontweight','bold');
ax = gca;
set(gca,'ytick',[-20:2:0],'yticklabel',labels_y,'ylim',[-20 0]);
set(gca,'xtick',[-86:2:-68],'xticklabel',labels_x,'xlim',[-86 -68]);
hc=colorbar;
set(hc,'ticks',[33,33.8,34.8,35.1,35.5],'TickDirection',('out'),'TickLength',0.005);
text(-85.5,-18.5,'Fuente: COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
%         text(-82.55,-18.5,'COPERNICUS - CMEMS','color','black','fontweight','bold','fontsize',9);
text(-85.5,-19,'Procesamiento: CENTRO DE MONITOREO','color','black','fontweight','bold','fontsize',9);
text(-82.55,-19.35,'PESQUERA CENTINELA','color','black','fontweight','bold','fontsize',9);
shading interp
colormap(peru_wm)
hold on
%         pause(1)
figure_map=[sprintf('Sal_%d',1),'.png'];
print(figure_map,'-dpng','-r300');
