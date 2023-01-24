# This is equivalent to entering the following function:
function l --wraps exa --description 'alias l=exa -la'
    exa -la $argv
end
