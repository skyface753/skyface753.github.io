

run:
	docker run -it -v "$PWD":/usr/src/app -w /usr/src/app -p 4000:4000 ruby /bin/bash