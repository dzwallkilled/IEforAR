function cb = get_colorbar(dim)
h = figure;
cb = colormap(h,jet(dim));
close(h)
end