# build stage
FROM southclaws/sampctl

COPY . /samp

WORKDIR /samp

VOLUME /samp/scriptfiles
VOLUME /samp/logs

RUN sampctl package ensure
RUN sampctl package build

ENTRYPOINT ["sampctl"]
CMD ["package", "run"]
