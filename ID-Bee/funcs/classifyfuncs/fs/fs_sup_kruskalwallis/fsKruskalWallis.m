function [out] = fsKruskalWallis(X, Y)

[~, n] = size(X);
out.W = zeros(n,1);

for i=1:n
    out.W(i) = -kruskalwallis(vertcat(X(:,i)', Y'),{},'off');
end

[~, out.fList] = sort(out.W, 'descend');
out.prf = 1;
end