%%Climatologia mensual de TEMP, SAL y ANOM 
clc
clear all
close all

%% llamamos los datos

path0='D:\trabajo\CENTINELA\reporte_oceanografico';
fn='temp_clim.nc';
fns=fullfile(path0,fn);

lon=double(ncread(fns,'longitude'));
lat=double(ncread(fns,'latitude'));
time=double(ncread(fns,'time'))./24;
[loni,lati]=meshgrid(lon,lat);

[yr,mo,da,hr,mi,se]=datevec(time+datenum(1950,1,1,1,0,0));
%% 
figure
for i=1:1:12
    
    disp(['Month: ' num2str(i)])
    indx01=find(mo==i);
    
    numrec=length(indx01);
    
    for irec=1:1:numrec
        
         sst1=ncread(fn,'thetao',[1 1 1 indx01(irec)],...
            [length(lon) length(lat) 1 1],[1 1 1 1]);
        
        sst1=sst1';
        masknan=double(~isnan(sst1));
        sst1(isnan(sst1))=0;
        
        if irec==1
            sstm=zeros(size(sst1));
            numnonnan=zeros(size(sst1));
            
        end
        
        sstm=sstm+sst1;
        numnonnan=numnonnan+masknan;
    end
    
    sstm=sstm./numnonnan;
    
    ssts(:,:,i)=sstm;
    months(i,1)=i;
    
    pcolor(lon,lat,ssts(:,:,i));
    colorbar; caxis('auto');
    shading flat
    colormap jet
    title(num2str(i))
    pause(1)
    clf
    
end

save('SST1993_2019','ssts','loni','lati','months');