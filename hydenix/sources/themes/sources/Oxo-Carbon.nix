{ pkgs }:
let
  utils = import ../utils { inherit pkgs; };
in
utils.mkTheme rec {
  name = "Oxo Carbon";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Oxo-Carbon";
    rev = "Oxo-Carbon";
    name = name;
    sha256 = "sha256-nftD2fu00xs0S7JKaoOoZGcgQINKbLHVwfkXV06L46Y=";
  };
  meta = {
    description = "HyDE Theme: Oxo Carbon";
    homepage = "https://github.com/rishav12s/Oxo-Carbon";
  };
}
