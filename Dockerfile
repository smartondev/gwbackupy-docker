FROM python:3-alpine

#RUN pip install --no-cache-dir gwbackupy
RUN pip install --no-cache-dir https://github.com/smartondev/gwbackupy/archive/oauth-bind-port.zip
RUN apk add --no-cache bash

ENV GWBACKUPY_WORKDIR="/data"
ENV GWBACKUPY_APPDIR="/app"
ENV GWBACKUPY_ACCOUNT_EMAILS="example@example.com example2@example.com"
ENV GWBACKUPY_CRON_FULL_SYNC="0 0 * * 0"
ENV GWBACKUPY_CRON_QUICK_SYNC="0 0 * * 1-6"
ENV GWBACKUPY_CRON_LOG="${GWBACKUPY_APPDIR}/crontab.log"
ENV GWBACKUPY_CRONTAB="${GWBACKUPY_APPDIR}/crontab"
ENV GWBACKUPY_LOG_LEVEL="warning"
ENV GWBACKUPY_CREDENTIALS_FILEPATH=""
ENV GWBACKUPY_SERVICE_ACCOUNT_KEY_FILEPATH=""
ENV GWBACKUPY_MAIN_OPTIONS=""
ENV TERM="xterm-256color"
ENV GWBACKUPY_SERVICES="gmail"
ENV GWBACKUPY_OAUTH_REDIRECT_HOST="localhost"
ENV GWBACKUPY_OAUTH_PORT="43339"
ENV GWBACKUPY_OAUTH_BIND_ADDRESS="0.0.0.0"

VOLUME ${GWBACKUPY_WORKDIR}
WORKDIR ${GWBACKUPY_APPDIR}
COPY ./full-sync.sh ${GWBACKUPY_APPDIR}/
COPY ./quick-sync.sh ${GWBACKUPY_APPDIR}/
COPY ./entrypoint.sh ${GWBACKUPY_APPDIR}/
COPY ./prepare.sh ${GWBACKUPY_APPDIR}/
COPY ./access-init.sh ${GWBACKUPY_APPDIR}/
RUN touch ${GWBACKUPY_CRON_LOG}
RUN echo "${GWBACKUPY_CRON_FULL_SYNC} /bin/bash ${GWBACKUPY_APPDIR}/full-sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" > ${GWBACKUPY_CRONTAB}
RUN echo "${GWBACKUPY_CRON_QUICK_SYNC} /bin/bash ${GWBACKUPY_APPDIR}/quick-sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" >> ${GWBACKUPY_CRONTAB}
RUN crontab ${GWBACKUPY_CRONTAB}
RUN crontab -l
#CMD crond && tail -f ${GWBACKUPY_CRON_LOG}
CMD ["/bin/bash", "entrypoint.sh"]
#ENTRYPOINT ["python", "-m", "gwbackupy", "--workdir=${GWBACKUPY_WORKDIR}"]