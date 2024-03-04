#!/bin/bash

# Define variables

if [ $# -eq 0 ]; then
  echo "Please specify the duration in hours as a float."
  exit 1
fi

# Capture input duration in hours and convert it to seconds
DURATION_HOURS=$1
DURATION_SECONDS=$(echo "$DURATION_HOURS * 3600" | bc)

SAVE_PATH="/home/eugene/Pictures/Timelapse/timelapse" # Update this path where you want to save the images
TMP_PATH="/mnt/mytmpfs"  # Temporary storage in RAM
INTERVAL=20 # Capture interval in seconds

# Calculate the number of captures based on duration and interval
NUM_CAPTURES=$(echo "$DURATION_SECONDS / $INTERVAL" | bc)

# Create a temporary directory for capturing images
mkdir -p "$TMP_PATH"

# Start capturing images
for ((i=0; i<NUM_CAPTURES; i++)); do
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  FINAL_FILENAME="$SAVE_PATH/image_$TIMESTAMP.jpeg"

  streamer -o $TMP_PATH/tmp_image_0.jpeg -c /dev/video4 -s 1920x1080 -j 100 -t 5 -r 1

	# Copy the last image to the final location
  cp "$TMP_PATH/tmp_image_4.jpeg" "$FINAL_FILENAME"
  echo "Captured $FINAL_FILENAME"
	DURATION_HOURS=$1
  sleep $INTERVAL
done

ffmpeg -y -f image2 -pattern_type glob -framerate 30 \
       -i "$SAVE_PATH\*.jpg" \
       -pix_fmt yuv420p -b 1500k timelapse.mp4
rm "$SAVE_PATH/*\.jpeg"

echo "Timelapse capture complete."