BINARY=engine
test: 
	go test -v -cover -covermode=atomic ./...

coverage:
	go test -v -coverprofile=coverage.out ./... && go tool cover -html=coverage.out

engine:
	go build -o ${BINARY} app/*.go

unittest:
	go test -short  ./...

clean:
	if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi

docker:
	docker build -t go-clean-arch .

build: stop
	docker-compose up --build

run: stop
	docker-compose up

stop:
	docker-compose down

lint-prepare:
	@echo "Installing golangci-lint" 
	curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh| sh -s latest

lint:
	./bin/golangci-lint run ./...

.PHONY: clean install unittest build docker run stop vendor lint-prepare lint
