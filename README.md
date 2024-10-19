# Installation & Run

```
docker build -t your_image .
docker run -it --rm -d -p 2222:80 --name your_container your_image
```

# FFMPEG

### preset

- veryfast -crf 23: v:1s -> t:0.2s (~ same as veryslow result)
- veryslow -crf 23: v:1s -> t:3.2s

### bitrate

- twicth: height=1 -> 4.1k

### keyframes

- twicth: 2 per second
