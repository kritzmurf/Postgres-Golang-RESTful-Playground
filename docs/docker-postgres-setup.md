### Setting up PostgreSQL and PGAdmin4 in Docker Containers

### Installing Docker
If you wish to use Docker Desktop instead of just the Docker CLI environment, you
may download the GUI from [here](https://docs.docker.com/get-started/introduction/get-docker-desktop/).

If you intend to only use the command line tool, you may install it via your Operating System's package
manager.

##### Debian / Ubuntu / Kali / Mint
```bash
    sudo apt update
    sudo apt install docker.io
```

##### Fedora / CentOS / RHEL
```bash
    sudo dnf install docker -ce-cli
```

##### Arch Linux
```bash
    sudo pacman -S docker
```

##### Powershell
```powershell
    winget install -e --id Docker.DockerDesktop
```

##### macOS
```bash
    brew install --cask docker    
```

Test your installation via
```bash
    docker --version
```

### Downloading Official PostgreSQL and PGAdmin4 Images
Once docker is set up in your environment, pull down the postgreSQL and PGAdmin4 official images.
```bash
    docker pull postgres
    docker pull dpage/pgadmin4
```

You can confirm the images were successfully downloaded via:
```bash
    docker image ls
```

### Starting the PostgreSQL and PGAdmin4 Containers
Helper scripts have been provided to assist in starting up the postreSQL and PGAdmin4 containers.
These scripts are located in the `scripts` folder at the root of the project

To start the postgreSQL container manually, run the following command:
```bash
    docker run --name $NAME -e POSTGRES_PASSWORD=$PASSWD -p $PORT -d $IMG_NAME
```
where:
*   `NAME` is the name you are giving the container (script default: pg-tutorial)
*   `PASSWD` is the password to access the container (script default: secure_tutorial)
*   `PORT` is the port for external access to the container (script default: 5432:5432)
*   `IMG_NAME` is the name of the image used to create the container (script default: postgres)

To start the PGAdmin4 container manually, run the following command:
```bash
    docker run --name $NAME -p $PORT -e PGADMIN_DEFAULT_EMAIL=$EMAIL -e PGADMIN_DEFAULT_PASSWORD=$PASSWD -d $IMG_NAME
```
where:
*   `NAME` is the name you are giving the container (script default: pgadmin-tutorial)
*   `PORT` is the port for external access to the container (script default: 5050:80)
*   `EMAIL` is the email address for logging into pgadmin (script default: admin@example.com)
*   `PASSWD` is the password for accessing pgadmin (script default: secure_tutorial)
*   `IMG_NAME` is the name of the image used to create the container (script default: dpage/pgadmin4)

You can confirm that the containers are running via:
```bash
docker ps
```

### Accessing and Setting up PGAdmin
*   If you opted for using Docker desktop, you can access your PGAdmin session via the containers 
    tab and clicking the hyperlink for the ports opened up by the container.

*   If you are using the docker cli, then you will want to open a browser and navigate to:
    `localhost:5050` (assuming you used the port defined in the default script)

*   Log into pgAdmin with the email and password you defined in the pgadmin4 container startup

*   Click 'Add New Server'. Fill out the following fields:
    *   Under the 'General' tab
        *   Add a name for the postgreSQL server
    *   Under the 'Connection' tab
        *   Add the Host name/address. A helper script to determine can be found at `scripts/find_postgres_ip.sh` 
        *   Add the Port number. the default is `5432`, which we defined in our container script
        *   Add the username. This will be `postgres` by default
        *   Add the password. This will be the password defined in the postgres container creation.
            You may click the 'Save Password' toggle to permit pgAdmin to retain this password

*   You should now see the database in the tab.

### Setting Up a Database in PGAdmin
This will not be an exhaustive explanation of pgAdmin, postgreSQL, or SQL syntax. This is instead only intended
to get your basic tutorial up and running.

*   In the Object Explorer, open the drop down of your postreSQL instance and right click 'Databases' and
    Select 'Create > Database...'

*   Under 'Database', name your database and click 'Save'. 

*   Navigate to your new database dropdown menu and select 'Schemas' > 'Table' > 'Create' >  'Table...'

*   Under 'Name', give the table a name.

*   Give the table columns by selecting the 'Columns' tab, clicking the '+' symbol.

*   Name each column you create under 'Name' and define its Data type under 'Data type'

*   Set a table to be the primary key by toggling 'Primary Key', and NULL status with 'Not NULL?'

*   You can view and edit data by right clicking the newly created table and selecting 'View/Edit Data' > 'All Rows'

*   To smoke test, you can add simple data entries into your table by clicking the 'Add Row' key in the data viewer
    and manually inputting entries. Click 'Save Data Changes' when complete

### Connect To Database Container and View Data

*   Connect to the PostgreSQL container you have created. A helper script to connect can be found at `scripts/connect_to_postgres.sh`

*   Enter `\c <YOUR_DATABASE_NAME>` to connect to the database you just created

*   Enter `select * from <SOME_TABLE_YOU_CREATED>`; You should see the test table you created


At this point, your containerized database is up and ready to go, and ready to handle queries.
