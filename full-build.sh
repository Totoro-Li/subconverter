docker compose down
# build with this Dockerfile and tag it subconverter-custom
docker build -t subconverter-custom:latest -f scripts/Dockerfile .
# run the docker detached, forward internal port 25500 to host port 25500
docker compose up -d
# then check its status

sleep 1
curl http://localhost:25500/version
# # if you see `subconverter vx.x.x backend` then the container is up and running
# curl -F "data=@pref.ini" http://localhost:25500/updateconf?type=form\&token=password