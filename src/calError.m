function [sumValue ] = calError(X, kv)
	[nlength, dimension] = size(X);
	num_of_fold = 10;
    Xmodified = X;
    Xmodified(:,(dimension + 1) ) = zeros(nlength, 1);

    % shuffle a matrix
    Xmodified = Xmodified( randperm(nlength),:);
    count = 0;
    mid_value = round (nlength / num_of_fold);
    for i=1:mid_value:nlength,
    	start_index = i;
    	end_index = start_index + mid_value;
    	if  end_index > nlength,
    		end_index = nlength;
    	end
    	count = count + 1;
    	%randomly split your data set into 10 parts
    	Xmodified(start_index : end_index, (dimension + 1) ) = count;
    end

    training_matrix = [];
    training_matrix_2= [];
    training_matrix_1 = [];
    testing_matrix = [];

    Xmodified = Xmodified((1:nlength), :);
    sumValue = 0;
    %training set
    for i = 1:num_of_fold,
    	selectedrows = find(Xmodified( :, (dimension + 1) ) == i);
    	unique_array = Xmodified(selectedrows,:);
    	testing_matrix = [unique_array;];
    	testing_matrix = testing_matrix(:,(1 : dimension));


        for p = i+1:10,
            selectedrows = find(Xmodified( :, (dimension + 1) ) == p);
            unique_array = Xmodified(selectedrows,:);
            training_matrix_1 = [training_matrix_1; unique_array;];
        end

    	%get missing items

        for k=1:i-1,
            selectedrows = find(Xmodified( :, (dimension + 1) ) == k);
            unique_array = Xmodified(selectedrows,:);
            training_matrix_2 = [training_matrix_2; unique_array;]	;
        end

        training_matrix = [training_matrix_1; training_matrix_2];
        training_matrix = training_matrix(:,(1 : dimension));

        %rand_centroids = randn ( kv, dimension );
        %[centroids, pointsInCluster, assignment]= mynewkmeans( training_matrix, kv);
        [centroids, pointsInCluster, assignment]= mykmeans(training_matrix, kv);
		%[centroids, y] = mykmeans(training_matrix, rand_centroids);
        centroids(~isfinite(centroids))=0; %remove infinite or Nan values



        %for k=1:kv,
            %selectedrows = find(Xmodified( :, (dimension + 1) ) == k);
            %unique_array = Xmodified(selectedrows,:);
            %X_clusterdata = [unique_array;];

            %X_clusterdata = X_clusterdata(:,(1 : dimension)); % items in a clusters
            %for  indv=1:size(testing_matrix,1),
                %[dummy,index] = ismember( testing_matrix(indv, : ), X_clusterdata, 'rows');
                %if index > 0,
                %calculate distance between testing data to the nearest centroid

                %sumValue = sumValue +  (testing_matrix( indv,: ) - centroids( k,: )).^2;
                %end
            %end

        %end

        dist_matrix = pdist2( testing_matrix, centroids, 'sqeuclidean'); 
        p = zeros(size(testing_matrix, 1), 1);
        [x, p] = min(dist_matrix, [], 2); %p contains the minimum distance by row

	    %dist_matrix = pdist2( testing_matrix, centroids, 'sqeuclidean');
        %dist_matrix(any(isnan(dist_matrix),2),:)=[];
        %dist_matrix(~isfinite(dist_matrix))=0; 
	    %sum_of_squared_errors = sum(sum(dist_matrix)); % euclidean distance

	    %sumValue = sumValue +  sum_of_squared_errors;
        sumValue  = sumValue + sum( x );
    end
    
    %sumValue  = sqrt(sumValue)/ kv; 
    %sumValue =  sumValue / (size(testing_matrix,1) * kv^2) ;
end
