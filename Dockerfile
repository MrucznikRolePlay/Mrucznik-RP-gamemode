# build stage
FROM southclaws/sampctl:1.9.1 as build

COPY . /samp

WORKDIR /samp

RUN sampctl package ensure
RUN sampctl package build
RUN sampctl server ensure
RUN ln -s . scriptfiles/DANGEROUS_SERVER_ROOT


ENTRYPOINT ["sampctl"]
CMD ["server", "run"]