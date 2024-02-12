# build stage
# todo: make run container
FROM mrucznikpre as build

WORKDIR /samp
COPY . /samp
COPY ./serverfiles/config.json /root/.config/sampctl/

# build gm
#RUN sampctl package ensure
RUN sampctl package build

# copy files
RUN tar -xvf serverfiles.tar.gz
RUN cp -r gamemodes/*.amx serverfiles/gamemodes/

# re-create link for YSI lib
RUN rm /samp/serverfiles/scriptfiles/DANGEROUS_SERVER_ROOT
RUN ln -s /samp/serverfiles /samp/serverfiles/scriptfiles/DANGEROUS_SERVER_ROOT

WORKDIR /samp/serverfiles
ENTRYPOINT ["/samp/serverfiles/samp-svr"]

#WORKDIR /samp
#ENTRYPOINT ["sampctl"]
#CMD ["package", "build"]
