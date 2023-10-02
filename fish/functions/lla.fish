function lla --wraps='ls -la' --wraps='exa_git $EXA_LA_OPTIONS' --description 'alias lla exa_git $EXA_LA_OPTIONS'
  exa_git $EXA_LA_OPTIONS $argv
        
end
