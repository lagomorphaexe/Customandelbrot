# Customandelbrot v3.0.2
Customandelbrot is a program created to view Mandelbrot and Julia Sets of polynomial-like mappings
It also offers very high levels of customization (hence the name).

# Customization

## Parameter Bar

To the right of the screen is the Parameter Bar.
- Julia Mode:    *Determines the type of fractal being shown*  
- Coloring Mode: *Color scheme*  
- Pixel Size:    *Image resolution; lower pixel size looks better but takes longer to render*  
- Iterations:    *Fractal resolution; more iterations show more points outside of the fractal but take longer to render points inside the fractal*  
- Color Rate:    *Speed of color change, with 1 being a constant color*  
- Color Start:   *Initial color gradient displacement*  
- Zoom:          *Zoom Depth of image*  
- Scale List:    *Scaling of constant term added every iteration. E.g., 1 is the default, 0 does not add anything, 2 adds twice the constant term, etc.*  
- Power List:    *Transform at every iteration, in form z -> z^n + c; can take non-integer and negative arguments. Additional Special forms:*  
	- 999: Burning Ship          a+bi -> (|a| + |b|i)^2 + c  
	- 998: Mandelbar (3)            z -> (z*)^2 + c  
	- 997: Inv. Mandelbar           z -> (z*)^{-2} + c  
	- 996: Mandelbar (4)            z -> (z*)^3 + c  
	- 995: City-blocks           a+bi -> a^3 - ab^2i - a^2b + b^3i + c  
	- 994:                          z -> z^2/(z+1) + c  
	- 993:                          z -> (z - sgn(Re(z)))/l  
	- 992:                          z -> ( z - 1 )/l or (z + 1)/l* based on sgn(Re(z))  
	- 991: Logistic Map             z -> zc(1-z)  
- Mandelbrot/Julia Location:   *Initial value (for Mandelbrot) or constant term (for Julia) added every iteration*  
- List Wrap:    *Whether Scale and Power lists wrap; if off, they will continue with the last value indefinitely*  
- Mandelbar:    *Whether the "mandelbar" mode is on. Mandelbars are made by iterating on z̄ instead of z*  
- Alt Preview:  *Whether a popup window comes up to show the Julia/Mandelbrot set with "location" at cursor position*  
- Color Invert: *If off, coloring is based on how long points take to escape. If on, points are colored by the minimal distance they get to the origin. See keybind " for additional info*  
- Overflow:     *The radius of the ball centered at the origin that determines whether a point has escaped or not. For single-length integer powerlists, 2 works perfectly*  
- Render Center:*The center of the current render*  
- Input Power:  *The transform on the constant term (like Scale List), but takes an argument of power-list-like powers. E.g., 2 would square the added constant*  

## Keybinds

- ←↑→↓:  
	- Alt: *moves things in finer detail*  
	- Shift: *moves J/M location*  
	- Ctrl: *Bulb select, to show how orbits converge*  
	- No Shift or Ctrl: *move render center*  
	- If in parameter bar: *scroll up/down*  
- W, S: *Incr/Decr Overflow*  
- Q, A: *Incr/Decr Color Rate*  
- R, O: *Resets most parameters and J/M location, respectively*  
- J:    *Toggles Julia Mode*  
- +, -: *Zooms in/out on Alt Preview*  
- \:    *Toggles Alt Preview*  
- [, ]: *Zooms in/out on current render, but **less** than on mouse click*  
- ':    *Toggles Color Invert*  
- ":    *Toggles Smooth Coloring if no Color Invert, else toggles whether points outside fractal are colored*  
- |:    *Toggles Distance Estimation Coloring Mode. Currently this is semi-broken for powerlist not equal to 2*  
- $:    *Toggles extra mouse position info display*  
- 1-9:  *Sets pixel size with numeric keys*  

## On Mouse Click  

- *Left-click: zoom in*  
- *Right-click: zoom out*  
- *Shift: set opposite J/M location at cursor position*  
- *Alt: Toggle orbit-viewing mode. If Alt is held normally without click while this mode is on, orbit is viewed deeper*  

# Saving/Loading

- Text Box: *Contains the name of the set to be saved (as image or data) or deleted*  
- [+]:      *Saves the data of the current image for later use*  
To the left of the screen is a bar that allows for the saving and loading of sets.  
- [-]:      *Removes the data of the named set*  
- [↓]:      *Downloads the set with the name entered as a png. If none is given, it is downloaded with a unique timestamp*.  
Clicking on the name of a saved set's data will automatically load it.  

# Requirements

Processing 3.0 or later (ideally Processing 3.5.4)  

# Contributing

Pull requests are welcome.  

# Status

Customandelbrot is hopefully mostly done, for now. I'll try to add Fatou/equipotential lines soon as well.  

# Acknowledgements

- Wikipedia (namely articles on Julia and Mandelbrot Sets)  
- *Fractals Everywhere*, by Michael Barnsley  
