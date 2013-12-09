function [c_index ] = run_K_medoid(Y, K)

    [nlength, dimension] = size(Y);
    training_size = round (0.9 * nlength);

    N = training_size;

    % calculate similarity matrix
    S = zeros(N,N);


    Y_train = Y(1:training_size , :); % training data set

    for i=1:N
        d = sqrt(sum( (repmat(Y_train(i,:),N,1) - Y_train).^2, 2 )); % distance
        S(i,:) = -d; % negative distance is similarity
    end

    % initialize centroids 
    c = zeros(1,K);
    for i=1:K,
        c(i) = randi([1 N]);
    end

    [c_final, a] = mykmedoids(S, c);
    c_index = c_final;


end

