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

Power.slow = 2750;
Power.fast = [4000 4600 5200];
Power.rapid = [30000 40250 50500];
Name1 = ["LowLow", "LowMed", "LowHi";
        "MedLow", "MedMed", "MedHi";
        "HiLow",  "HiMed",  "HiHi"];
Name(:,:,1) = Name1+"_d0.csv";
Name(:,:,2) = Name1+"_d1.csv";
Name(:,:,3) = Name1+"_d2.csv";
Name(:,:,4) = Name1+"_d3.csv";

a = 0;
tic

for k = 0:3
    d_mat = ["d:["; d(:,k+1); "]"];
    writematrix(d_mat,"d.txt")
for i = 1:3 % fast
    for j = 1:3 % rapid
        a = a+1;
        fprintf("Iteration %d : demand %d ",a,k )
        fprintf(Name1(i,j))
        fprintf("\n")

        FileName = 'FileName: ["' + Name(i,j,k+1) + '"]';
        writelines(FileName,"FileName.txt")
        E = [Power.slow Power.fast(i) Power.rapid(j)];
        E_mat = ["E:[ ";E';"]"];
        writematrix(E_mat,"E.txt")

        moselexec('FixedCharge.mos')

        
    end
end
end
toc

E = [2750 4600 40250];
E_mat = ["E:[ ";E';"]"];
writematrix(E_mat,"E.txt")