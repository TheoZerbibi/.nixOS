{
  description = "NixOS config with Hyprland + Home Manager + a 'root' user named theo";

  inputs = {
    # Nixpkgs unstable (pour avoir la version la plus récente)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      # On suit la même révision de nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland officiel
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, ... }:
    let
      # Architecture de la machine
      system = "x86_64-linux";
    in
    {
      # Notre configuration NixOS s’appelle "nixos"
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        # On importe configuration.nix (et indirectement les autres)
        modules = [
          ./configuration.nix
        ];

        # Pour permettre d'accéder à `inputs` depuis configuration.nix
        specialArgs = {
          inherit inputs;
        };
      };
    };
}
