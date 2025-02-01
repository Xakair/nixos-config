{ config, pkgs, lib, inputs, ... }: 
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nur.overlay
      (final: prev: {
        davinci-resolve = prev.davinci-resolve.override (old: {
          buildFHSEnv = a: (old.buildFHSEnv (a // {
            extraBwrapArgs = a.extraBwrapArgs ++ [
              "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
            ];
          }));
        });
      })
    ];
  };
  programs.light.enable = true;
 


  environment.systemPackages = with pkgs; [
    wget
    git
    
    mesa
    
    wireplumber
    xwaylandvideobridge
    
    davinci-resolve
    
    docker-compose
    
    alsaLib
    openssl
    pkg-config
    
    #libpulseaudio,
    #libGL,
    #glfw,
    #openal,
    #flite,
    #mesa-demos,
    #udev,
    #libusb1,
    pavucontrol
    pulsemixer
    openal
    libpulseaudio      
  ];
  programs.nix-ld = {
  enable = true;
  libraries = with pkgs; [
    libpulseaudio
    libGL
    glfw
    # You may need to add other libraries here depending on your system
  ];
};

  services.udev.enable = true;
hardware.opengl = {
  enable = true;
  driSupport32Bit = true;
  extraPackages = with pkgs; [
     amdvlk
    vaapiVdpau
    libvdpau-va-gl
    rocmPackages.clr.icd
    libGL
    libGLU
    alsa-lib
    libjack2
    vulkan-loader
    vulkan-tools
    vaapiVdpau
  ];
  extraPackages32 = with pkgs.pkgsi686Linux; [
    libva
    vaapiVdpau
    libvdpau-va-gl
  ];
};
	
  environment.variables = {
  #LD_LIBRARY_PATH = "${pkgs.libGL}/lib:${pkgs.libGLU}/lib";
  LD_LIBRARY_PATH = "${pkgs.libGL}/lib:${pkgs.libpulseaudio}/lib:${pkgs.openal}/lib";
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  
};

# Ensure the latest AMDGPU drivers are used
hardware.enableRedistributableFirmware = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.amdgpu.opencl.enable = true;
  
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  
  system.stateVersion = "24.05";
}
