function chainC = chaincode(chain)
	% return Freeman Chain Code (chain must be a closed loop)
	%  3  2  1
	%   \ | /
	%4 -- P -- 0
	%   / | \
	%  5  6  7
    chainC = zeros(max(size(chain)),1);
	chain = [chain; chain(1,:)];
    for i=1:(max(size(chain))-1)
        %right
        if chain(i,1) < chain(i+1,1)
            if chain(i,2) == chain(i+1,2)
                chainC(i) = 0;
            elseif chain(i,2) < chain(i+1,2)
                chainC(i) = 1;
            elseif chain(i,2) > chain(i+1,2)
                chainC(i) = 7;
            end
            %left
        elseif chain(i,1) > chain(i+1,1)
            if chain(i,2) == chain(i+1,2)
                chainC(i) = 4;
            elseif chain(i,2) < chain(i+1,2)
                chainC(i) = 3;
            elseif chain(i,2) > chain(i+1,2)
                chainC(i) = 5;
            end
            %middle
        elseif chain(i,1) == chain(i+1,1)
            if chain(i,2) < chain(i+1,2)
                chainC(i) = 2;
            elseif chain(i,2) > chain(i+1,2)
                chainC(i) = 6;
            end
        end
    end
                