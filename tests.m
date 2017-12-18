% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% où num_ref est le nombre d'objets de référence (le nombre d'images requêtes) 
% et 19 est le nombre d'images à retrouver pour chaque requête
function [recall, precision] = tests()
img_db_path = './db/';
img_db_list = glob([img_db_path, '*.gif']);
img_db = cell(1);
label_db = cell(1);
fd_db = cell(1);
figure();

totalX = 0;
totalY = 0;


for im = 1:2;%numel(img_db_list);
    %totalX = 0;
    %totalY = 0;
    img_db{im} = logical(imread(img_db_list{im}));
    label_db{im} = get_label(img_db_list{im});
    clf;
    figure(1);
    hold on;
    imshow(img_db{im});
    disp(label_db{im}); 
    

    [x, y] = find(img_db{im});
    mX = round(mean(x));
    mY = round(mean(y));
    coupe=180;
    
    signatures = zeros(numel(img_db_list),coupe);

    for co = 1:coupe;
       teta = (co*pi)/180;
       trouveB = 0;
       monX = cos(co * 2 * pi()/coupe);
       monY = sin(co * 2 * pi()/coupe);
       toastX = mX;
       toastY = mY;
       hold on;
       plot(mY, mX, 'ro');
       bool=1;
       %&& toastX < size(img_db{im}, 2) && toastY < size(img_db{im}, 1)
       
       while (bool==1 & img_db{im}(round(toastX), round(toastY)) == 1);
            %coucou = img_db{im}(round(toastX), round(toastY))
            [m,n] = size(img_db{im});
            toastX = toastX + monX;
            toastY = toastY + monY;
            if (round(toastX) == m || round(toastX) == 0 || round(toastY) == 0 || round(toastY) == n); % tests si ça recontre des bords
                bool = 0;
            end
            hold on;
            plot(toastY, toastX, 'r+', 'MarkerSize', 3);
            distance = sqrt((mX - round(toastX))^2  + (mY - round(toastY))^2);
            signatures(im , co) = distance;
       end
       signatures(im,:)
       hold on;
       plot(toastY, toastX, 'r.');
    end
    
    X = fft(signatures);
    X = abs(X)./X(im,0)
    %hold on;
    %plot(mY, mX, 'r+', 'MarkerSize', 25);
    
    drawnow();
end

