function gi
  set result (curl "https://www.toptal.com/developers/gitignore/api/$argv[1]" 2>/dev/null)

  if [[ $result =~ ERROR ]]; then
    echo "Query '$1' has no match. See a list of possible queries with 'gi list'"
  elif [[ $1 = list ]]; then
    echo "$result"
  else
    if [[ -f .gitignore ]]; then
      result=`echo "$result" | grep -v "# Created by http://www.gitignore.io"`
      echo ".gitignore already exists, appending"
      echo "$result" >> .gitignore
    else
      echo "$result" > .gitignore
    end
  end
end
