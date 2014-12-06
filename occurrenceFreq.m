function freq = occurrenceFreq(A, num)
	%Count occurence frequency of numbers 0:num
	freq = zeros(1,num);
	total = length(A);
	for n=0:num-1
	    for i=1:total
	        if A(i) == n
	            freq(n+1) = freq(n+1) + 1;
	        end
	    end
	    freq(n+1) = freq(n+1) / total;
	end