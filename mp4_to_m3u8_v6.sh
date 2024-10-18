#!/bin/bash

FV="videos-v6.2"

mkdir $FV

ffmpeg -i input.mp4 \
    -vf "scale=w=256:h=144" -c:v:0 libx264 -b:v:0 300k -g 72 -keyint_min 72 -sc_threshold 0 -hls_time 2 -hls_segment_filename "$FV/144p_p1_%03d.ts" -t 8 -hls_playlist_type vod "$FV/144p_p1.m3u8" \
    -vf "scale=w=426:h=240" -c:v:1 libx264 -b:v:1 500k -g 72 -keyint_min 72 -sc_threshold 0 -hls_time 2 -hls_segment_filename "$FV/240p_p1_%03d.ts" -t 8 -hls_playlist_type vod "$FV/240p_p1.m3u8" \
    -vf "scale=w=854:h=480" -c:v:2 libx264 -b:v:2 700k -g 72 -keyint_min 72 -sc_threshold 0 -hls_time 2 -hls_segment_filename "$FV/480p_p1_%03d.ts" -t 8 -hls_playlist_type vod "$FV/480p_p1.m3u8" \
    -vf "scale=w=1280:h=720" -c:v:3 libx264 -b:v:3 1000k -g 72 -keyint_min 72 -sc_threshold 0 -hls_time 2 -hls_segment_filename "$FV/720p_p1_%03d.ts" -t 8 -hls_playlist_type vod "$FV/720p_p1.m3u8"

ffmpeg -i input.mp4 \
    -vf "scale=w=256:h=144" -c:v:0 libx264 -b:v:0 500k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/144p_p2_%03d.ts" -ss 8 -hls_playlist_type vod $FV/144p_p2.m3u8 \
    -vf "scale=w=426:h=240" -c:v:1 libx264 -b:v:1 800k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/240p_p2_%03d.ts" -ss 8 -hls_playlist_type vod $FV/240p_p2.m3u8 \
    -vf "scale=w=854:h=480" -c:v:2 libx264 -b:v:2 1200k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/480p_p2_%03d.ts" -ss 8 -hls_playlist_type vod $FV/480p_p2.m3u8 \
    -vf "scale=w=1280:h=720" -c:v:3 libx264 -b:v:3 2500k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$FV/720p_p2_%03d.ts" -ss 8 -hls_playlist_type vod $FV/720p_p2.m3u8

cat $FV/144p_p1.m3u8 $FV/144p_p2.m3u8 > $FV/144p.m3u8
cat $FV/240p_p1.m3u8 $FV/240p_p2.m3u8 > $FV/240p.m3u8
cat $FV/480p_p1.m3u8 $FV/480p_p2.m3u8 > $FV/480p.m3u8
cat $FV/720p_p1.m3u8 $FV/720p_p2.m3u8 > $FV/720p.m3u8

# # Remove duplicate headers from the concatenated file
sed -i '/#EXTM3U/d' $FV/144p.m3u8
sed -i '/#EXT-X-VERSION/d' $FV/144p.m3u8
sed -i '/#EXT-X-TARGETDURATION/d' $FV/144p.m3u8
sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $FV/144p.m3u8
sed -i '/#EXT-X-PLAYLIST-TYPE/d' $FV/144p.m3u8
sed -i '/#EXT-X-ENDLIST/d' $FV/144p.m3u8

sed -i '/#EXTM3U/d' $FV/240p.m3u8
sed -i '/#EXT-X-VERSION/d' $FV/240p.m3u8
sed -i '/#EXT-X-TARGETDURATION/d' $FV/240p.m3u8
sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $FV/240p.m3u8
sed -i '/#EXT-X-PLAYLIST-TYPE/d' $FV/240p.m3u8
sed -i '/#EXT-X-ENDLIST/d' $FV/240p.m3u8

sed -i '/#EXTM3U/d' $FV/480p.m3u8
sed -i '/#EXT-X-VERSION/d' $FV/480p.m3u8
sed -i '/#EXT-X-TARGETDURATION/d' $FV/480p.m3u8
sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $FV/480p.m3u8
sed -i '/#EXT-X-PLAYLIST-TYPE/d' $FV/480p.m3u8
sed -i '/#EXT-X-ENDLIST/d' $FV/480p.m3u8

sed -i '/#EXTM3U/d' $FV/720p.m3u8
sed -i '/#EXT-X-VERSION/d' $FV/720p.m3u8
sed -i '/#EXT-X-TARGETDURATION/d' $FV/720p.m3u8
sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $FV/720p.m3u8
sed -i '/#EXT-X-PLAYLIST-TYPE/d' $FV/720p.m3u8
sed -i '/#EXT-X-ENDLIST/d' $FV/720p.m3u8

# # Insert correct headers at the beginning of the output file
sed -i '1i#EXTM3U' $FV/144p.m3u8
sed -i '2i#EXT-X-VERSION:3' $FV/144p.m3u8
sed -i '3i#EXT-X-TARGETDURATION:5' $FV/144p.m3u8
sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $FV/144p.m3u8
sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $FV/144p.m3u8
echo "#EXT-X-ENDLIST" >> $FV/144p.m3u8

sed -i '1i#EXTM3U' $FV/240p.m3u8
sed -i '2i#EXT-X-VERSION:3' $FV/240p.m3u8
sed -i '3i#EXT-X-TARGETDURATION:5' $FV/240p.m3u8
sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $FV/240p.m3u8
sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $FV/240p.m3u8
echo "#EXT-X-ENDLIST" >> $FV/240p.m3u8

sed -i '1i#EXTM3U' $FV/480p.m3u8
sed -i '2i#EXT-X-VERSION:3' $FV/480p.m3u8
sed -i '3i#EXT-X-TARGETDURATION:5' $FV/480p.m3u8
sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $FV/480p.m3u8
sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $FV/480p.m3u8
echo "#EXT-X-ENDLIST" >> $FV/480p.m3u8

sed -i '1i#EXTM3U' $FV/720p.m3u8
sed -i '2i#EXT-X-VERSION:3' $FV/720p.m3u8
sed -i '3i#EXT-X-TARGETDURATION:5' $FV/720p.m3u8
sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $FV/720p.m3u8
sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $FV/720p.m3u8
echo "#EXT-X-ENDLIST" >> $FV/720p.m3u8


touch $FV/index.m3u8

echo "#EXTM3U" > $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=500000,RESOLUTION=256x144" >> $FV/index.m3u8
echo "144p.m3u8" >> $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=426x240" >> $FV/index.m3u8
echo "240p.m3u8" >> $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=1200000,RESOLUTION=854x480" >> $FV/index.m3u8
echo "480p.m3u8" >> $FV/index.m3u8

echo "#EXT-X-STREAM-INF:BANDWIDTH=2500000,RESOLUTION=1280x720" >> $FV/index.m3u8
echo "720p.m3u8" >> $FV/index.m3u8
