
function targz
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	set size $(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		set cmd (zopfli)
	else
		if hash pigz 2> /dev/null; then
			set cmd (pigz);
		else
			set cmd (gzip);
    end;
  end;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"$cmd" -v "$tmpFile" || return 1;
	[ -f "$tmpFile" ] && rm "$tmpFile";

	set zippedSize $(
		stat -f"%z" "$tmpFile.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "$tmpFile.gz" 2> /dev/null; # GNU `stat`
	);

	echo "$tmpFile.gz ($((zippedSize / 1000)) kB) created successfully.";
end
