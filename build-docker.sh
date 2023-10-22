docker stop subconverter
docker rm subconverter
# build with this Dockerfile and tag it subconverter-custom
docker build -t subconverter-custom:latest .
# run the docker detached, forward internal port 25500 to host port 25500
docker run -d --restart=always --name subconverter -p 25500:25500 subconverter-custom:latest
# then check its status
sleep 2
curl http://localhost:25500/version
# if you see `subconverter vx.x.x backend` then the container is up and running
curl -F "data=@pref.ini" http://localhost:25500/updateconf?type=form\&token=password