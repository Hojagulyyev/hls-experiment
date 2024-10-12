docker build -f Dockerfile.example -t video .
docker run -it --rm -d -p 2222:80 --name netblog video
