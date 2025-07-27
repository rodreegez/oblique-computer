#!/bin/bash

content_dir="content"
build_dir="build"

if [[ ! -d "$build_dir" ]]; then
  mkdir "$build_dir"
fi

# Copy CSS file to build directory
cp styles.css "$build_dir/"

# Function to convert markdown to HTML using only POSIX tools
convert_markdown_to_html() {
  local input="$1"
  echo "$input" | sed '
    # Convert headers (must come before paragraph processing)
    s/^### \(.*\)/<h3>\1<\/h3>/
    s/^## \(.*\)/<h2>\1<\/h2>/
    s/^# \(.*\)/<h1>\1<\/h1>/
    
    # Convert bold text
    s/\*\*\([^*]*\)\*\*/<strong>\1<\/strong>/g
    
    # Convert italic text (but not already bold)
    s/\([^*]\)\*\([^*][^*]*\)\*\([^*]\)/\1<em>\2<\/em>\3/g
    s/^\*\([^*][^*]*\)\*\([^*]\)/<em>\1<\/em>\2/
    s/\([^*]\)\*\([^*][^*]*\)\*$/<em>\1<\/em>/
    
    # Convert inline code
    s/`\([^`]*\)`/<code>\1<\/code>/g
    
    # Convert links [text](url)
    s/\[\([^]]*\)\](\([^)]*\))/<a href="\2">\1<\/a>/g
  ' | awk '
    BEGIN { in_paragraph = 0 }
    
    # Empty line - close paragraph if open
    /^$/ {
      if (in_paragraph) {
        print "</p>"
        in_paragraph = 0
      }
      print ""
      next
    }
    
    # Header tags - close paragraph if open, print header
    /^<h[1-6]>/ {
      if (in_paragraph) {
        print "</p>"
        in_paragraph = 0
      }
      print $0
      next
    }
    
    # Regular content line
    {
      if (!in_paragraph) {
        printf "<p>"
        in_paragraph = 1
      }
      print $0
    }
    
    # Close final paragraph if open
    END {
      if (in_paragraph) {
        print "</p>"
      }
    }
  '
}

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
  
  # Get file extension
  extension="${file##*.}"
  
  if [[ "$extension" == "md" ]]; then
    # Convert markdown to HTML
    content=$(convert_markdown_to_html "$(cat "$file")")
  else
    # Assume HTML and read as-is
    content=$(cat "$file")
  fi

  if [[ "$pagename" != "index" ]]; then
    back_link="<p><a href='./'>Back</a></p>"
  else
    back_link=""
  fi

  # Determine CSS path based on page location
  if [[ "$file" == "$content_dir/index.html" ]]; then
    css_path="./styles.css"
  else
    css_path="../styles.css"
  fi

  html_boilerplate="<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
  <title>$pagename</title>
  <link rel=\"stylesheet\" href=\"$css_path\">
</head>
<body>
  $content
  $back_link
</body>
</html>"
  echo "$html_boilerplate" > "$output_path/$pagename.html"
done

echo "fin."
