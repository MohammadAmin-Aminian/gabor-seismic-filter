

D11 = zeros(nt,nx)
for jj = 7 : 1 : 30
    D11 = D11 + Deg(:,:,jj)
end

figure
imagesc(real(D11 ));
colormap(gray)

figure()
subplot(221)
imagesc(dout);
colormap gray
title("Data")

subplot(222);
imagesc(real(D33))
colormap gray
title('Filtered Data')



dt1 = 0.002;
fs=1/dt1;
% N=l000;
f = [-nt/2:nt/2-1]*fs/1000;
dd2 = fftshift(abs(fft(dout(:,:))));

for i = 1 : 1 : nt
f_d2(i,:) = max(dd2(i,:));
end

subplot(223);
plot(f,normalize(f_d2,'range') ,"LineWidth",1.5,'color','k')
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([0 80])
% ylim([0 220])

title(" Power Frequency Spectrum of data")

%

dd = fftshift(abs(fft(D33(:,:))));

for i = 1 : 1 : nt
f_dd(i,:) = max(dd(i,:));
end

subplot(224);
plot(f,normalize(f_dd,'range') ,"LineWidth",1.5,'color','k')
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([0 80])
% ylim([0 220])

title(" Power Frequency Spectrum of filtered Data")
