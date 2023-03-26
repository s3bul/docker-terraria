ARG TARGETPLATFORM=linux/amd64
ARG BUILDPLATFORM=${TARGETPLATFORM}
ARG IMAGE_DOTNET_SDK_NAME
ARG IMAGE_DOTNET_RUNTIME_NAME
ARG IMAGE_DOTNET_VERSION


FROM --platform=${BUILDPLATFORM} ${IMAGE_DOTNET_SDK_NAME}:${IMAGE_DOTNET_VERSION} AS build
LABEL maintainer="Sebastian Korzeniecki <seba5zer@gmail.com>"

ARG TMODLOADER_VERSION

WORKDIR /opt/tModLoader

RUN apk add bash && \
  wget --no-check-certificate https://github.com/tModLoader/tModLoader/releases/download/v${TMODLOADER_VERSION}/tModLoader.zip && \
  unzip tModLoader.zip -d server && \
  chmod -R g+w server && \
  chmod +x server/start-tModLoaderServer.sh


FROM --platform=${BUILDPLATFORM} ${IMAGE_DOTNET_SDK_NAME}:${IMAGE_DOTNET_VERSION} AS server
LABEL maintainer="Sebastian Korzeniecki <seba5zer@gmail.com>"

ENV TERRARIA_USER=terraria
ENV TERRARIA_HOME=/home/${TERRARIA_USER}
ENV SERVER_HOME=${TERRARIA_HOME}/server
ENV TMP_HOME=${TERRARIA_HOME}/tmp
ENV CONF_HOME=${TERRARIA_HOME}/conf
ENV TERRARIA_LOCAL_DIR=${TERRARIA_HOME}/.local/share/Terraria

RUN apk add bash && \
  adduser -D ${TERRARIA_USER} && \
  addgroup ${TERRARIA_USER} root && \
  addgroup root ${TERRARIA_USER} && \
  mkdir -p ${SERVER_HOME} ${CONF_HOME} ${TMP_HOME} ${TERRARIA_LOCAL_DIR} && \
  chmod g+rwxs ${TERRARIA_HOME} ${SERVER_HOME} ${CONF_HOME} ${TMP_HOME} ${TERRARIA_LOCAL_DIR} && \
  chown -R ${TERRARIA_USER}:0 ${TERRARIA_HOME}

USER ${TERRARIA_USER}:0

WORKDIR ${TERRARIA_HOME}

COPY --from=build --chown=${TERRARIA_USER}:0 /opt/tModLoader/server ${TMP_HOME}
COPY --chown=${TERRARIA_USER}:0 docker-entrypoint.sh ${TERRARIA_HOME}

EXPOSE 7777

VOLUME ["${SERVER_HOME}", "${TERRARIA_LOCAL_DIR}"]

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["run"]
