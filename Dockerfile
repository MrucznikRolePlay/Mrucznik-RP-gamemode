# build stage
# todo: make run container
FROM mrucznikpre as build

COPY . /samp
WORKDIR /samp

RUN ln -s /samp /samp/scriptfiles/DANGEROUS_SERVER_ROOT
# todo: sampctl build + amx_fix

ENTRYPOINT ["sampctl"]
CMD ["package", "run"]