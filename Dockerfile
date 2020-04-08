# build stage
FROM southclaws/sampctl

COPY . /samp

WORKDIR /samp

RUN sampctl package ensure
RUN sampctl package build
RUN sampctl server ensure

ENTRYPOINT ["sampctl"]
CMD ["server", "run"]
