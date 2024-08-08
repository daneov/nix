{
  description = "Daneo's darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [ 
        ripgrep
	silver-searcher
        neovim
        podman
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.bash-prompt-prefix = "(nix:$name)\040";
      nix.settings.extra-nix-path = "nixpkgs=flake:nixpkgs";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # Configure machine defaults
      system.defaults = {
        NSGlobalDomain = {
          AppleEnableSwipeNavigateWithScrolls = true;
          AppleInterfaceStyle = "Dark";
          AppleInterfaceStyleSwitchesAutomatically = false;
          AppleScrollerPagingBehavior = true;
          AppleShowAllExtensions = true;
          AppleShowScrollBars = "WhenScrolling";
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSDocumentSaveNewDocumentsToCloud = false;
          NSWindowShouldDragOnGesture = true;
          "com.apple.swipescrolldirection" = true;
          "com.apple.trackpad.forceClick" = true;
        };
        alf = {
          globalstate = 1; # Firewall enabled
          stealthenabled = 1; # Drop ping requests
        };
        dock = {
          minimize-to-application = true;
          show-recents = false;
          wvous-tr-corner = 13; # Lock screen when going to top right corner
        };
        finder = {
          AppleShowAllFiles = true;
          ShowPathbar = true;
          ShowStatusBar = true;
        };
        loginwindow = {
          GuestEnabled = false;
          PowerOffDisabledWhileLoggedIn = true;
          ShutDownDisabledWhileLoggedIn = true;
          RestartDisabledWhileLoggedIn = true;
        };
        screencapture.type = "png";
        spaces.spans-displays = true;
        trackpad.Clicking = true;
        trackpad.Dragging = true;
      };
      system.startup.chime = false;
      fonts.packages = with pkgs; [
        fira-code
        fira-code-symbols
      ];

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Daneos-MacBook-Pro
    darwinConfigurations."Daneos-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Daneos-MacBook-Pro".pkgs;
  };
}
