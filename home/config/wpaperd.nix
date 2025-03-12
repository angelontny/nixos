{ ... }: {
  services.wpaperd = {
    enable = true;
    settings = {
      any = {

path = "/home/angelo/dat/nature";
transition-time=700;
duration = "60s";
      };
    };
  };

}
