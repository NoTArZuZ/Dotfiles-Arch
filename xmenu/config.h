static struct Config config = {
	/* font, separate different fonts with comma */
	.font = "monospace:size=10",

	/* colors */
	.background_color = "#282c34",
	.foreground_color = "#bbc2cf",
	.selbackground_color = "#51afef",
	.selforeground_color = "#000000",
	.separator_color = "#282c34",
	.border_color = "#51afef",

	/* sizes in pixels */
	.width_pixels = 150,        /* minimum width of a menu */
	.height_pixels = 25,        /* height of a single menu item */
	.border_pixels = 2,         /* menu border */
	.separator_pixels = 1,      /* space around separator */
	.gap_pixels = 0,            /* gap between menus */
	.max_items = 0,             /* maximum number of items of a menu, 0 to compute based on monitor height */

	/* text alignment, set to LeftAlignment, CenterAlignment or RightAlignment */
	.alignment = LeftAlignment,

	/*
	 * The variables below cannot be set by X resources.
	 * Their values must be less than .height_pixels.
	 */

	/* geometry of the right-pointing isoceles triangle for submenus */
	.triangle_width = 5,
	.triangle_height = 9,

	/* the icon size is equal to .height_pixels - .iconpadding * 2 */
	.iconpadding = 2,

	/* area around the icon, the triangle and the separator */
	.horzpadding = 8,
};

/*
 * KEYBINDINGS
 *
 * Look at your /usr/include/X11/keysymdef.h  (or the equivalent file
 * in your system) for a list of key symbol constants, and change the
 * macros below accordingly.  All key symbol constants begin with the
 * prefix XK_.
 *
 * For example, to use vim-like key bindings, set KEYSYMLEFT to XK_h,
 * KEYSYMDOWN to XK_j, KEYSYMUP to XK_k, etc.
 *
 * Note that the regular keys like ArrowUp, ArrowDown, Tab, Home, etc
 * will ALWAYS work, so you do not need to set them.
 *
 * If you do not want to set a key binding, keep it with the value of
 * XK_VoidSymbol
 */
#define KSYMFIRST   XK_VoidSymbol       /* select first item */
#define KSYMLAST    XK_VoidSymbol       /* select last item */
#define KSYMUP      XK_VoidSymbol       /* select previous item */
#define KSYMDOWN    XK_VoidSymbol       /* select next item */
#define KSYMLEFT    XK_VoidSymbol       /* close current menu */
#define KSYMRIGHT   XK_VoidSymbol       /* enter selected item */
