function install_brew -d "installs homebrew programs"
    echo  "installing  homebrew programs"
    brew install git # install git
    brew install wget # install wget
    brew install helix # install helix editor
    brew install eza  # install  https://github.com/eza-community/eza
    brew install flawfinder #  install flawfinder
    brew install clang-format # install clang-format
    brew install curl # install curl
    brew install fontconfig # install fontconfig
    brew install fzf
    eval (brew --prefix)/opt/fzf/install
    brew install fd # install https://github.com/sharkdp/fd
    brew install go-task
    brew tap cantino/mcfly
    brew install pnpm
    brew install node
    brew install fish
    brew install zoxide
    brew install navi # https://github.com/denisidoro/navi
    brew install --cask alfred
    brew install --cask cheatsheet
    brew install --cask betterdisplay
    brew install --cask discord
    brew install --cask telegram
    brew install --cask wezterm
    brew install --cask temurin
    brew install --cask paw
    brew install --cask firefox-developer-edition
    brew install --cask visual-studio-code
end

function install_fisher -d "installs fisher"
    echo "installing fisher"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

function install_fish_plugins -d "installs fish plugins"
    fisher install IlanCosman/tide@v5
    fisher install franciscolourenco/done
    fisher install jethrokuan/z
    fisher install wfxr/forgit
    fisher install jorgebucaran/autopair.fish
    fisher install jorgebucaran/getopts.fish
    fisher install jorgebucaran/fishtape
    fisher install gazorby/fish-abbreviation-tips
    fisher install FabioAntunes/base16-fish-shell
    fisher install nickeb96/puffer-fish
end