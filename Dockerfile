FROM alpine:latest

RUN apk update
RUN apk add postgresql
RUN apk add --update --no-cache bash openssh-client sshpass

RUN eval $(ssh-agent -s)

# add ssh key stored in SSH_PRIVATE_KEY variable to the agent store
RUN bash -c 'ssh-add <(echo "$SSH_PRIVATE_KEY")'

RUN mkdir -p ~/.ssh

RUN echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts

COPY backup.sh .

RUN chmod +x backup.sh
CMD [ "backup.sh" ]
