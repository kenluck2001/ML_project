function [x, y] = calnumofclustersCH(X)
	%(length x dimension)
	% datalength = size(X,1);
	% K is maximum possible number of clusters

	x = 5:20;
	y = zeros(1, 15);
	count = 0;
	for i = x,
		count = count + 1;
        y(count) = calErrorCH(X,i);
	end
end

	% plot(x, y);
	% xlabel('Number of clusters');
	% ylabel('Sum of Squared errors');
	% title('Determining the Optimal number of clusters');
