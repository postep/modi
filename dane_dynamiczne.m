function dane_dynamiczne()
ucz = dlmread('danedynucz33.txt');
wer = dlmread('danedynwer33.txt');

plot(ucz);
title(['Dane dynamiczne, uczace']);
xlabel('u');
ylabel('y');
print('-dpng', 'dane_dyn_ucz.png');

plot(wer);
title(['Dane dynamiczne, weryfikujace']);
xlabel('u');
ylabel('y');
print('-dpng', 'dane_dyn_ucz.png');

model_bez_rekurencji(ucz, 1);
end

function model_bez_rekurencji(y, n)
    Y = y(1+n:numel(y));
    
end