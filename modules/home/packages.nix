{ inputs, pkgs, ... }: 
let 
  _2048 = pkgs.callPackage ../../pkgs/2048/default.nix {}; 
in
{
  home.packages = (with pkgs; [
    _2048

    ## CLI utility
    ani-cli
    binsider
    bitwise                           # cli tool for bit / hex manipulation
    brillo
    caligula                          # User-friendly, lightweight TUI for disk imaging
    dconf-editor
    docfd                             # TUI multiline fuzzy document finder
    eza                               # ls replacement
    entr                              # perform action when file change
    fd                                # find replacement
    ffmpeg
    file                              # Show file information 
    gtt                               # google translate TUI
    gifsicle                          # gif utility
    gtrash                            # rm replacement, put deleted files in system trash
    hexdump
    imv                               # image viewer
    jq                                # JSON processor
    killall
    lazygit
    libnotify
    pkg-config
    wlsunset
	  man-pages					            	  # extra man pages
    mimeo
    mpv                               # video player
    ncdu                              # disk space
    nitch                             # systhem fetch util
    openssl
    onefetch                          # fetch utility for git repo
    pamixer                           # pulseaudio command line mixer
    playerctl                         # controller for media players
    poweralertd
    programmer-calculator
    ripgrep                           # grep replacement
    swappy                            # snapshot editing tool
    tdf                               # cli pdf viewer
    tldr
    todo                              # cli todo list
    toipe                             # typing test in the terminal
    ttyper                            # cli typing test
    unzip
    valgrind                          # c memory analyzer
    
    
    wget
    yazi                              # terminal file manager
    yt-dlp-light
    xdg-utils
    xxd

    ## CLI 
    cbonsai                           # terminal screensaver
    cmatrix
    pipes                             # terminal screensaver
    sl
    tty-clock                         # cli clock

    ## GUI Apps
    audacity
    bleachbit                         # cache cleaner
    gimp
 
    libreoffice
    nix-prefetch-github
    obs-studio
    pavucontrol                       # pulseaudio volume controle (GUI)
    pitivi                            # video editing
    qalculate-gtk                     # calculator
    vlc
    winetricks
    wineWowPackages.wayland
    zenity
    
    blockbench
    inputs.pollymc.packages.${pkgs.system}.pollymc
    
    #coding
    code-cursor
    jetbrains.idea-community-bin
    jdk21
    go
    rustc
    cargo
    rustfmt
    rust-analyzer
    
    ffmpeg
    obsidian
    gnome-clocks

    # C / C++
    gcc
    gdb
    gnumake
    cmake

    # Python
    python3
    python312Packages.ipython
    python312Packages.opencv4
    python312Packages.pygit2
    
    zlib
    rocmPackages.rocm-smi
    
    
    clinfo
    
    libdrm
    
    
    stdenv.cc.cc.lib
    

    inputs.alejandra.defaultPackage.${system}
  ]);
  home.sessionVariables = {
    OPENSSL_DIR = "${pkgs.openssl.dev}";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:/run/current-system/sw/lib";
    LIBDRM_PATH = "/etc/libdrm";
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };
}
