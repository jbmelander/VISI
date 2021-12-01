function [figure_data] = fig2rgb(fname)
figure_handle = openfig(fname);
figure_data = getimage(figure_handle);
close(figure_handle);


max_pixel_value = double(max(max(figure_data)));
figure_data = double(figure_data);
figure_data = figure_data / max_pixel_value;
figure_data = cat(3, figure_data, figure_data, figure_data);