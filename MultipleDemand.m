close all
clear
clc


d3 = readmatrix('d3.txt');
d3 = d3(1:434);
m = 1.5:0.5:3;
I = length(m);

for i = 1:I
    FileName = sprintf( 'FileName: ["Solution_%dhalf_times_demand.csv" ]',i+2);
    FileName = convertCharsToStrings(FileName);
    writelines(FileName,"FileName.txt")
    d_mat = ["d:["; d3*m(i); "]"];
    writematrix(d_mat,"d.txt")

    moselexec('FixedCharge.mos')


end


