FROM alpine:latest

RUN apk update
RUN apk add postgresql
RUN apk add --update --no-cache bash openssh-client sshpass

COPY backup.sh .

RUN chmod +x backup.sh
CMD [ "backup.sh" ]
