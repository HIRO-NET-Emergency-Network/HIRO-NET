function [V,matrix_adj]= generateAdjMatrix(N_poi)

V = 1+N_poi;
matrix_adj = ones(V,V)-eye(V);

end