FROM golang:1.11-alpine AS go-builder

ENV DOCKER_GEN_VERSION=0.7.4

# Install build dependencies for docker-gen
RUN apk add --update \
        curl \
        gcc \
        git \
        make \
        musl-dev

# Build docker-gen
#RUN go get github.com/jwilder/forego \
#    && cd /go/src/github.com/jwilder/forego \
#    && git checkout $DOCKER_GEN_VERSION \
#    && make get-deps \
#    && make all
RUN  mkdir -p /go/src \
  && mkdir -p /go/bin \
  && mkdir -p /go/pkg
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH   

# now copy your app to the proper build path
ADD . $GOPATH/src/

# should be able to build now
WORKDIR $GOPATH/src/
RUN go get -u github.com/ddollar/forego
#RUN go build -o forego . 
