function dane_dynamiczne()
    ucz = dlmread('danedynucz33.txt');
    wer = dlmread('danedynwer33.txt');

    ucz_u = ucz(:, 1);
    ucz_y = ucz(:, 2);
    wer_u = wer(:, 1);
    wer_y = wer(:, 2);

    plot(ucz_u);
    xlabel('k');
    ylabel('u');
    print('-dpng', 'dane_dyn_ucz_u.png');

    plot(ucz_y);
    xlabel('k');
    ylabel('y');
    print('-dpng', 'dane_dyn_ucz_y.png');

    plot(wer_u);
    xlabel('k');
    ylabel('u');
    print('-dpng', 'dane_dyn_wer_u.png');

    plot(wer_y);
    xlabel('k');
    ylabel('y');
    print('-dpng', 'dane_dyn_wer_y.png');

    for i = 1:3
        [W, e, e_v] = model_bez_rekurencji(ucz_u, ucz_y, wer_u, wer_y, i);
        disp(i);
        disp(W);
        disp(e);
        disp(e_v);
    end
end

function result = error(y, v)
    result = (v-y)'*(v-y);
end

function [W, err, err_v] = model_bez_rekurencji(u, y, u_v, y_v, n)
    Mu = zeros(0, numel(u)-n);
    My = zeros(0, numel(y)-n);
    Mu_v = zeros(0, numel(u_v)-n);
    My_v = zeros(0, numel(y_v)-n);
    
    for i = 1:n
       Mu = [Mu, u(n-i+1:numel(u)-i)];
       My = [My, y(n-i+1:numel(y)-i)];
       Mu_v = [Mu_v, u_v(n-i+1:numel(u_v)-i)];
       My_v = [My_v, y_v(n-i+1:numel(y_v)-i)];
    end
    
    M = [Mu, My];
    M_v = [Mu_v, My_v];
    Y = y(n+1:numel(y));
    Y_v = y_v(n+1:numel(y_v));
    
    W = M\Y;
    Y_mod = M*W;
    Y_v_mod = M_v*W;
    err = error(Y, Y_mod);
    err_v = error(Y_v, Y_v_mod);
end

function [W, err, err_v] = model_z_rekurencja(W, u, y, u_v, y_v, n)
    Y_OE_MOD_train=zeros(k-N,1);
    Y_OE_MOD_valid=zeros(k-N,1);
    Y_OE_MOD_train(1:N)=Y_train(1:N);
    Y_OE_MOD_valid(1:N)=Y_valid(1:N);

    for j=N+1:k
        Y_OE_MOD_valid(j)=0;
        Y_OE_MOD_train(j)=0;
        for i=1:N
            Y_OE_MOD_valid(j)=Y_OE_MOD_valid(j)+U_valid(j-i)*W(i)+Y_OE_MOD_valid(j-i)*W(N+i);
            Y_OE_MOD_train(j)=Y_OE_MOD_train(j)+U_train(j-i)*W(i)+Y_OE_MOD_train(j-i)*W(N+i);
        end
    end

    Y_OE_MOD_valid=Y_OE_MOD_train(N+1:k);
    Y_OE_MOD_train=Y_OE_MOD_train(N+1:k);

    E_OE_valid=(Y_OE_MOD_valid-Y_valid(N+1:k))'*(Y_OE_MOD_valid-Y_valid(N+1:k))
    E_OE_train=(Y_OE_MOD_train-Y_train(N+1:k))'*(Y_OE_MOD_train-Y_train(N+1:k))Mu = zeros(numel(u)-n, 1);
    
    My = zeros(numel(y)-n, 1);
    Mu_v = zeros(0, numel(u_v)-n);
    My_v = zeros(0, numel(y_v)-n);
    
    for i = 1:n
       Mu = [Mu, u(n-i+1:numel(u)-i)];
       My = [My, y(n-i+1:numel(y)-i)];
       Mu_v = [Mu_v, u_v(n-i+1:numel(u_v)-i)];
       My_v = [My_v, y_v(n-i+1:numel(y_v)-i)];
    end
    
    M = [Mu, My];
    M_v = [Mu_v, My_v];
    Y = y(n+1:numel(y));
    Y_v = y_v(n+1:numel(y_v));
    
    W = M\Y;
    Y_mod = M*W;
    Y_v_mod = M_v*W;
    err = error(Y, Y_mod);
    err_v = error(Y_v, Y_v_mod);
end
