function [vrc ] = calErrorCH(X, kv)
    [nlength, dimension] = size(X);
    Xmodified = X;

    total_means = mean(X);
    A = 1:kv;
    [centroid, pointsInCluster, assignment]= mykmeans(X, kv);
    vassignment = assignment;
    B = unique(assignment);
    C = setdiff(A,B);
    while(length(C) > 1 )
        [centroid, pointsInCluster, assignment]= mykmeans(X, kv);
        B = unique(assignment);
        C = setdiff(A,B);  
        vassignment = assignment;                    
    end
   
    dist_matrix = pdist2( X, total_means, 'sqeuclidean'); 
    newarray = sum(dist_matrix,2);
    [B, IX] = sort(newarray, 1);
    %get length of set difference

    length_of_bucket= nlength / (4 * kv);
    length_of_bucket= round( length_of_bucket ); 
    % avoid empty clusters at all cost
    count = 1;
    for val = C,
        end_index = nlength - ((count-1) * length_of_bucket);
        index = IX( (end_index - length_of_bucket ) : end_index);
        count = count + 1;
        vassignment(index) = val;
    end


    Xmodified(:,(dimension + 1) ) = vassignment;

    cluster_means = zeros(kv, dimension); % m_i

    ss_b = 0;
    for k=1:kv,
        selectedrows = find(Xmodified( :, (dimension + 1) ) == k);
        unique_array = Xmodified(selectedrows,:);
        X_clusterdata = [unique_array;];
        X_clusterdata = X_clusterdata(:,(1 : dimension)); % items in a clusters
        num_of_elem_clusters = size(X_clusterdata, 1);
        if num_of_elem_clusters > 0,
        %calculate mean for each cluster
            cluster_means(k, : ) = sum(X_clusterdata , 1)/(num_of_elem_clusters );

            ss_b = ss_b + ( num_of_elem_clusters * sum((cluster_means (k, : ) - total_means).^2) );
        end
    end


    ss_w = 0;
    inner_sum = 0;
    for k=1:kv,
        selectedrows = find(Xmodified( :, (dimension + 1) ) == k);
        unique_array = Xmodified(selectedrows,:);
        X_clusterdata = [unique_array;];
        X_clusterdata = X_clusterdata(:,(1 : dimension)); % items in a clusters

        num_of_elem_clusters = size(X_clusterdata, 1);
        for i = 1:num_of_elem_clusters,
            ss_w = ss_w + sqrt(sum((X_clusterdata(i, : ) - cluster_means (k, : )).^2) );
        end
    end

    vrc =  (ss_b / ss_w ) * ((nlength - kv) / (kv - 1)); 
 
end

