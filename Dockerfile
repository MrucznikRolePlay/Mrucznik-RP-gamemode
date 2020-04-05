# build stage
FROM southclaws/sampctl

COPY . /samp

WORKDIR /samp

VOLUME /samp/scriptfiles

RUN sampctl package ensure
RUN sampctl package build

ENTRYPOINT ["sampctl"]
CMD ["package", "run"]
