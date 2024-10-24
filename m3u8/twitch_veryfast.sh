#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_file.mp4 output_folder"
    return
fi

input_file="$1"

# Create directory for videos
videos_dir="$2"
mkdir $videos_dir

# Convert the input video to m3u8 format
ffmpeg -i $input_file \
    -vf "scale=w=256:h=144" -c:v:0 libx264 -preset veryfast -crf 23 -b:v:0 504k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/144p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/144p.m3u8" \
    -vf "scale=w=426:h=240" -c:v:1 libx264 -preset veryfast -crf 23 -b:v:1 840k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/240p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/240p.m3u8" \
    -vf "scale=w=854:h=480" -c:v:2 libx264 -preset veryfast -crf 23 -b:v:2 1680k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/480p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/480p.m3u8" \
    -vf "scale=w=1280:h=720" -c:v:3 libx264 -preset veryfast -crf 23 -b:v:3 2520k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/720p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/720p.m3u8" \
    -map a:0 -c:a aac -b:a 128k -f hls -hls_time 5 \
        -hls_segment_filename "$videos_dir/audio_%03d.aac" -hls_playlist_type vod "$videos_dir/audio.m3u8"

# Create master m3u8 and group chunks.
touch $videos_dir/index.m3u8

echo "#EXTM3U" > $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=500000,RESOLUTION=256x144,AUDIO=\"audio\"" >> $videos_dir/index.m3u8
echo "144p.m3u8" >> $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=426x240,AUDIO=\"audio\"" >> $videos_dir/index.m3u8
echo "240p.m3u8" >> $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=1200000,RESOLUTION=854x480,AUDIO=\"audio\"" >> $videos_dir/index.m3u8
echo "480p.m3u8" >> $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=2500000,RESOLUTION=1280x720,AUDIO=\"audio\"" >> $videos_dir/index.m3u8
echo "720p.m3u8" >> $videos_dir/index.m3u8

echo "# Audio Group" >> $videos_dir/index.m3u8
echo "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",NAME="AAC Audio",DEFAULT=YES,AUTOSELECT=YES,URI=\"audio.m3u8\"" >> $videos_dir/index.m3u8
