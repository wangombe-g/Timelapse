#!/bin/bash

# Check if the required arguments were provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <duration in hours> <interval in seconds>"
  echo "Example: $0 1.5 30"
  exit 1
fi

# Capture input duration in hours and convert it to seconds
DURATION_HOURS=$1
INTERVAL=$2
DURATION_SECONDS=$(echo "$DURATION_HOURS * 3600" | bc)

SAVE_PATH="/home/eugene/Pictures/Timelapse/timelapse" # Update this path where you want to save the images
TMP_PATH="/mnt/timelapse"  # Temporary storage in RAM

# Calculate the number of captures based on duration and interval
NUM_CAPTURES=$(echo "$DURATION_SECONDS / $INTERVAL" | bc)

TIMELAPSE_DURATION=$(echo "$NUM_CAPTURES / 30" | bc)

echo "Capturing $NUM_CAPTURES images over $DURATION_HOURS hours with $INTERVAL seconds interval"
echo "Timelapsed video duration will be $TIMELAPSE_DURATION seconds."

# Start capturing images
for ((i=0; i<NUM_CAPTURES; i++)); do
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  FINAL_FILENAME="$SAVE_PATH/image_$TIMESTAMP.jpeg"

  streamer -o $TMP_PATH/tmp_image_0.jpeg -c /dev/video4 -s 1920x1080 -j 100 -t 5 -r 1 -q

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