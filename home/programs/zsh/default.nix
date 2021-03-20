{ config, pkgs, lib, ... }:
{
programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
        gs = "git status";
        vi = "nvim";
        vim = "nvim";
        ssh="TERM=xterm-256color ssh";
        please="fuck";

    };
    history = {
        expireDuplicatesFirst = true;
        save = 100000000;
        size = 1000000000;
        path = ".zsh_history";
    };

    oh-my-zsh = {
        enable = true;

        plugins = [
          "command-not-found"
          "git"
          "history"
          "sudo"
        ];
    };

    initExtra = ''
      eval $(starship init zsh)
      eval $(thefuck --alias)
      autopair-init
                              '';

    plugins = with pkgs; [
      {
        name = "formarks";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "formarks";
          rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
          sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
        };
        file = "formarks.plugin.zsh";
      }
      {
        name = "zsh-z";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "595c883abec4682929ffe05eb2d088dd18e97557";
          sha256 = "0kf78p1k8d6kzcqjcxn1nfki6p76kqiv4zlc89zzhsphmid18z0y";
        };
        file = "zsh-z.plugin.zsh";
      }
      {
        name = "zsh-async";
        file = "async.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/mafredri/zsh-async";
          rev = "bbbc92bd01592513a6b7739a45b7911af18acaef";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-abbrev-alias";
        src = fetchFromGitHub {
          owner = "momo-lab";
          repo = "zsh-abbrev-alias";
          rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
          sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
        };
        file = "abbrev-alias.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.1.0";
          sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
       };
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true; };
    
  home.packages = [
      pkgs.starship
      pkgs.thefuck
      pkgs.bottom
  ];
}
