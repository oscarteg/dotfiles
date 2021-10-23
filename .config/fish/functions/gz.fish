# Compare original and gzipped file size
function gz
	set -l origsize (wc -c < "$1");
	set -l gzipsize (gzip -c "$1" | wc -c);
	set -l ratio (echo "$gzipsize * 100 / $origsize" | bc -l);
	printf "orig: %d bytes\n" "$origsize";
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
end
