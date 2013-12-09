function [prototypes, recognized_character, X_test] = mainfunction(data_size)
    % load data 
    X = loadmnist(data_size);
    [nlength, dimension] = size(X);
    training_size = round (0.9 * nlength);


    % perform feature scaling on the input data

	Y = X-mean(X(:));
	Y = Y / std(Y(:));


    % estimate the numbers of clusters using cross-validation
    %[x, y] = calnumofclusters(Y);



    %datafile = fopen('store.txt','a');
    %if datafile == -1
    %    error('Error opening data file!');
    %end


    %fprintf(datafile,'%s\n', '############### Cross-Validation ##############################');
    %for vind = 1:length(y),
    %    fprintf(datafile, '%d,%d\n', x( vind ) , y( vind ));     
    %end

    %set value for K as number of clusters
    K = 25;
    c_index = run_K_medoid(Y, K); %run K-medoid to obtain clusters
    prototypes = X(c_index ,:);
    prototypes_norm = Y(c_index ,:);

    %visualize the prototypes
    visual(prototypes);

    %assign labels to prototypes based on current run
    prototype_label = [8 4 2 1 4 1 0 8 6 6 5 1 8 0 1 5 9 6 3 3 0 7 2 5 4];

    recognized_character = run_knn(Y, prototypes_norm, prototype_label);


    X_test = X((training_size + 1): end , :); % testing data set

    %visual testing data and make comparison with recognized characters to compute accuracy
    visual(X_test); 

    %fclose(datafile);

end
