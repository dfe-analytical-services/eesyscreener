## Running eesyscreener in Docker

If you're not a regular R user or don't want to set up R and all the dependencies on your machine, you can use Docker to run eesyscreener in a containerised R environment.

These instructions assume you already have Docker installed. If you don't, please refer to the [Docker installation guide](https://docs.docker.com/get-docker/) for your operating system.

1. Open a terminal and go to the repository root.

2. Build the image:

	```sh
	docker build -f docker/Dockerfile-eesyscreener-dev -t eesyscreener-dev .
	```

3. Start a container:

	```sh
	docker run -ti --name eesyscreener-dev -v ".":"/home/r" -w /home/r eesyscreener-dev
	```

4. In the R console, run:

	```r
	devtools::load_all()
	```

5. Screen away! For example:

	```r
	screen_csv("sample-data/example.csv", "sample-data/example.meta.csv")
	```

	(Assuming you have example files in a `sample-data` folder at the repo root.)


To restart the container at a later time:

```sh
docker start eesyscreener-dev
```
