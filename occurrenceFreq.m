function freq = occurrenceFreq(A)
	%Count occurence frequency of numbers 0:7
	freq = [0 0 0 0 0 0 0 0];
	total = max(size(A));
	for n=0:7
	    for i=1:total
	        if A(i) == n
	            freq(n+1) = freq(n+1) + 1;
	        end
	    end
	    freq(n+1) = freq(n+1) / total;
	end