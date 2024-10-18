#!/bin/bash

FV="videos-v3.2"

mkdir $FV

ffmpeg -i input.mp4 \
    -vf "scale=w=256:h=144" -c:v:0 libx264 -b:v 100k -maxrate 120k -bufsize 200k -g 48 -keyint_min 48 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/144p_%03d.ts" -hls_playlist_type vod -an $FV/144p.m3u8 \
    -vf "scale=w=426:h=240" -c:v:1 libx264 -b:v 400k -maxrate 450k -bufsize 600k -g 48 -keyint_min 48 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/240p_%03d.ts" -hls_playlist_type vod -an $FV/240p.m3u8 \
    -vf "scale=w=854:h=480" -c:v:2 libx264 -b:v 1500k -maxrate 1600k -bufsize 2400k -g 48 -keyint_min 48 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/480p_%03d.ts" -hls_playlist_type vod -an $FV/480p.m3u8 \
    -vf "scale=w=1280:h=720" -c:v:3 libx264 -b:v 3000k -maxrate 3500k -bufsize 5000k -g 48 -keyint_min 48 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/720p_%03d.ts" -hls_playlist_type vod -an $FV/720p.m3u8 \
    -map a:0 -c:a aac -b:a 128k -f hls -hls_time 5 -hls_segment_filename "$FV/audio_%03d.aac" "$FV/audio.m3u8"


# Create master video

touch $FV/index.m3u8

echo "#EXTM3U" > $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=500000,RESOLUTION=256x144,AUDIO="audio"" >> $FV/index.m3u8
echo "144p.m3u8" >> $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=426x240,AUDIO="audio"" >> $FV/index.m3u8
echo "240p.m3u8" >> $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=1200000,RESOLUTION=854x480,AUDIO="audio"" >> $FV/index.m3u8
echo "480p.m3u8" >> $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=2500000,RESOLUTION=1280x720,AUDIO="audio"" >> $FV/index.m3u8
echo "720p.m3u8" >> $FV/index.m3u8

echo "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",NAME="AAC Audio",DEFAULT=YES,AUTOSELECT=YES,URI="audio.m3u8"" >> $FV/index.m3u8
