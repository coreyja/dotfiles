# themer - theme installation instructions

## alfred

Simply open the files to import them into Alfred. Either double-click them in Finder or use the terminal:

    open 'alfred/themer-alfred-dark.alfredappearance'

## chrome

1. Launch Chrome and go to `chrome://extensions`.
2. Check the "Developer mode" checkbox at the top.
3. Click the "Load unpacked extension..." button and choose the desired theme directory (`chrome/Themer Dark`).

(To reset or remove the theme, visit `chrome://settings` and click "Reset to Default" in the "Appearance" section.)

## iterm

1. Launch iTerm
2. Press `command`-`I` to open the iTerm preferences
3. Choose Colors > Color Presets... > Import... and choose the generated theme file (`iterm/themer-iterm-dark.itermcolors`)

## alacritty

1. Paste the contents of `alacritty/Themer.yml` into your Alacritty config file.
2. Select the desired theme by setting the `colors` config key to reference the scheme's anchor (i.e., `colors: *light` or `colors: *dark`).

## terminal

1. Launch Terminal.app and open the preferences (`cmd`-`,`)
2. Click Profile > (gear icon) > Import...
3. Choose the generated file (`terminal/themer-dark.terminal`)

## slack

Copy the contents of `slack/themer-slack-dark.txt` and paste into the custom theme input in Slack's preferences.

## vim

Copy or symlink `vim/ThemerVim.vim` to `~/.vim/colors/`.

Then set the colorscheme in `.vimrc`:

    " The background option must be set before running this command.
    colo ThemerVim

## sublime-text

1. Copy (or symlink) the generated theme files (`sublime-text/themer-sublime-text-dark.tmTheme`) to the `User/` packages folder (you can see where this folder is located by choosing the "Browse Packages..." menu option in Sublime Text).
2. Choose the theme from the list of available color themes.

## vim-lightline

Make sure that the `background` option is set in `.vimrc`.

Copy or symlink `vim-lightline/ThemerVimLightline.vim` to `~/.vim/autoload/lightline/colorscheme/`.

Then set the colorscheme in `.vimrc`:

    let g:lightline = { 'colorscheme': 'ThemerVimLightline' }

## firefox-color

The Firefox Color add-on allows for simple theming without the need for a developer account or package review process by Mozilla.

1. Install the [Firefox Color add-on](https://addons.mozilla.org/en-US/firefox/addon/firefox-color/).
2. Open 'firefox-color/themer-dark.url' directly with Firefox.
3. Click "Yep" when prompted to apply the custom theme.

For a more fully featured Firefox theme, see themer's Firefox theme add-on generator.

## firefox-addon

To use the generated extension package, the code will need to be packaged up and signed by Mozilla.

To package the code in preparation for submission, the `web-ext` tool can be used:

    npx web-ext build --source-dir 'firefox-addon/Themer Dark'

Then the package can be submitted to Mozilla for review in the [Add-on Developer Hub](https://addons.mozilla.org/en-US/developers/addon/submit/distribution).

Learn more about Firefox themes from [extensionworkshop.com](https://extensionworkshop.com/documentation/themes/)

To theme Firefox without the need to create a developer account and go through the extension review process, see themer's integration with [Firefox Color](https://color.firefox.com).

## wallpaper-block-wave

Files generated:

* `wallpaper-block-wave/themer-wallpaper-block-wave-dark-3840x2160.svg`

## wallpaper-octagon

Files generated:

* `wallpaper-octagon/themer-wallpaper-octagon-dark-3840x2160.svg`

## wallpaper-triangles

Files generated:

* `wallpaper-triangles/themer-wallpaper-triangles-dark-3840x2160.svg`

## wallpaper-trianglify

Files generated:

* `wallpaper-trianglify/themer-wallpaper-trianglify-dark-3840x2160-0.75-1.svg`
* `wallpaper-trianglify/themer-wallpaper-trianglify-dark-3840x2160-0.75-2.svg`

## vim-lightline

Make sure that the `background` option is set in `.vimrc`.

Copy or symlink `vim-lightline/ThemerVimLightline.vim` to `~/.vim/autoload/lightline/colorscheme/`.

Then set the colorscheme in `.vimrc`:

    let g:lightline = { 'colorscheme': 'ThemerVimLightline' }