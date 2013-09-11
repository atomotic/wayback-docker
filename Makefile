usage:
	@echo "make build URL=http://wayback.mydomain"
build:
	sed -e 's/{URL}/$(shell echo $(URL) | sed -e 's/[\/&]/\\&/g')/g' files/wayback.xml.template > files/wayback.xml
	sudo docker build -t wayback .
run:
	sudo docker run -d -v /data:/data wayback
