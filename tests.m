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

for im = 1:numel(img_db_list);
    totalX = 0;
    totalY = 0;
    img_db{im} = logical(imread(img_db_list{im}));
    label_db{im} = get_label(img_db_list{im});
    clf;imshow(img_db{im});
    disp(label_db{im}); 
    

    [x, y] = find(img_db{im});
    mX = mean(x);
    mY = mean(y);
    
    hold on;
    plot(mY, mX, 'r+', 'MarkerSize', 25)
    
    drawnow();
end

