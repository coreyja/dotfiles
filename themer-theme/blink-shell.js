const Color = require('color');

const MIX = 0.2;

const brightMix = (colors, key, isDark) =>
  Color(colors[key])
    .mix(isDark ? Color(colors.shade7) : Color(colors.shade0), MIX)
    .hex();

const renderTheme = (colors, isDark) => `
black       = '${colors.shade0}';
red         = '${colors.accent0}'; // red
green       = '${colors.accent1}'; // green
yellow      = '${colors.accent2}'; // yellow
blue        = '${colors.accent3}'; // blue
magenta     = '${colors.accent4}'; // pink
cyan        = '${colors.accent5}'; // cyan
white       = '${colors.shade6}'; // light gray
lightBlack  = '${colors.shade4}'; // medium gray
lightRed    = '${brightMix(colors, 'accent0', isDark)}'; // red
lightGreen  = '${brightMix(colors, 'accent1', isDark)}'; // green
lightYellow = '${brightMix(colors, 'accent2', isDark)}'; // yellow
lightBlue   = '${brightMix(colors, 'accent3', isDark)}'; // blue
lightMagenta= '${brightMix(colors, 'accent4', isDark)}'; // pink
lightCyan   = '${brightMix(colors, 'accent5', isDark)}'; // cyan
lightWhite  = '${colors.shade4}'; // white

t.prefs_.set('color-palette-overrides',
                 [ black , red     , green  , yellow,
                  blue     , magenta , cyan   , white,
                  lightBlack   , lightRed  , lightGreen , lightYellow,
                  lightBlue    , lightMagenta  , lightCyan  , lightWhite ]);

t.prefs_.set('cursor-color', '${colors.accent6}');
t.prefs_.set('foreground-color', '${colors.shade6}');
t.prefs_.set('background-color', '${colors.shade0}');
`;

const render = (colors) =>
  Object.entries(colors).map(async ([name, colors]) => ({
    name: `themer-${name}.js`,
    contents: Buffer.from(renderTheme(colors, name === 'dark'), 'utf8'),
  }));

module.exports = {
  render,
};
