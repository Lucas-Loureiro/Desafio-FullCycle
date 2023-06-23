FROM golang:1.17-alpine AS build

RUN apk add --no-cache --update git

WORKDIR /go/src/api
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build -o /go/bin/api


FROM scratch
COPY --from=build /go/bin/api /go/bin/
EXPOSE 3000
CMD ["/go/bin/api"]