close all
clear
clc

d0 = readmatrix('d0.txt');
d0 = d0(1:434);
d1 = readmatrix('d1.txt');
d1 = d1(1:434);
d2 = readmatrix('d2.txt');
d2 = d2(1:434);
d3 = readmatrix('d3.txt');
d3 = d3(1:434);
d = [d0 d1 d2 d3];

a=0;
tic
for i = 0:3
    for phi = 0.05:0.05:0.5
        a = a+1;
        fprintf("Iteration %.1f: demand %.1f, phi %.1f \n", a,i,phi*100)
        
        FileName = sprintf( 'FileName: ["Solution_d%d_%dDiscount.csv" ]',i,round(phi*100));
        writelines(FileName,"FileName.txt")
        d_mat = ["d:["; d(:,i+1); "]"];
        writematrix(d_mat,"d.txt")
        phi_mat = ["phi:[ "; phi; "]"];
        writematrix(phi_mat,"phi.txt")

        moselexec('FixedCharge.mos')

        
    end
end
toc

phi = 0.2;
phi_mat = ["phi:[ "; phi; "]"];
writematrix(phi_mat,"phi.txt")