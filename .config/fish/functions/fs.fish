
function fs
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
  end
	if [[ -n "$argv" ]]; then
		du $arg -- "$argv";
	else
		du $arg .[^.]* ./*;
  end
end
