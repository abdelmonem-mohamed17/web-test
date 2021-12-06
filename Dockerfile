ARG PROJECT_NAME=web
ARG MIGRATION_DIR="migrations"
ARG CONTAINER_PORT="8080"
#ARG DATABASE_URL="postgres://yugabyte@host.docker.internal:${DB_PORT}/${DB_NAME}"

FROM rustlang/rust:nightly as build

ARG PROJECT_NAME

WORKDIR /usr/src/${PROJECT_NAME}

COPY . .

RUN cargo install --path .




FROM ubuntu:20.04
WORKDIR /home/app

ARG PROJECT_NAME
ARG CONTAINER_PORT
ENV SERVICE_PATH="/usr/local/bin/${PROJECT_NAME}"

#RUN apt-get update
#RUN apt-get install -y openssl
#RUN apt-get install -y libpq-dev
#RUN apt-get install gettext-base
COPY --from=build /usr/src/${PROJECT_NAME}/target/release/${PROJECT_NAME} ${SERVICE_PATH}

EXPOSE ${CONTAINER_PORT}


ENTRYPOINT  ["web"]