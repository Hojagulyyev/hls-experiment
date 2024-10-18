#!/bin/bash

# Input video file
input_video="input.mp4"

# Output directory for all resolutions and HLS streams
output_dir="./output"
mkdir -p $output_dir

# Set segment duration (in seconds)
segment_time=5

# Resolutions and associated bitrates
declare -A resolutions
resolutions=(
  ["144p"]="256k"
  ["240p"]="512k"
  ["480p"]="1000k"
  ["720p"]="2500k"
)

# Audio extraction (optional, if you need separate audio stream)
ffmpeg -i "$input_video" -vn -acodec aac -b:a 128k -hls_time $segment_time -hls_playlist_type vod -f hls "$output_dir/audio.m3u8"

# Create individual video streams at different resolutions
for res in "${!resolutions[@]}"; do
  bitrate=${resolutions[$res]}
  
  ffmpeg -i "$input_video" -vf "scale=-2:${res%p}" -c:v h264 -b:v "$bitrate" -hls_time $segment_time -hls_playlist_type vod -an -f hls "$output_dir/${res}.m3u8"
done

# Combine all resolutions and audio into a master playlist (index.m3u8)
master_playlist="$output_dir/index.m3u8"
echo "#EXTM3U" > $master_playlist
echo "#EXT-X-VERSION:3" >> $master_playlist

# Add video resolutions to the master playlist
for res in "${!resolutions[@]}"; do
  bitrate=${resolutions[$res]}
  resolution_height=${res%p}
  echo "#EXT-X-STREAM-INF:BANDWIDTH=$bitrate,RESOLUTION=640x$resolution_height" >> $master_playlist
  echo "${res}.m3u8" >> $master_playlist
done

# Add audio to the master playlist
echo "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID=\"audio\",NAME=\"aac\",DEFAULT=YES,AUTOSELECT=YES,URI=\"audio.m3u8\"" >> $master_playlist

echo "M3U8 generation complete!"
