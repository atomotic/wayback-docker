wayback-docker
===============

waybackmachine in a docker container. `mementoweb` and `xml` enabled.

current version: **ubuntu precise**, **java 1.6**, **tomcat 6**, **wayback-1.6.0**  
only a BDBCollection is enabled, watching /data for warcs

### build

choose a domain name for your wayback `WAYBACK_URL` and run

	make build URL=http://{WAYBACK_URL}

this modifies the template files/wayback.xml.template and launch `docker build -t wayback`.

	
### run

create two host directories containing wayback indexes and warc files

	mkdir -p /data/{warcs,indexes}	
	
run the container:
	
	make run
	
or manually

	sudo docker run -v /data:/data wayback

* port 8080 is exposed
* host directory `/data` is mounted on container directory `/data`
 


### proxy with nginx (optional)
 
create a new nginx virtualhost proxying `host:80` -> `container:8080`

change {URL} with the url chosen for wayback.xml

	upstream wayback {
    	server 127.0.0.1:8080;
	}

	server {
		listen   80;
		server_name  {WAYBACK_URL};
		access_log  /var/log/nginx/access.log;

		location / {
			proxy_pass http://wayback;
			proxy_set_header  Host $http_host;
		}
	}
	
	
### available urls

`http://{WAYBACK_URL}`  wayback home page  

`http://{WAYBACK_URL}/xml/*/{URL}`  xml output for an archived url 

`http://{WAYBACK_URL}/memento/timegate/{URL}`  memento timegate for an archived url 

`http://{WAYBACK_URL}/memento/20120120193226/{URL}`  memento at a specified date 

`http://{WAYBACK_URL}/list/timemap/link/{URL}`  memento timemap 

`http://{WAYBACK_URL}/list/timebundle/{URL}` memento timebundle

`http://{WAYBACK_URL}/list/timemap/rdf/{URL}` memento timebundle rdf


