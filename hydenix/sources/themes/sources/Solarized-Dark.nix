{ pkgs }:
let
  utils = import ../utils { inherit pkgs; };
in
utils.mkTheme rec {
  name = "Solarized Dark";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Solarized-Dark";
    rev = "Solarized-Dark";
    name = name;
    sha256 = "sha256-naLPzGyGK3jQSILdP5vkG2coEOqkQ4Q/dHUBJlUa2pI=";
  };

  meta = {
    description = "HyDE Theme: Solarized Dark";
    homepage = "https://github.com/rishav12s/Solarized-Dark";
  };
}
