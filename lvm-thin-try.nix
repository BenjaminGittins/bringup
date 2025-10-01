{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "hdd_pool";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      hdd_pool = {
        type = "lvm_vg";
        lvs = {
          thin_pool = {
            size = "100%FREE";
            lvm_type = "thin-pool";
          };
          thin_pool_root = {
            size = "100G";
            lvm_type = "thinlv";
            pool = "thin_pool";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          thin_pool_home = {
            size = "10G";
            lvm_type = "thinlv";
            pool = "thin_pool";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}
