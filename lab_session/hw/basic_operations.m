function [answer] = basic_operations(operation, x, y)
    if operation == '*'
        if size(x, 2) == size(y, 1)
            answer = x*y;
        else
            error('The second dimension of x and the first dimesion of y should be the same. The values now are: %d and %d', size(x, 2), size(y, 1))
        end
        
    elseif operation == '.*'
        if size(x) == size(y)
            answer = x.*y;
        else
            error('The dimensions should be the same')
        end
    
    elseif operation == '+'
        if size(x) == size(y)
            answer = x+y;
        else
            error('The dimensions should be the same')
        end
        
    elseif operation == '-'
        if size(x) == size(y)
            answer = x-y;
        else
            error('The dimensions should be the same')
        end
    
    elseif operation == '/'
        if det(y) ~= 0
            answer = x/y;
        else
            error('The second matrix should be invertible')
        end
    
    elseif operation == './'
        if size(x) == size(y)
            answer = x./y;
        else
            error('The dimensions should be the same')
        end
    end
