FROM alpine:latest

RUN apk update
RUN apk add postgresql
RUN apk add --no-cache --upgrade bash

COPY backup.sh .

CMD [ "backup.sh" ]
