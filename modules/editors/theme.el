(require 'base16-theme)

(defvar base16-stylix-theme-colors
  '(:base00 "181b23"
    :base01 "2a2f3a"
    :base02 "3c3836"
    :base03 "665c54"
    :base04 "d3c8ba"
    :base05 "eae3d9"
    :base06 "f3eee5"
    :base07 "f3eee5"
    :base08 "d36c6c"
    :base09 "e7a953"
    :base0A "f6c982"
    :base0B "a8c074"
    :base0C "78b6bc"
    :base0D "4d8dc4"
    :base0E "b18bbb"
    :base0F "d65d0e")
  "All colors for Base16 stylix are defined here.")

;; Define the theme
(deftheme base16-stylix)

;; Add all the faces to the theme
(base16-theme-define 'base16-stylix base16-stylix-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-stylix)

;; Add path to theme to theme-path
(add-to-list 'custom-theme-load-path
    (file-name-directory
        (file-truename load-file-name)))

(provide 'base16-stylix-theme)
