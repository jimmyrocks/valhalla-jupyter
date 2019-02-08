# Valhalla / Jupyter
### Together at last
### US States Edition

# Run this docker-compose configuration

1. If docker or docker-compose isn't already installed, run `bash ./scripts/install_docker.sh` 
2. At your command line run `sudo docker-compose up && sudo docker-compose up`
3. Navigate your browser to `http://localhost:8003`
4. Open the example notebook
5. Click `Not Trusted` then click `Trust`
6. Go to `Cell` and `Run All`
7. Scroll to the bottom, and look at the result

# Valhalla

* To change the states that it downloads, edit the `/scripts/states.txt` file
* You will need to delete the file at `/data/valhalla/valhalla.json` if you want to download the states again.
* TODO: Use and env file instead of adding the environment variables to the start.sh

# Notebooks

* So far only a simple example exists
