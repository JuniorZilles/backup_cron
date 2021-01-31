FROM alpine:latest

RUN apk update
RUN apk add postgresql
RUN apk add --no-cache --upgrade bash
RUN apk add sshpass

COPY backup.sh .

RUN chmod +x backup.sh
CMD [ "backup.sh" ]
