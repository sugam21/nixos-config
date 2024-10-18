{
	description = "My flake config!";
	inputs = { 
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; 
		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs"; 
		};
		xremap-flake.url = "github:xremap/nix-flake";
	};
	outputs = { self, nixpkgs, home-manager, ... }@inputs:
		let
		system = "x86_64-linux";
	pkgs =	nixpkgs.legacyPackages.${system};
	in
	{ 
		nixosConfigurations.sugamsnixos= nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {inherit inputs; };
			modules = [ ./configuration.nix ]; 
		};
		homeConfigurations.sugam = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			modules = [./home.nix];
		};
	};
}
