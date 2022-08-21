counter = 0;

for d = 0.01:0.01:35

    counter = counter+1;

    WL = 0.305:0.01:5;

    CellDensity = 4287;
    [ExtXCmass ssa extinction scattering absorption asymmetry] = MieMineralFunc(WL, d, CellDensity,KK);


    ExtXCmass_out(:,counter) = ExtXCmass;
    extinction_out(:,counter) = extinction;
    scattering_out(:,counter) = scattering;
    absorption_out(:,counter) = absorption;
    ssa_out(:,counter) = ssa;
    asymmetry_out(:,counter) = asymmetry;

end

csvwrite('Geomety Sample Data.xlsx',ExtXCmass_out)
csvwrite('Geomety Sample Data.xlsx',extinction_out)
csvwrite('Geomety Sample Data.xlsx',scattering_out)
csvwrite('Geomety Sample Data.xlsx',absorption_out)
csvwrite('Geomety Sample Data.xlsx',ssa_out)
csvwrite('Geomety Sample Data.xlsx',asymmetry_out)


bin1 = 1:10;
bin2 = 101:20;
bin3 = 201:30;
bin4 = 301:40;
bin5 = 401:50;
bin6 = 501:60;
bin7 = 601:70;
bin8 = 701:80;
bin9 = 801:90;
bin10 = 901:100;
bin11 = 101:200
bin12 = 201:300;
bin13 = 301:400;
bin14 = 401:500;
bin15 = 501:1000;
bin16 = 1001:2000;
bin17 = 2001:3000;
bin18 = 3001:4000;

for i = 1:1:18
    bin = strcat('bin',num2str(i));
    ssa_bin_out(:,i) = mean(ssa_out([1:470],[bin]),2);
    ExtXCmass_bin_out(:,i) = mean(ExtXCmass_out([1:470],[bin]),2);
    extinction_bin_out(:,i) = mean(extinction_out([1:470],[bin]),2);
    scattering_bin_out(:,i) = mean(scattering_out([1:470],[bin]),2);
    absorption_bin_out(:,i) = mean(absorption_out([1:470],[bin]),2);
    asymmetry_bin_out(:,i) = mean(asymmetry_out([1:470],[bin]),2);
end



Weights = csvread('Geomety Sample Data.xlsx');
Weights = Weights/100;

for i = 1:1:18
    ssa_w_temp(:,i) = ssa_bin_out(:,i).*Weights(i);
    ExtXCmass_w_temp(:,i) = ExtXCmass_bin_out(:,i).*Weights(i);
    extinction_w_temp(:,i) = extinction_bin_out(:,i).*Weights(i);
    absorption_w_temp(:,i) = absorption_bin_out(:,i).*Weights(i);
    asymmetry_w_temp(:,i) = asymmetry_bin_out(:,i).*Weights(i);
    scattering_w_temp(:,i) = scattering_bin_out(:,i).*Weights(i);
end

weighted_ssa = sum(ssa_w_temp,2);
weighted_ExtXCmass = sum(ExtXCmass_w_temp,2);
weighted_asymmetry = sum(asymmetry_w_temp,2);
weighted_extinction = sum(extinction_w_temp,2);
weighted_scattering = sum(scattering_w_temp,2);
weighted_absorption = sum(absorption_w_temp,2);



figure

subplot(3,2,1)
plot(WL,weighted_ExtXCmass)
xlabel('Wavelength (micron)')
ylabel('PSD')

subplot(3,2,2)
plot(WL,weighted_ssa)
xlabel ('wavelength (micron)')
ylabel('PSD')

subplot(3,2,3)
plot(WL,weighted_extinction)
xlabel ('wavelength (micron)')
ylabel('PSD')

subplot(3,2,4)
plot(WL,weighted_scattering)
xlabel ('wavelength (micron)')
ylabel('PSD')

subplot(3,2,5)
plot(WL,weighted_absorption)
xlabel ('wavelength (micron)')
ylabel('PSD')

subplot(3,2,6)
plot(WL,weighted_asymmetry)
xlabel ('wavelength (micron)')
ylabel('PSD')
