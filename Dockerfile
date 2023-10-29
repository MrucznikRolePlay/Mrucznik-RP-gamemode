# build stage
# todo: make run container
FROM southclaws/sampctl:1.9.1 as build

COPY . /samp

WORKDIR /samp

# https://stackoverflow.com/questions/22466255/is-it-possible-to-answer-dialog-questions-when-installing-under-docker
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install libssl1.0.0 for old discord plugin
RUN apt-get install wget gcc-10-base:i386 libc6:i386 libcrypt1:i386 libgcc-s1:i386 libidn2-0:i386 libunistring2:i386
RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.20_i386.deb
RUN dpkg -i libssl1.0.0_1.0.2g-1ubuntu4.20_i386.deb

# build gm
RUN sampctl package ensure
RUN sampctl package build

WORKDIR /samp
ENTRYPOINT ["stampctl"]
CMD ["package", "build"]
