# build stage
# todo: make run container
FROM southclaws/sampctl:1.9.1 as build

COPY . /samp

WORKDIR /samp

# Install libssl1.0.0 for old discord plugin
RUN apt-get install wget gcc-10-base:i386 libc6:i386 libcrypt1:i386 libgcc-s1:i386 libidn2-0:i386 libunistring2:i386
RUN wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.10_i386.deb	
RUN dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.7_i386.deb

# build gm
RUN sampctl package ensure
RUN sampctl package build
RUN ln -s . scriptfiles/DANGEROUS_SERVER_ROOT

# copy files
RUN tar -xvf serverfiles.tar.gz
RUN cp -r gamemodes/*.amx serverfiles/gamemodes/

WORKDIR /samp/serverfiles
ENTRYPOINT ["/samp/serverfiles/samp-svr"]
