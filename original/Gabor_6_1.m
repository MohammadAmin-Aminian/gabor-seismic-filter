
load("Data_Section.mat")
figure()
imagesc(data);
% colorbar
dout = data;
%%
[nt, nx] = size(dout);
u = 10;
v = 180 ;
m = 39;
n = 39;
d1 = 5;
d2 = 5;
gaborArray = gaborFilterBank(u,v,m,n);

[featureVector,gaborResult] = gaborFeatures(dout,gaborArray,d1,d2);

shot_gabor = zeros(nt,nx);
for i = 1 : u
    for j = 1 : 180
        shot_gabor = gaborResult{i,j} + shot_gabor;
    end
end

%%
DD = zeros(nt,nx,180);
for j = 1 : 1 : 180
    for i = 1 : 1 : 10

  DD(:,:,j) = DD(:,:,j) + gaborResult{i,j};
  
    end
end


Step = 5;
nz = ( 180 / Step );
Deg = zeros(nt,nx,nz);

for ii = 1 : 1 : nz
for kk = ( ii * Step ) - ( Step - 1) : 1 : ( ii * Step )
    
    Deg(:,:,ii) = Deg(:,:,ii) + DD(:,:,kk);
    
end
end   
%%
% Movie
    for j = 1: nz        
        subplot(6,6,j)    
        imagesc(real(Deg(:,:,j)));
        title(10 * j)
        colormap('gray')
    end
    
for ii = 1 : 1 : nz
    subplot(1,2,1)
    imagesc(dout)

    subplot(1,2,2)
    imagesc(real(Deg(:,:,ii)))
%   colorbar
    colormap('gray')
    title (ii * Step )
    pause(1)
end
%%
% Plots
D11 = zeros(nt,nx);
for jj = 30 : 1 : 36
    D11 = D11 + Deg(:,:,jj);
end


D22 = zeros(nt,nx);
for jj = 1 : 1 : 7
    D22 = D22 + Deg(:,:,jj);
end

figure
subplot(121)
imagesc(real(D11 ));
colormap(gray)

subplot(122)
imagesc(real( D22 ));
colormap(gray)

%%
D33 = (D11 + D22) / 10 ;

figure()

subplot(231)
imagesc(dout2);
colormap gray
title("Clean Data")

subplot(232)
imagesc(dout);
colormap gray
title("Data + Noise")

subplot(233);
imagesc(real(D33))
colormap gray
title('Filtered Data')
dd22 = fftshift(abs(fft(dout2(:,:))));


dt1 = 0.002;
fs=1/dt1;
% N=l000;
f = (-nt/2:nt/2-1)*fs/1000;


for i = 1 : 1 : nt
f_dd22(i,:) = max(dd22(i,:));
end
subplot(234);
plot(f,normalize(f_dd22,'range') ,"LineWidth",1.5,'color','k')
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([0 80])
ylim([0 1])
title("Frequency Spectrum of Clean Data")

dd2 = fftshift(abs(fft(dout(:,:))));
for i = 1 : 1 : nt
f_d2(i,:) = max(dd2(i,:));
end

subplot(235);
plot(f,normalize(f_d2,'range') ,"LineWidth",1.5,'color','k')
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([0 80])
ylim([0 1])
title(" Frequency Spectrum of (Dta + Noise)")

dd = fftshift(abs(fft(real(D33(:,:)))));
for i = 1 : 1 : nt
f_dd(i,:) = max(dd(i,:));
end

subplot(236);
plot(f,normalize(f_dd,'range') ,"LineWidth",1.5,'color','k')
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([0 80])
ylim([0 1])
title("Frequency Spectrum of filtered Data")

%%
for i = 1 : 1 : nt
f_dd22(i,:) = max(dd22(i,:));
end

plot(f,f_dd22,"LineWidth",1.2,'color','r')
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([0 80])

hold on

plot(f,f_dd ,"LineWidth",1.2,'color','b')
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([0 80])

legend("Clean Data","Filtered Data")

