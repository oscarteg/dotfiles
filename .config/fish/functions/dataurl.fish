function dataurl
	set -l mimeType $file -b --mime-type "$argv[1]"
	if [[ $mimeType == text/* ]]; then
		set mimeType "$mimeType;charset=utf-8";
  end
	echo "data:$mimeType;base64,(openssl base64 -in "$argv[1]" | tr -d '\n')";
end
