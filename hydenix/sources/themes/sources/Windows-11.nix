{ pkgs }:
let
  utils = import ../utils { inherit pkgs; };
in
utils.mkTheme rec {
  name = "Windows 11";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "hyde-gallery";
    rev = "Windows-11";
    name = name;
    sha256 = "sha256-jgFrtIOOX47jPN4qgXAkHOjxFQGK3zep5MszEzG3ydg=";
      
  };

  meta = {
    description = "HyDE Theme: Windows 11";
    homepage = "https://github.com/HyDE-Project/hyde-gallery/tree/Windows-11";
  };
}
