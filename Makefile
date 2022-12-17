build:
	crystal build src/cloudwatch2sqlite.cr

run:
	crystal src/cloudwatch2sqlite.cr

clean:
	rm cloudwatch2sqlite

all:
	clean build