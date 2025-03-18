{ ... }:
let
  wgIface = "kay";
  endpoint = "137.59.84.126:51820";
  privateKeyFile = "/var/secrets/wg_sinanmohd";
in
{
  networking.wg-quick.interfaces.${wgIface} = {
    autostart = true;
    address = [ "10.0.1.6/24" ];
    dns = [ "10.0.1.1" ];
    mtu = 1412;
    inherit privateKeyFile;

    peers = [
      {
        publicKey = "wJMyQDXmZO4MjYRk6NK4+J6ZKWLTTZygAH+OwbPjOiw=";
        allowedIPs = [ "10.0.1.0/24" ];
        inherit endpoint;
        persistentKeepalive = 25;
      }
    ];
  };
}
