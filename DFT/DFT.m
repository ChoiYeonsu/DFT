close all;
clc;
clear all

f = im2double(imread('image.jpg'));
%f = double(imresize(h,0.3));
% F = fft2(f); 
% S = abs(F);
% Fc = fftshift(F);
% S2=log(1+abs(Fc));
% subplot(2,2,1);imshow(f,[]);
% subplot(2,2,2);imshow(S,[]);
% subplot(2,2,3);imshow(abs(Fc),[]);
% subplot(2,2,4);imshow(S2,[]);
% 
% output = real(ifft2(F));
% figure,imshow(output,[])

[M,N] = size(f);
g=f;
%Centered Fourier spectrum
for x = 1:M
    for y = 1:N
        g(x,y) = f(x,y).*((-1).^(x+y));
    end
end

F = zeros(size(f));
%Fourier spectrum
for u = 1:M
    for v = 1:N
        for x=1:M
            for y=1:N
                F(u,v) = F(u,v)+(g(x,y).*exp(-1j*2*pi*((u-1)*(x-1)/M+(v-1)*(y-1)/N)));
            end
        end
    end
end
F = F./(M*N);
S = abs(F);
S2 = log(1+S);
k = zeros(size(F));
%inverse Fourier spectrum
for x = 1:M
    for y = 1:N
        for u=1:M
            for v=1:N
                k(x,y) = k(x,y)+(F(u,v).*exp(1j*2*pi*((u-1)*(x-1)/M+(v-1)*(y-1)/N)));
            end
        end
    end
end
z=k;
for x= 1:M
    for y=1:N
        z(x,y) = k(x,y).*((-1).^(x+y));
    end
end
z = real(z);
subplot(2,2,1);imshow(f,[]);title('original image');
subplot(2,2,2);imshow(S,[]);title('DFT Translation');
subplot(2,2,3);imshow(S2,[]);title('DFT log');
subplot(2,2,4);imshow(z,[]);title('inverse DFT');
