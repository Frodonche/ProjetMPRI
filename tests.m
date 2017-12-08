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


for im = 1:1;%numel(img_db_list);
    %totalX = 0;
    %totalY = 0;
    img_db{im} = logical(imread(img_db_list{im}));
    %label_db{im} = get_label(img_db_list{im});
    %clf;
    figure(1);
    hold on;
    imshow(img_db{im});
    %disp(label_db{im}); 
    

    [x, y] = find(img_db{im});
    mX = round(mean(x));
    mY = round(mean(y));
    
    coupe=360;
    for co = 1:coupe;
       teta = (co*pi)/180
       trouveB = 0;
       monX = cos(co * 2 * pi()/coupe)
       monY = sin(co * 2 * pi()/coupe)
       toastX = mX;
       toastY = mY;
       hold on;
    plot(mY, mX, 'ro');
        bool=1;
       %&& toastX < size(img_db{im}, 2) && toastY < size(img_db{im}, 1)
       
       while (bool==1 & img_db{im}(round(toastX), round(toastY)) == 1);
            %coucou = img_db{im}(round(toastX), round(toastY))
            
            toastX = toastX + monX
            toastY = toastY + monY
            if (|||); % tests si ça recontre des bords
                bool = 0;
            end
            %hold on;
            %plot(toastY, toastX, 'r+', 'MarkerSize', 3);
       end
       
       %hold on;
       plot(toastY, toastX, 'r.');
    end
    
    %hold on;
    %plot(mY, mX, 'r+', 'MarkerSize', 25);
    
    drawnow();
end

