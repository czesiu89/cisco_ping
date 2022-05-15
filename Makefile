start:
	cd src/cisco_ping && \
		uvicorn app:app --host 0.0.0.0 --port 9000

start-gunicorn:
	cd src/cisco_ping && \
		gunicorn app:app --bind 0.0.0.0:9000 -w 4 -k uvicorn.workers.UvicornWorker

build-docker-image:
	docker build . --network host -t cisco_ping

start-docker:
	docker run -d -p 9000:9000 cisco_ping:latest

stop-docker:
	docker ps -q --filter ancestor=cisco_ping | xargs docker stop

show-docker-logs:
	docker ps -q --filter ancestor=cisco_ping | xargs docker logs -f

terminate-docker:
	docker ps -q --filter ancestor=cisco_ping | xargs docker rm -f