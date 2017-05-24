function dane_statyczne()
    %rysowanie danych statycznych
    ds = dlmread('danestat33.txt');
    plot(ds(1:200, 1), ds(1:200, 2), '.');
    title('Dane statyczne');
    xlabel('u');
    ylabel('y');
    print('-dpng', 'dane_statyczne.png');
    
    %dzielenie na zbior weryfikujacy i uczacy
    dane_uczace = zeros(100, 2);
    dane_weryf = zeros(100, 2);
    for i = 1:100
        dane_uczace(i, 1:2) = ds(i*2-1, 1:2);
        dane_weryf(i, 1:2) = ds(i*2, 1:2);
    end
    
    %rysowanie zbioru uczacego i weryfikujacego
    plot(dane_uczace(1:100, 1), dane_uczace(1:100, 2), '.');
    title('Dane statyczne uczace');
    xlabel('u');
    ylabel('y');
    print('-dpng', 'dane_statyczne_uczace.png');
    plot(dane_weryf(1:100, 1), dane_weryf(1:100, 2), '.');
    title('Dane statyczne weryfikujace');
    xlabel('u');
    ylabel('y');
    print('-dpng', 'dane_statyczne_weryf.png');
    
    for i = 1:7
        w = regresja(dane_weryf, dane_uczace, i);
        bu = blad(dane_uczace, w);
        bw = blad(dane_weryf, w);
        disp('wspolczynniki wielomianu');
        disp(w);
        disp(['blad dane uczace', num2str(bu)]);
        disp(['blad dane weryf', num2str(bw)]);
    end
end

function result = wielomian(w, x)
    y = 0;
    for j = 1:numel(w)
        y = y + w(j)*power(x, numel(w)-j);
    end
    result = y;
end

function result = blad(dane, w)
    result = 0;
    for i = 1:100
        result = power(dane(i, 2)-wielomian(w, dane(i, 1)), 2);
    end
end
    
function w = regresja(dane_weryf, dane_uczace, p)
    disp(['obliczanie regresji dla wielomianu stopnia ', num2str(p)])
    y = dane_uczace(1:100, 2);
    m = ones(100, p+1);
    for i = 1:p+1
        for j = 1:100
            m(j, i) = power(dane_uczace(j, 1), p-i+1);
        end
    end
    w = m\y;

    x_reg = -1:0.01:1;
    y_reg = x_reg;
    for i = 1:201
        y_reg(i) = wielomian(w, x_reg(i));
    end
    
    plot(x_reg, y_reg);
    hold on;
    plot(dane_weryf(1:100, 1), dane_weryf(1:100, 2), '.');
    title(['Model statyczny rzedu ' num2str(p) ' dane weryfikujace']);
    xlabel('u');
    ylabel('y');
    print('-dpng', ['dane_statyczne_model_rzedu_' num2str(p) '_weryf.png']);
    hold off;
    
    plot(x_reg, y_reg);
    hold on;
    plot(dane_uczace(1:100, 1), dane_uczace(1:100, 2), '.');
    title(['Model statyczny rzedu ' num2str(p) ' dane uczace']);
    xlabel('u');
    ylabel('y');
    print('-dpng', ['dane_statyczne_model_rzedu_' num2str(p) '_uczace.png']);
    hold off;
end