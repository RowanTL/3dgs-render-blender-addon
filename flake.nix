{
  description = "A development shell for the 3dgs-render-blender-addon";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python313
          pkgs.uv
          pkgs.ruff
          pkgs.ty
          pkgs.libx11
        ];
      };
      shellHook = ''
        export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ pkgs.libx11 ]}:$LD_LIBRARY_PATH;
        echo "hi"
      '';
    };
}
