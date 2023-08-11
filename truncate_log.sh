log_dir="/path/to/logs" # replace to actual path
largest_file=""
largest_size=0
for file in $(find "$log_dir" -type f -name "*.log"); do
    size=$(wc -l < "$file")
    if ((size > largest_size)); then
        largest_size=$size
        largest_file=$file
    fi
done

if [ -n "$largest_file" ]; then
    # Truncate the largest log file to 100 lines
    tail -n 100 "$largest_file" > "$largest_file.tmp"
    mv "$largest_file.tmp" "$largest_file"
    echo "Truncated $largest_file to 100 lines."
else
    echo "No log files found."
fi
