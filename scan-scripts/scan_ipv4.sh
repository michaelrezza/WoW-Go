#!/bin/bash
input_file=$1
output_file=$2

# Temporary files to store ping and speed results
temp_ping_file="ping_results.txt"
temp_speed_file="speed_results.txt"

# Checking ping and speed
while read -r ip; do
  # Checking ping
  ping -c 3 -W 1 $ip &> /dev/null
  ping_result=$?
  
  if [ $ping_result -eq 0 ]; then
    # Measure download speed using wget (download a sample file)
    speed=$(wget -qO- http://speedtest.tele2.net/1MB.zip --timeout=10 --tries=2 | wc -c)
    
    if [ ! -z "$speed" ]; then
      # Store the results for ping and speed
      echo "$ip | $speed | $(ping -c 3 $ip | tail -n 1 | awk '{print $4}' | cut -d'/' -f2)" >> $temp_ping_file
    fi
  fi
done < "$input_file"

# Select the best IP with the lowest ping and highest speed
best_ip=$(sort -t "|" -k2 -n $temp_ping_file | head -n 1 | cut -d "|" -f1)
echo "$best_ip" > "$output_file"

# Remove temporary files
rm $temp_ping_file