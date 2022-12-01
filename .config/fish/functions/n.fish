function n -d "Opening Neovim with current dir" 

  if not set -q argv[1]
    nvim .
  else
    nvim $argv
  end
  
end
