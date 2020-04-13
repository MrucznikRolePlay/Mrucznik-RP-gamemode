FROM southclaws/sampctl as server

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/Mrucznik/Mrucznik-RP-2.5"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

ENV SAMP_DISCORD_BOT_TOKEN=NjA0NzIwMzk3NTk4MDY0NjUx.XTyEBw.NGrfO3u_0HdE2iUI60IQFQMY_6k
ENV SAMPCTL_GITHUB_TOKEN=1dd34de10953ad0a125f021b8fe16e403db5c870

WORKDIR /samp

COPY ./log-config.yml /samp/log-config.yml
COPY ./mysql.ini /samp/mysql.ini
COPY ./samp.json /samp/samp.json
COPY ./scriptfiles /samp/scriptfiles
COPY  ./gamemodes/Mrucznik-RP.amx /samp/gamemodes/Mrucznik-RP.amx

RUN sampctl server ensure
RUN cd scriptfiles && ln -s .. DANGEROUS_SERVER_ROOT

VOLUME /samp/scriptfiles
VOLUME /samp/logs

ENTRYPOINT ["sampctl"]
CMD ["server", "run"]
