function assort = assortativity(a, deg)
    in_vector = deg(a(:,1));
    out_vector = deg(a(:,2));
    
    ein_vector = [in_vector out_vector];
    eout_vector = [out_vector in_vector];
    
    % Uncommenting the following line plots a graph between the in_degrees
    % and the out_edges of an edge. Right being In and Left being Out.
    
    % figure();
    % plot(in_vector, out_vector, '.');
    % title('In degree vs Out degree for each edge in the graph')
    % xlabel('In Degree')
    % ylabel('Out Degree')
    
    assort = full(corr(ein_vector', eout_vector'));
end