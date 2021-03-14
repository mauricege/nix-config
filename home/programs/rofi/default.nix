{ ... }:
{
  programs.rofi = {
    enable = true;
    theme = "slate";
    extraConfig = {
        icon-theme = "Zafiro";
        matching = "fuzzy";
        sorting-method = "fzf";
        sort = true;
        show-icons = true;
    };
  };

}