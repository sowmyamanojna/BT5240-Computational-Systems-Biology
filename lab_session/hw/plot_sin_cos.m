function plot_sin_cos
theta = -2*pi:0.01:2*pi;
sin_vals = sin(theta);
cos_vals = cos(theta);

figure;
subplot(2,1,1)
plot(theta, sin_vals, '.-')

subplot(2,1,2)
plot(theta, cos_vals, '.-')

end
