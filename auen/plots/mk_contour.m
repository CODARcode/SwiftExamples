
# MK_CONTOUR.M (Octave)

# graphics_toolkit gnuplot

fig = figure;
set(fig, "visible", "off");

# Reusable coordinates
x  = load("coords_x.dat");
y  = load("coords_y.dat");

vl = load("vl.dat");
p = contour(x,y,vl);

xlabel("N1");
ylabel("NE");

print("vl.eps");

tm = load("tm.dat");
p = contour(x,y,tm);

xlabel("N1");
ylabel("NE");

print("tm.eps");
