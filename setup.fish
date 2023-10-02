function _fish_config -d "downloads fish config file"
    set -l url "https://gist.githubusercontent.com/g5becks/16c0c319ab3c11b56d7617131ca367a2/raw/98a92952f1057160cc9ad26e8fe625928a8180ab/config.fish"
    set -l dl_file ~/.config/fish/config.fish
    if not test -e $dl_file
        command touch $dl_file
    end
    echo "downloading config.fish"
    if command curl $url >$dl_file
        echo "config.fish downloaded successfully"
    else
        echo "failed to download config.fish"
    end

end

function _install_fisher -d "installs jorgebucaran/fisher"
    echo "attempting to install jorgebucaran/fisher"
    if command curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
        echo "fisher installed successfully"
    else
        echo "fisher install failed"
    end
end

function _install_plugins -d "installs fish plugins"
    set -l plugins Gazorby/fish-abbreviation-tips jorgebucaran/fish-bax franciscolourenco/done jorgebucaran/fish-spark joseluisq/gitnow@2.3.0 laughedelic/pisces jorgebucaran/fish-nvm jethrokuan/z

    echo "attempting to install fish plugins"
    for plugin in $plugins
        fisher add $plugin
    end
end

function _kitty_setup -d "kitty desktop integration"
    set -l bin_file ~/.local/kitty.app/bin/kitty
    set -l bin ~/.local/bin/
    echo "setting up kitty shell"
    # Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
    # your PATH)
    if not test -x $bin
        command mkdir -p $bin
    end
    ln -s $bin_file ~/.local/bin/
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
    # Update the path to the kitty icon in the kitty.desktop file
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop

end

function _kitty_conf -d "installs kitty conf"
    set -l dl_file ~/.config/kitty/kitty.conf
    set -l url "https://gist.githubusercontent.com/g5becks/8cb4a040dbb10b516ba6b5eeaf2abbc5/raw/5c8ba08a625f7025487bed992228594d328f0ef6/kitty.conf"
    echo "attempting to download kitty conf"
    if not test -e $dl_file
        command touch $dl_file
    end
    if command curl $url >$dl_file
        echo "kitty conf downloaded successfully"
    else
        "kitty conf download failed"
    end

end

function _kitty_theme -d "sets kitty theme"
    set -l dl_file ~/.config/kitty/theme.conf
    set -l url "https://gist.githubusercontent.com/g5becks/d7f0cae5643e5b8b4ea948bb8c640b96/raw/1a0b6e61ecfa3cd64c28863a43fc6b776b147959/theme.conf"
    echo "attempting to download kitty theme"
    if not test -e $dl_file
        command touch $dl_file
    end
    if command curl $url >$dl_file
        echo "kitty theme installed"
    else
        echo "failed to install kitty theme"
    end

end

function _install_kitty -d "installs kitty shell"
    echo "attempting to install kitty"
    if command curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
        echo "kitty installed successfully"
    else
        echo "kitty installation failed"
    end
    _kitty_setup
    _kitty_conf
    _kitty_theme
end

function _download_hasklug -d "downloads hasklug_nerd_font"
    set -l url "https://poppnfiles.imfast.io/Hasklig.zip"
    echo "attempting to download hasklig nerd font"
    if command wget $url
        echo "hasklug_nerd_font downloaded successfully"
    else
        "hasklig download failed"
    end

end

function _download_cartograph -d "downloads cartograph ch font"
    set -l url "https://poppnfiles.imfast.io/Cartograph.zip"
    echo "attempting to download cartograph font"
    if command wget $url
        echo "cartograph font downloaded successfully"
    else
        echo "failed to download cartograph font"
    end
end

function _unzip_fonts -d "unzip all font packages"
    set -l files ~/Cartograph.zip ~/Hasklig.zip
    command mkdir ~/fonts
    echo "unzipping files"
    for font in $files
        if command unzip $font -d ~/fonts
            echo "$font unzipped"
        else
            echo "failed to unzip $font"
        end
    end
end

function _create_dev_folder -d "creates development folder"
    "echo creating development folder"
    command mkdir -p ~/Dev/.history
end

function _install_fonts -d "installs all downloaded fonts"
    set -l fonts_dir ~/.local/share/fonts/
    set -l trash ~/fonts ~/Cartograph.zip ~/Hasklig.zip
    _download_cartograph
    _download_hasklug
    _unzip_fonts
    if test -e $fonts_dir
        echo "moving fonts to fonts directory"
        command cp ~/fonts/*.otf $fonts_dir
        command cp ~/fonts/Cartograph/*.otf $fonts_dir
    else
        echo "no fonts directory found, creating now..."
        command mkdir -p $fonts_dir
        echo "moving fonts to fonts directory"
        command cp ~/fonts/*.otf $fonts_dir
        command cp ~/fonts/Cartograph/*.otf $fonts_dir
    end
    echo "clearing and regenerating font cache"
    if command fc-cache -f -v
        echo "fonts installed successfully"
        echo "cleaning up files"
        for t in $trash
            command rm -rf $t
        end
        echo "font installation complete"
    else
        echo "an issue occurred regenerating fonts cache"
    end
end

function _install_jq -d "installs jq"
    echo "installing jq"
    if command sudo snap install jq
        echo "jq installed successfully"
    else
        echo "failed to install jq"
    end
end

function _install_snapd -d "installs snapd"
    echo "updating packages"
    command sudo apt update -y
    echo "installing snapd"
    if command sudo apt install -y snapd
        echo "snapd installed"
        echo "refreshing snapd"
        command snap refresh
    else
        echo "failed to install snapd"
    end
end

function _install_androidstudio -d "installs android studio"
    echo "installing android studio"
    if command sudo snap install android-studio --classic
        echo "android studio installed"
    else
        "failed to install android studio+"
    end
end

function _install_remmina -d "installs remmina"
    echo "installing remmina"
    if command sudo snap install remmina
        echo "connecting remmina snap"
        command sudo snap connect remmina:avahi-observe :avahi-observe
        command sudo snap connect remmina:cups-control :cups-control
        command sudo snap connect remmina:mount-observe :mount-observe
        command sudo snap connect remmina:password-manager-service :password-manager-service
        echo "remmina installed"
    else
        echo "failed to install remmina"
    end
end

function _install_rust -d "isntalls rust"
    echo "attempting to install rust"
    if command curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        echo "rust installed successfully"
    else
        echo "failed to install rust"
    end
end

function _install_docker -d "installs docker"
    echo "installing docker"
    if command sudo snap install docker
        echo "docker installed"
    else
        echo "failed to install docker"
    end
end

function _install_couch_db -d "installs couchdb"
    echo "installing couchdb"
    if command sudo snap install couchdb --channel=3.x/stable
        echo "couchdb installed successfully"
    else
        echo "failed to install couchdb"
    end
end

function _install_task -d "install taskfile.dev"
    echo "installing taskfile.dev"
    if command sudo snap install task --classic
        echo "taskfile installed"
    else
        echo "failed to install taskfile"
    end
end

function _install_zeal -d "installs zeal"
    echo "updating packages"
    command sudo apt update -y
    echo "installing zeal"
    if command sudo apt install -y zeal
        echo "zeal installed"
    else
        echo "failed to install zeal"
    end
end

function _install_htop -d "installs htop"
    echo "installing htop"
    if command sudo snap install htop
        echo "htop installed"
    else
        echo "failed to install htop"
    end
end

function _install_starship -d "install starship prompt"

    echo "installing starship prompt"
    if command sudo snap install starship
        echo "starship installed"
    else
        "failed to install starship"
    end
end

function _starship_config -d "downloads starship config"
    set -l url "https://gist.githubusercontent.com/g5becks/27e40cf371c2e0afd859873a59632ff2/raw/15f128154ef5059bec5fdd47e5ff9632f673b9b5/starship.toml"
    echo "downloading starship config"

    set -l dl_file ~/.config/starship.toml
    if not test -e $dl_file
        command touch $dl_file
    end
    if command sudo wget -O $dl_file $url
        echo "starship config downloaded successfully"
    else
        echo "failed to download starship config"
    end
end

function _install_digital_ocean_cli -d "installs digital ocean cli"
    echo "installing digital ocean cli"
    if command sudo snap install doctl
        echo "digital ocean cli installed successfully"
    else
        echo "failed to install digital ocean cli"
    end
end

function _install_lsd -d "installs lsd"
    echo "installind lsd"
    if command sudo snap install lsd --classic
        echo "lsd installd successfully"
    else
        echo "failed to install lsd"
    end
end

function _remove_cmdtest -d "uninstalls cmdtest which interferes with yarn"
    echo "removing cmdtest"
    if command sudo apt remove cmdtest
        echo "cmdtest removed"
    else
        echo "failed to remove cmdtest"
    end
end

function _use_lts_node -d "get latest lts node"
    echo "getting latest lts node"
    if command nvm use lts
        echo "node lts installed"
    else
        echo "failed to get node"
    end
end

function _install_yarn -d "installs yarn"
    echo "installing yarn"
    if command npm install -g yarn
        echo "yarn installed"
    else
        echo "failed to install yarn"
    end
end

function _install_neovim -d "installs neovim"
    echo "installing neovim"
    if command sudo snap install --beta nvim --classic
        echo "neovim install successfully"
    else
        echo "failed to install neovim"
    end
end

function _install_insomnia -d "installs insomnia"
    echo "installing insomnia"
    if command sudo snap install insomnia
        echo "insomnia installed successfully"
    else
        "echo failed to install insomnia"
    end
end

function _install_insomnia_designer -d "installs insomnia_designer"
    echo "installing insomnia_designer"
    if command sudo snap install insomnia-designer
        echo "insomnia-designer installed successfully"
    else
        echo "failed to install insomnia-designer"
    end
end


function _install_gnome_tweaks -d "installs gnome tweaks tool"
    echo "adding universe repo"
    if command sudo add-apt-repository universe
        echo "universe repo added"
    else
        echo "failed to add universe repo"
    end
    echo "installing gnome tweaks tool"
    if command sudo apt install -y gnome-tweak-tool
        echo "gnome tweaks installed"
    else
        "failed to install gnome tweaks"
    end
end

function _install_webstorm -d "installs webstorm"
    echo "installing webstorm"
    if command sudo snap install webstorm --classic
        echo "webstorm installed successfully"
    else
        echo "failed to install webstorm"
    end
end

function install_pip3 -d "installs pip3"
    echo "installs pip3"
    if command sudo apt install -y python3-pip
        echo "installing pip"
    else
        echo "failed to install pip"
    end
end

function _install_httpie -d "installs httpie"
    echo "installing httpie"
    if command sudo snap install http
        echo "httpie installed successfully"
    else
        echo "failed to install httpie"
    end
end

function _install_http_prompt -d "installs http_prompt"
    echo "installing http_prompt"
    if command pip install --user http-prompt
        echo "http-prompt installed successfully"
    else
        echo "failed to install http_prompt"
    end
end

function _install_chrome_gnome_shell -d "installs chrome-gnome-shell"
    echo "installing chrome-gnome-shell"
    if command sudo apt install -y chrome-gnome-shell
        echo "chrome-gnome-shell installed successfully"
    else
        echo "chrome-gnome-shell installation failed"
    end
end

function _install_x11_utils -d "installs x11 utils"
    echo "installing x11 utils"
    if command sudo apt install -y x11-utils
        echo "x11 utils installed successfully"
    else
        echo "failed to install x11 utils"
    end
end


function _install_firefox_developer_edition -d "installs firefox dev ed"
    echo "installing FirefoxDevEdition"
    if command curl -L http://git.io/firefoxdev | sh
        echo "firefox-dev-edition installed successfully"
    else
        echo "failed to install firefox-dev-edition"
    end
end

function _install_open_jdk -d "installs open-jdk"
    echo "installing open-jdk"
    if command sudo apt-get install -y openjdk-8-jre
        echo "open-jdk installed successfully"
    else
        echo "failed to install open-jdk"
    end
end

function _install_ffmpeg -d "installs ffmpeg"
    echo "installing ffmpeg"
    command sudo flatpak install flathub org.freedesktop.Platform.ffmpeg
end

function _get_wallpapers -d "downloads my wallpapers"
    set -l papers https://lh3.googleusercontent.com/pw/ACtC-3eNHcc4m04rslLketkSJUMbHtHZtGEMvX3Ejod7oavpdzQ34_CFkaDS2wYBHXsO-B5x19J1SWd348vA5AIf52KDj1XChl4GdlYCapr0WCsujPIK9TgnSoxLexmcYMoBoTA81yNB7EZjCK2yQOii8f1Z=w1200-h675-no https://lh3.googleusercontent.com/pw/ACtC-3f7Qwpapbc3krCGTxstXURvQoAGXyU7OMECuyc1wQ-7Wbp1VImMsRCQWtWPJw0dge6bjp-IUwnwagUPU01Iupsb61vQ997s5OmkqPRYhPTzb4Zla8Lr4yLzbrLfpwx2uzXKrShZilcUqcRDM3aElhQg=w1200-h675-no
    set -l count 1
    for i in (seq 1 2)
        command touch ~/Pictures/wallpaper$i.jpg
    end
    echo "downloading wallpapers"
    for paper in $papers
        command wget -O ~/Pictures/wallpaper$count.jpg $paper
    end
end

function _upgrade -d "upgrades the system"
    echo "upgrading packages"
    if command sudo apt upgrade
        echo "upgrade complete"
    else
        echo "upgrade failed"
    end
end

function _cleanup -d "cleans uneeded files"
    echo "cleaning up"
    if command sudo apt autoremove
        echo "finished cleaning up"
    else
        echo "cleanup failed"
    end
end

function setup -d "installs all apps and tools on a new machine"
    _install_fisher
    _install_plugins
    _install_fonts
    _install_kitty
    _install_snapd
    _install_androidstudio
    _install_remmina
    _install_docker
    _install_zeal
    _install_htop
    _install_starship
    _starship_config
    _install_digital_ocean_cli
    _install_couch_db
    _install_neovim
    _install_lsd
    _install_jq
    _remove_cmdtest
    _use_lts_node
    _install_yarn
    _install_task
    _install_rust
    _install_insomnia
    _install_insomnia_designer
    _install_webstorm
    _install_httpie
    _install_pip3
    _install_http_prompt
    _install_open_jdk
    _install_firefox_developer_edition
    _install_ffmpeg
    _install_gnome_tweaks
    _install_chrome_gnome_shell
    _install_x11_utils
    _fish_config
    _get_wallpapers
    _create_dev_folder
    _upgrade
    _cleanup
end