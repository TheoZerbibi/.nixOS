{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ {
    home-manager,
    catppuccin,
    ...
  }: {
    nixosConfigurations = let
      hosts = {
        desktop = {
          system = "x86_64-linux";
          state = "24.11";

          users = {
            tzeribi = {
              groups = ["wheel" "docker"];
              shell = "zsh";
            };
          };
        };
      };
      f = {
        map = builtins.mapAttrs;
      };
    in
      f.map (hostname: {
        system,
        state,
        users,
      }:
        inputs.nixpkgs.lib.nixosSystem
        (let
          options = {
            inherit system;
            config.allowUnfree = true;
          };
          nixpkgs = {
            stable = import inputs.nixpkgs options;
            unstable = import inputs.nixpkgs-unstable options;
          };

          specialArgs = {inherit nixpkgs hostname system state inputs;};
        in {
          inherit system specialArgs;

          modules = [
            ./configuration.nix
            ./hosts/${hostname}.nix
            catppuccin.nixosModules.catppuccin
            {
              system.stateVersion = state;
              programs.zsh.enable = true;
              users.defaultUserShell = nixpkgs.stable.zsh;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;

              home-manager.users =
                f.map (username: {...}: {
                  home = {
                    inherit username;
                    homeDirectory = "/home/${username}";
                    stateVersion = state;
                  };

                  imports = [
                    ./users/${username}.nix
                    catppuccin.homeManagerModules.catppuccin
                  ];
                })
                users;

              users.users =
                f.map (username: {
                  groups,
                  shell,
                }: {
                  isNormalUser = true;
                  extraGroups = groups;
                  shell = nixpkgs.stable.${shell};
                })
                users;
            }
          ];
        }))
      hosts;
  };
}