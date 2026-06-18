{
  description = "A development shell for the 3dgs-render-blender-addon";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python313
          pkgs.uv
          pkgs.ruff
          pkgs.ty
          pkgs.vscode
        ];
        shellHook =
        let
          ldLibraryPath = pkgs.lib.makeLibraryPath (with pkgs; [
            libx11
            libxrender
            libxfixes
            libxi
            libxkbcommon
            stdenv.cc.cc.lib
            libsm
            libice
            libGL
            libz
          ]);
        in
        ''
          export LD_LIBRARY_PATH=${ldLibraryPath}:$LD_LIBRARY_PATH;
        '';
      };
    };
}
