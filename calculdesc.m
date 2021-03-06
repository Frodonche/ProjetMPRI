function [ var ] = calculdesc( img_db_ref)
    for im = 1:numel(img_db_ref);
        
        img_db{im} = logical(imread(img_db_ref{im}));
        label_db{im} = get_label(img_db_ref{im});
        %%clf;
        %%figure(1);
        %%hold on;
        %%imshow(img_db{im});
        disp(label_db{im});
        
        tic;
        [x, y] = find(img_db{im});
        mX = round(mean(x));
        mY = round(mean(y));
        toc;
        coupe=180;
        
        signatures = zeros(numel(img_db_ref),coupe);
        
        for co = 1:coupe;
            teta = (co*pi)/180;
            trouveB = 0;
            monX = cos(co * 2 * pi()/coupe);
            monY = sin(co * 2 * pi()/coupe);
            toastX = mX;
            toastY = mY;
            %%hold on;
            %%plot(mY, mX, 'ro');
            bool=1;
            
            while (bool==1 & img_db{im}(round(toastX), round(toastY)) == 1);
                %coucou = img_db{im}(round(toastX), round(toastY))
                [m,n] = size(img_db{im});
                toastX = toastX + monX;
                toastY = toastY + monY;
                if (round(toastX) == m || round(toastX) == 0 || round(toastY) == 0 || round(toastY) == n); % tests si ça recontre des bords
                    bool = 0;
                end
                %%hold on;
                %%plot(toastY, toastX, 'r+', 'MarkerSize', 3);
                distance = sqrt((mX - round(toastX))^2  + (mY - round(toastY))^2);
                signatures(im , co) = distance;
            end
            
            %%hold on;
            %%plot(toastY, toastX, 'r.');
        end
        
        %hold on;
        %plot(mY, mX, 'r+', 'MarkerSize', 25);
        
        %%drawnow();
    end
    X = abs(fft(signatures));
    for im = 1:numel(img_db_ref);
        norm = X(im,1);
        X(im,:) = X(im,:)/norm;
    end

    var = X(:,[1 : 90]);
end

