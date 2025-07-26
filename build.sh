#!/bin/bash

content_dir="content"
build_dir="build"

if [[ ! -d "$build_dir" ]]; then
  mkdir "$build_dir"
fi

# Copy CSS file to build directory
cp styles.css "$build_dir/"

find "$content_dir" -type f  | while read -r file; do
  echo "Processing $file"
  if [[ "$file" == "$content_dir/index.html" ]]; then
    output_path="$build_dir"
  else
    relative_path="${file#$content_dir/}"
    echo " relative path: $relative_path"
    output_path="${build_dir}/${relative_path%/*}"
    mkdir -p "$output_path"
  fi
  echo " output path: $output_path"

  filename="${file%.*}"
  echo " filename: $filename"
  pagename=$(basename "$filename")
  echo " pagename: $pagename"

  content=$(cat "$file")

  if [[ "$pagename" != "index" ]]; then
    back_link="<p><a href='./'>Back</a></p>"
  else
    back_link=""
  fi


  html_boilerplate="<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
  <title>$pagename</title>
  <link rel=\"stylesheet\" href=\"/styles.css\">
</head>
<body>
  $content
  $back_link
</body>
</html>"
  echo "$html_boilerplate" > "$output_path/$pagename.html"
done

echo "fin."
