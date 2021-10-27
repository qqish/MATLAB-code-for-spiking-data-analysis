%% Function for computing the euclidean distance
function [D] = euc_distance(x,y)
DiffX = bsxfun(@minus,x,y);
DistX =sqrt(sum(DiffX.^2,2));
D = squeeze(DistX);
end