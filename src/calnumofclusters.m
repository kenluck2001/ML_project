function [x, y] = calnumofclusters(X)
	%(length x dimension)
	% datalength = size(X,1);
	% K is maximum possible number of clusters

    %[reduced_2d ] = reduced_2D(X);
	x = 5:34;
	y = zeros(1, 30);
	count = 0;
	for i = x,
		count = count + 1;
		y(count) = calError(X,i);
	end
end

	% plot(x, y);
	% xlabel('Number of clusters');
	% ylabel('Sum of Squared errors');
	% title('Determining the Optimal number of clusters');
