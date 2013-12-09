function [recognized_data ] = run_knn(Y, prototype, prototype_label)
    %perform knn classification given  a test data

    %take a subset of the training set

    [nlength, dimension] = size(Y);
    training_size = round (0.9 * nlength);

    N = training_size;

    Y_test = Y((training_size + 1): end , :); % testing data set

    %prototype = Y(c_final,:);

    dist_matrix = pdist2( Y_test, prototype, 'sqeuclidean'); 
    p = zeros(size(Y_test, 1), 1);
    [x, p] = min(dist_matrix, [], 2); %p contains the labels for each


    %prototype_label = [4 5 4 9 2 1 2 0 0 9 8 1 6 0 3 7 0 9 7];
    counter = 0;

    recognized_data = zeros(1, length(p));

    for val = 1:length(p),
        counter = counter + 1;
        recognized_data(counter) =  prototype_label(p(val));
    end
end
