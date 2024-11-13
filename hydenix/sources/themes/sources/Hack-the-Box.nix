{ pkgs }:
let
  utils = import ../utils { inherit pkgs; };
in
utils.mkTheme rec {
  name = "Hack the Box";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "Hack-the-Box";
    name = name;
    sha256 = "sha256-KgRkKFEGukj8dPXDxN1JvLLZxDfmvePmm2Tx9xZq284=";
  };

  meta = {
    description = "HyDE Theme: Hack the Box";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Hack-the-Box";
  };
}
