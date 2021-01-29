FROM alpine:latest

RUN apk update
RUN apk add postgresql

COPY backup.sh .

ENTRYPOINT [ "/bin/sh" ]
CMD [ "./backup.sh" ]