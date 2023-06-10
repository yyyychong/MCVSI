% Extract the original image name, encrypted image name, and corresponding mos value from the database to generate a mat file

fid = fopen('refname.txt', 'r');
fileLines1 = textread('refname.txt', '%s', 'delimiter', '\n');
fclose(fid);

fid = fopen('enname.txt', 'r');
fileLines2 = textread('enname.txt', '%s', 'delimiter', '\n');
fclose(fid);

mos=load('mos.txt');

refname = fileLines1(~cellfun(@isempty, fileLines1));
encname = fileLines2(~cellfun(@isempty, fileLines2));
save('ivc_ref_enc_mos.mat', 'refname','encname','mos');

output=load('ivc_ref_enc_mos.mat');
