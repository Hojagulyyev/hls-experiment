#!/bin/bash

videos_dir="twitch"

mkdir $videos_dir

ffmpeg -i input.mp4 \
    -vf "scale=w=256:h=144" -c:v:0 libx264 -b:v:0 504k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/144p_%03d.ts" -hls_playlist_type vod "$videos_dir/144p.m3u8" \
    -vf "scale=w=426:h=240" -c:v:1 libx264 -b:v:1 840k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/240p_%03d.ts" -hls_playlist_type vod "$videos_dir/240p.m3u8" \
    -vf "scale=w=854:h=480" -c:v:2 libx264 -b:v:2 1680k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/480p_%03d.ts" -hls_playlist_type vod "$videos_dir/480p.m3u8" \
    -vf "scale=w=1280:h=720" -c:v:3 libx264 -b:v:3 2520k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/720p_%03d.ts" -hls_playlist_type vod "$videos_dir/720p.m3u8"


touch $videos_dir/index.m3u8

echo "#EXTM3U" > $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=500000,RESOLUTION=256x144" >> $videos_dir/index.m3u8
echo "144p.m3u8" >> $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=426x240" >> $videos_dir/index.m3u8
echo "240p.m3u8" >> $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=1200000,RESOLUTION=854x480" >> $videos_dir/index.m3u8
echo "480p.m3u8" >> $videos_dir/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=2500000,RESOLUTION=1280x720" >> $videos_dir/index.m3u8
echo "720p.m3u8" >> $videos_dir/index.m3u8
