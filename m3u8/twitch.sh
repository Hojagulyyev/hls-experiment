#!/bin/bash

videos_dir="twitch"

mkdir $videos_dir

ffmpeg -i input.mp4 \
    -vf "scale=w=256:h=144" -c:v:0 libx264 -b:v:0 504k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/144p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/144p.m3u8" \
    -vf "scale=w=426:h=240" -c:v:1 libx264 -b:v:1 840k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/240p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/240p.m3u8" \
    -vf "scale=w=854:h=480" -c:v:2 libx264 -b:v:2 1680k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/480p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/480p.m3u8" \
    -vf "scale=w=1280:h=720" -c:v:3 libx264 -b:v:3 2520k -g 120 -keyint_min 120 -sc_threshold 0 -hls_time 5 \
        -hls_segment_filename "$videos_dir/720p_%03d.ts" -hls_playlist_type vod -an "$videos_dir/720p.m3u8" \
    -map a:0 -c:a aac -b:a 128k -f hls -hls_time 5 \
        -hls_segment_filename "$videos_dir/audio_%03d.aac" -hls_playlist_type vod "$videos_dir/audio.m3u8"


# ffmpeg -i input.mp4 \
#     -vf "scale=w=256:h=144" -c:v:0 libx264 -b:v:0 500k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$videos_dir/144p_p2_%03d.ts" -ss 7 -hls_playlist_type vod -an $videos_dir/144p_p2.m3u8 \
#     -vf "scale=w=426:h=240" -c:v:1 libx264 -b:v:1 800k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$videos_dir/240p_p2_%03d.ts" -ss 7 -hls_playlist_type vod -an $videos_dir/240p_p2.m3u8 \
#     -vf "scale=w=854:h=480" -c:v:2 libx264 -b:v:2 1200k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$videos_dir/480p_p2_%03d.ts" -ss 7 -hls_playlist_type vod -an $videos_dir/480p_p2.m3u8 \
#     -vf "scale=w=1280:h=720" -c:v:3 libx264 -b:v:3 2500k -g 144 -keyint_min 144 -sc_threshold 0 -hls_time 5 -hls_segment_filename "$videos_dir/720p_p2_%03d.ts" -ss 7 -hls_playlist_type vod -an $videos_dir/720p_p2.m3u8 \
#     -map a:0 -c:a aac -b:a 128k -f hls -hls_time 5 -hls_segment_filename "$videos_dir/audio_p2_%03d.aac" -ss 7 "$videos_dir/audio_p2.m3u8"

# cat $videos_dir/144p_p1.m3u8 $videos_dir/144p_p2.m3u8 > $videos_dir/144p.m3u8
# cat $videos_dir/240p_p1.m3u8 $videos_dir/240p_p2.m3u8 > $videos_dir/240p.m3u8
# cat $videos_dir/480p_p1.m3u8 $videos_dir/480p_p2.m3u8 > $videos_dir/480p.m3u8
# cat $videos_dir/720p_p1.m3u8 $videos_dir/720p_p2.m3u8 > $videos_dir/720p.m3u8
# cat $videos_dir/audio_p1.m3u8 $videos_dir/audio_p2.m3u8 > $videos_dir/audio.m3u8

# # Remove duplicate headers from the concatenated file
# sed -i '/#EXTM3U/d' $videos_dir/144p.m3u8
# sed -i '/#EXT-X-VERSION/d' $videos_dir/144p.m3u8
# sed -i '/#EXT-X-TARGETDURATION/d' $videos_dir/144p.m3u8
# sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $videos_dir/144p.m3u8
# sed -i '/#EXT-X-PLAYLIST-TYPE/d' $videos_dir/144p.m3u8
# sed -i '/#EXT-X-ENDLIST/d' $videos_dir/144p.m3u8

# sed -i '/#EXTM3U/d' $videos_dir/240p.m3u8
# sed -i '/#EXT-X-VERSION/d' $videos_dir/240p.m3u8
# sed -i '/#EXT-X-TARGETDURATION/d' $videos_dir/240p.m3u8
# sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $videos_dir/240p.m3u8
# sed -i '/#EXT-X-PLAYLIST-TYPE/d' $videos_dir/240p.m3u8
# sed -i '/#EXT-X-ENDLIST/d' $videos_dir/240p.m3u8

# sed -i '/#EXTM3U/d' $videos_dir/480p.m3u8
# sed -i '/#EXT-X-VERSION/d' $videos_dir/480p.m3u8
# sed -i '/#EXT-X-TARGETDURATION/d' $videos_dir/480p.m3u8
# sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $videos_dir/480p.m3u8
# sed -i '/#EXT-X-PLAYLIST-TYPE/d' $videos_dir/480p.m3u8
# sed -i '/#EXT-X-ENDLIST/d' $videos_dir/480p.m3u8

# sed -i '/#EXTM3U/d' $videos_dir/720p.m3u8
# sed -i '/#EXT-X-VERSION/d' $videos_dir/720p.m3u8
# sed -i '/#EXT-X-TARGETDURATION/d' $videos_dir/720p.m3u8
# sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $videos_dir/720p.m3u8
# sed -i '/#EXT-X-PLAYLIST-TYPE/d' $videos_dir/720p.m3u8
# sed -i '/#EXT-X-ENDLIST/d' $videos_dir/720p.m3u8

# sed -i '/#EXTM3U/d' $videos_dir/audio.m3u8
# sed -i '/#EXT-X-VERSION/d' $videos_dir/audio.m3u8
# sed -i '/#EXT-X-TARGETDURATION/d' $videos_dir/audio.m3u8
# sed -i '/#EXT-X-MEDIA-SEQUENCE/d' $videos_dir/audio.m3u8
# sed -i '/#EXT-X-ENDLIST/d' $videos_dir/audio.m3u8

# # # Insert correct headers at the beginning of the output file
# sed -i '1i#EXTM3U' $videos_dir/144p.m3u8
# sed -i '2i#EXT-X-VERSION:3' $videos_dir/144p.m3u8
# sed -i '3i#EXT-X-TARGETDURATION:5' $videos_dir/144p.m3u8
# sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $videos_dir/144p.m3u8
# sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $videos_dir/144p.m3u8
# echo "#EXT-X-ENDLIST" >> $videos_dir/144p.m3u8

# sed -i '1i#EXTM3U' $videos_dir/240p.m3u8
# sed -i '2i#EXT-X-VERSION:3' $videos_dir/240p.m3u8
# sed -i '3i#EXT-X-TARGETDURATION:5' $videos_dir/240p.m3u8
# sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $videos_dir/240p.m3u8
# sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $videos_dir/240p.m3u8
# echo "#EXT-X-ENDLIST" >> $videos_dir/240p.m3u8

# sed -i '1i#EXTM3U' $videos_dir/480p.m3u8
# sed -i '2i#EXT-X-VERSION:3' $videos_dir/480p.m3u8
# sed -i '3i#EXT-X-TARGETDURATION:5' $videos_dir/480p.m3u8
# sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $videos_dir/480p.m3u8
# sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $videos_dir/480p.m3u8
# echo "#EXT-X-ENDLIST" >> $videos_dir/480p.m3u8

# sed -i '1i#EXTM3U' $videos_dir/720p.m3u8
# sed -i '2i#EXT-X-VERSION:3' $videos_dir/720p.m3u8
# sed -i '3i#EXT-X-TARGETDURATION:5' $videos_dir/720p.m3u8
# sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $videos_dir/720p.m3u8
# sed -i '5i#EXT-X-PLAYLIST-TYPE:VOD' $videos_dir/720p.m3u8
# echo "#EXT-X-ENDLIST" >> $videos_dir/720p.m3u8

# sed -i '1i#EXTM3U' $videos_dir/audio.m3u8
# sed -i '2i#EXT-X-VERSION:3' $videos_dir/audio.m3u8
# sed -i '3i#EXT-X-TARGETDURATION:5' $videos_dir/audio.m3u8
# sed -i '4i#EXT-X-MEDIA-SEQUENCE:0' $videos_dir/audio.m3u8
# echo "#EXT-X-ENDLIST" >> $videos_dir/audio.m3u8


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

echo "# Audio Group" >> $videos_dir/index.m3u8
echo "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",NAME="AAC Audio",DEFAULT=YES,AUTOSELECT=YES,URI="audio.m3u8"" >> $videos_dir/index.m3u8
