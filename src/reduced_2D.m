function [reduced_2d ] = reduced_2D(X)
    mu = mean(X);
    Xm = bsxfun(@minus, X, mu);
    C = cov(Xm);
    [V,D] = eig(C);

    % sort eigenvectors desc
    [D, i] = sort(diag(D), 'descend');
    V = V(:,i);

    reduced_2d = Xm *  V (:,1:2) ;

end

