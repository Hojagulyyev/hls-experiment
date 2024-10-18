#!/bin/bash

FV="v1"

mkdir $FV

ffmpeg -i input.mp4 \
    -vf scale=w=1280:h=720 -c:v h264 -b:v 2000k -maxrate 2000k -bufsize 4000k -c:a aac -ar 48000 -b:a 128k \
        -hls_time 4 -hls_playlist_type vod -f hls $FV/720p.m3u8 \
    -vf scale=w=854:h=480  -c:v h264 -b:v 1000k -maxrate 1000k -bufsize 2000k -c:a aac -ar 48000 -b:a 96k \
        -hls_time 4 -hls_playlist_type vod -f hls $FV/480p.m3u8 \
    -vf scale=w=426:h=240  -c:v h264 -b:v 500k  -maxrate 500k  -bufsize 1000k -c:a aac -ar 48000 -b:a 64k \
        -hls_time 4 -hls_playlist_type vod -f hls $FV/240p.m3u8

touch $FV/index.m3u8
echo "#EXTM3U" > $FV/index.m3u8
echo "#EXT-X-STREAM-INF:BANDWIDTH=500000,RESOLUTION=426x240" >> $FV/index.m3u8
echo "240p.m3u8" >> $FV/index.m3u8
echo "#EXT-X-STREAM-INF:BANDWIDTH=2000000,RESOLUTION=1280x720" >> $FV/index.m3u8
echo "720p.m3u8" >> $FV/index.m3u8
echo "#EXT-X-STREAM-INF:BANDWIDTH=1000000,RESOLUTION=854x480" >> $FV/index.m3u8
echo "480p.m3u8" >> $FV/index.m3u8
