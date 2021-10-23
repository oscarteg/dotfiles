# Normalize `open` across Linux, macOS, and Windows.
# This is needed to make the `o` function (see below) cross-platform.
if [ ! (uname -s) = 'Darwin' ]
	if grep -q Microsoft /proc/version
		# Ubuntu on Windows using the Linux subsystem
		alias open='explorer.exe'
	else
		alias open='xdg-open'
  end
end

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o
	if [ (count $argv) -eq 0 ]
		open .
	else
		open "$argv"
  end;
end
