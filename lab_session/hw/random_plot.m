function random_plot
    x = linspace(-10, 10, 20);
    y = (1-2*x+3*x.^2)./(1+2*x+3*x.^2);
    
    plot(x,y, '.-')