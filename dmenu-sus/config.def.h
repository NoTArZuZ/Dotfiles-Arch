/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom */
static int opacity = 0;                     /* -o  option; if 0, then alpha is disabled */
static int fuzzy = 1;                       /* -F  option; if 0, dmenu doesn't use fuzzy matching */
static int instant = 0;                     /* -n  option; if 1, selects matching item without the need to press enter */
static int center = 0;                      /* -c  option; if 0, dmenu won't be centered on the screen */
static int min_width = 500;                 /* minimum width when centered */
static const int vertpad = 0;              /* vertical padding of bar */
static const int sidepad = 0;              /* horizontal padding of bar */
static int restrict_return = 0;             /* -1 option; if 1, disables shift-return and ctrl-return */
/* -fn option overrides fonts[0]; default X11 font or font set */
static char *fonts[] =
{
	"monospace:size=10"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *dynamic     = NULL;      /* -dy option; dynamic command to run on input change */
static const char *symbol_1 = "<";
static const char *symbol_2 = ">";

static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeBorder] = { OPAQUE, OPAQUE, OPAQUE },
	[SchemeMid] = { OPAQUE, baralpha, borderalpha },
	[SchemeSelHighlight] = { OPAQUE, baralpha, borderalpha },
	[SchemeNormHighlight] = { OPAQUE, baralpha, borderalpha },
	[SchemeHp] = { OPAQUE, baralpha, borderalpha },
	[SchemeHover] = { OPAQUE, baralpha, borderalpha },
	[SchemeGreen] = { OPAQUE, baralpha, borderalpha },
	[SchemeRed] = { OPAQUE, baralpha, borderalpha },
	[SchemeYellow] = { OPAQUE, baralpha, borderalpha },
	[SchemeBlue] = { OPAQUE, baralpha, borderalpha },
	[SchemePurple] = { OPAQUE, baralpha, borderalpha },
};

static
char *colors[][2] = {
	/*               fg         bg       */
	[SchemeNorm] =          { "#bbc2cf", "#282c34" },
	[SchemeSel]  =          { "#1c1f24", "#51afef" },
	[SchemeOut]  =          { "#1c1f24", "#46d9ff" },
	[SchemeBorder] =        { "#000000", "#51afef" },
	[SchemeMid]  =          { "#d7d7d7", "#1c1f24" },
	[SchemeSelHighlight]  = { "#98be65", "#000000" },
	[SchemeNormHighlight] = { "#98be65", "#000000" },
	[SchemeHp]   =          { "#1c1f24", "#98be65" },
	[SchemeHover]  =        { "#1c1f24", "#51afef" },
	[SchemeGreen]  =        { "#e6e6e6", "#98be65" },
	[SchemeRed]    =        { "#e6e6e6", "#ff6c6b" },
	[SchemeYellow] =        { "#e6e6e6", "#da8548" },
	[SchemeBlue]   =        { "#e6e6e6", "#51afef" },
	[SchemePurple] =        { "#e6e6e6", "#c678dd" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;
/* -g option; if nonzero, dmenu uses a grid comprised of columns and lines */
static unsigned int columns    = 0;
static unsigned int lineheight = 0;         /* -h option; minimum height of a menu line     */
static unsigned int min_lineheight = 8;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 0;

/*
 * Use prefix matching by default; can be inverted with the -x flag.
 */
static int use_prefix = 0;
