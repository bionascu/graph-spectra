%% Spectral Graph Clustering Algorithm
% Diego Yus
% 02/12/2107
clc; clear all; close all;

%% Main

% Read data
path_file = fullfile('..','data','example1.dat');
E = csvread(path_file);

% Shuffle edges order
E = E(randperm(size(E,1))',:);

% Toy Example
% E = [1,2; 1,3; 2,1; 2,3; 2,4; 3,1; 3,2; 4,2; 4,5; 4,6; 5,4; 5,6; 6,4; 6,5];

%% Algorithm

% 1.a Convert list to adjacency matrix  (affinity matrix)
col1 = E(:,1);
col2 = E(:,2);
max_ids = max(max(col1,col2));
As = sparse(col1, col2, 1, max_ids, max_ids); 
A = full(As);

% 2. Define D (sum of A's rows into diag mat.) 
% and L (Normalized Laplacian) ( L = D^(-1/2)AD(-1/2) )
D = diag(sum(A,2));
L = (D^(-0.5)) * A * (D^(-0.5));

% 3a. Find k largest eigenvectors of L and stack them into X
% [X,D1] = eigs(L, k); 
[X, D1] = eigs(L, size(L,1)-1); % size(L) - 1 to use eigs() instead of eig()

% 3b. Detect optimal k and crop X matrix
eigenvalues = diag(D1);
eig_gaps = -1*diff(eigenvalues); 
    % -1* used because eigenvalues is sorted 
    % in desc. order so diffs are negatives.
 
% threshold = 0.05;
% k = 1;
% while eig_gaps(k) < threshold
%     k = k + 1;
% end
[~,k] = max(eig_gaps);

X = X(:,(1:k));

% 4. Create Y by renormalizing each of X's rows to have unit length
Y = X./(sum(X.^2,2)).^(0.5);

% 5. Apply K-means to rows of Y
Idx = kmeans(Y, k);

% 6. Assign original point s_i to cluster j iff row i of matrix Y was 
% assigned to cluster j
    % Nothing to be done here


% Plotting edges in circular graph with already separated clusters.
x0=10; % x0 and y0 are center coordinates
y0=20;  
r=100;  % radius
angle=-pi:0.01:pi;
angl=angle(randi(numel(angle),length(A),1));
angl = sort(angl)'; % Get angles for the circle positions (can be improved)

[aux1, auxidx] = sort(Idx); % Separate clusters
angl = angl(auxidx,:); % Put clusters in separate angles.
x=r*cos(angl)+x0;
y=r*sin(angl)+y0;

% Plotting function
coordinates = [x y];
gplot(A, coordinates);


