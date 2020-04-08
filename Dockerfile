# build stage
FROM southclaws/sampctl

COPY . /samp

WORKDIR /samp

RUN sampctl package ensure
RUN sampctl package build
RUN sampctl server ensure
RUN ln -s . scriptfiles/DANGEROUS_SERVER_ROOT

ENTRYPOINT ["sampctl"]
CMD ["server", "run"]
