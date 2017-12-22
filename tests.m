% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% où num_ref est le nombre d'objets de référence (le nombre d'images requêtes) 
% et 19 est le nombre d'images à retrouver pour chaque requête
function [recall, precision] = tests()
img_db_path = './db/';
img_db_list = glob([img_db_path, '*.gif']);
img_db_ref = glob('./dbq/*.gif');
img_db = cell(1);
label_db = cell(1);
fd_db = cell(1);
%%figure();

totalX = 0;
totalY = 0;

if(exist('descripteurRef.mat') ~= 2)
    DescRef = calculdesc(img_db_ref);
    save('DescripteurRef','DescRef');
end

load('DescripteurRef.mat','DescRef')

if(exist('descripteurTest.mat') ~= 2)
    DescTest = calculdesc(img_db_list);
    save('DescripteurTest','DescTest');
end

load('DescripteurTest.mat', 'DescTest')

for(im = 1 : 1);%%size(descripteurRef));
    for(test = 1 : size(DescTest));
        A = DescRef(im,:);
        B = DescTest(test,:);
        diff = A - B;
        d = norm(diff);
        distance(im,test) = d;
    end
end

distance = sort(distance);
