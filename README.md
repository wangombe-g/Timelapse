# Timelapse.sh

## Description
The `timelapse.sh` script is a utility for capturing photos and using ffmpeg to create a timelapse using a connected camera.

## Features
- Capture images at regular intervals
- Generate timelapse videos from captured images
- Customizable capture settings (interval, duration, output format, etc.)

## Prerequisites
- [FFmpeg](https://ffmpeg.org/
) installed
- [streamer](https://manpages.ubuntu.com/manpages/jammy/man1/streamer.1.html) installed

## Usage
1. Clone the repository:
	```shell
	git clone https://github.com/wangombe-g/timelapse.git
	```

2. Navigate to the project directory:
	```shell
	cd timelapse
	```

3. Run the `timelapse.sh` script:
	```shell
	./timelapse.sh
	```

4. The captured images will be stored in the `timelapse/timelapse` directory, and the timelapse video will be saved as `output/{current_data}.mp4`.

## Configuration
You can customize the following settings in the `config.sh` file:
- `INTERVAL`: Time interval between each capture (in seconds)
- `DURATION`: Total duration of the timelapse (in minutes)

## Contributing
You're welcome to suggest an area of improvement through a pull request.

## License
This project is licensed under the [MIT License](https://opensource.org/license/mit).