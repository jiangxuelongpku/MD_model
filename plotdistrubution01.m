
[VBark,P,yr] = SetupVariables(10);
VBark = VBark*10;
T = [100:50:500]+273;
subplot(1,3,1)
plotP_T('VBark0.0032648.txt',T)

subplot(1,3,2)
plotP_T('VBark0.0028267.txt',T)

subplot(1,3,3)
plotP_T('VBark0.0017382.txt',T)