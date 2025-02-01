{ pkgs, ... }: 
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
   #hardware.pulseaudio = {
    ##enable = true;
    #daemon.config = {
     # flat-volumes = "no";
     # enable-deferred-volume = "yes";
    #};
    # Disable echo cancellation if needed
    # extraModules = [ ];
  #};
}
