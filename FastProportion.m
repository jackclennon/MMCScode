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
    for R = 0:0.2:0.6
        a = a+1;
        fprintf("Iteration %d, demand %d, R %.2f \n",a,i,R)
        
        FileName = sprintf( 'FileName: ["Solution_d%d_%dFast.csv" ]',i,round(R*100));
        writelines(FileName,"FileName.txt")
        d_mat = ["d:["; d(:,i+1); "]"];
        writematrix(d_mat,"d.txt")
        R_mat = ["R:[ "; R; "]"];
        writematrix(R_mat,"R.txt")

        moselexec('FixedCharge.mos')

        
    end
end
toc

R = 0.71;
R_mat = ["R:[ "; R; "]"];
writematrix(R_mat,"R.txt")