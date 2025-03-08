{...}:

{
  nix = {
    settings = {
      substituters = [
        "https://nixbin.sinanmohd.com/"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nixbin.sinanmohd.com:dXV3KDPVrm+cGJ2M1ZmTeQJqFGaEapqiVoWHgYDh03k="
      ];
    };
  };
}
