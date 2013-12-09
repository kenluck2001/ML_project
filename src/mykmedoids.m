function [c, a] = mykmedoids(S, c)

  % INPUT
  % S ... similarity matrix
  % c ... initial medoids index (remember, medoid is always a data point)
  % 
  % OUTPUT
  % c ... final cluster medoids index
  % a ... cluster assignments for each datapoint of X

  K = length(c);
  N = size(S,1);
  % K ... number of clusters
  % N ... number of data vectors

  epsi = 1e-7; % small number, used in stoppinc criterion
  cnt_max = 100; % maximum number of iterations, to not end up in endless loop
  a = zeros(N,1);

  for i=1:cnt_max

    fprintf('[%d]',i) % show the progress
    % find maximum similarity, i.e. update cluster assignments 'a'
    for j=1:N
      [dummy, aj] = max(S(j,c));
      a(j) = aj;
    end


    % calculate new medoids: Set each medoid to be the object in the cluster 
    % which has the maximal sum of similarities to the objects in the cluster
    new_c = zeros(1,K);
    for k=1:K
      clusterobj = find(a==k); % objects assigned to cluster k
      Slocal = S(clusterobj,clusterobj); % local similarity matrix
      thesums = sum(Slocal,2); % sum of all similarities of each point in
                               % k-th cluster to all points in k-th cluster
      [dummy, indi] = max(thesums);
      new_c(k) = clusterobj(indi); % new medoid
    end

    % check for convergence
    if (max(abs(new_c-c)) < epsi)
      fprintf('\n k-medoids converged after %d iterations\n', i) 
      c = new_c; % return latest cluster medoids
      break % stop if means don't change too much anymore
    end

    c = new_c; % latest medoids will be updated in next run

    if (i == cnt_max)
      fprintf('\n k-medoids did not converge after %d iterations\n', cnt_max)
      break
    end

  end

