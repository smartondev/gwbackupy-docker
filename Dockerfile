FROM python:3-alpine

RUN apk add --no-cache bash tzdata logrotate

ARG GWBACKUPY_PIP_PACKAGE="gwbackupy"
ARG GWBACKUPY_PIP_VERSION=""
RUN pip install --no-cache-dir ${GWBACKUPY_PIP_PACKAGE}${GWBACKUPY_PIP_VERSION}

ENV GWBACKUPY_WORKDIR="/data"
ENV GWBACKUPY_TEMPDIR="/tmp"
ENV GWBACKUPY_LOGDIR="${GWBACKUPY_WORKDIR}/logs"
ENV GWBACKUPY_APPDIR="/app"
ENV GWBACKUPY_ACCOUNT_EMAILS="example@example.com example2@example.com"
ENV GWBACKUPY_CRON_FULL_SYNC="0 0 * * 0"
ENV GWBACKUPY_CRON_QUICK_SYNC="0 */12 * * *"
ENV GWBACKUPY_CRON_LOG="${GWBACKUPY_LOGDIR}/crontab.log"
ENV GWBACKUPY_CRON_FLOCK_FILEPATH="/var/lock/gwbackupy-cron.lock"
ENV GWBACKUPY_CRONTAB="${GWBACKUPY_APPDIR}/crontab"
ENV GWBACKUPY_LOG_LEVEL="warning"
ENV GWBACKUPY_CREDENTIALS_FILEPATH=""
ENV GWBACKUPY_SERVICE_ACCOUNT_KEY_FILEPATH=""
ENV GWBACKUPY_MAIN_ARGS=""
ENV TERM="xterm-256color"
ENV GWBACKUPY_SERVICES="gmail"
ENV GWBACKUPY_OAUTH_REDIRECT_HOST="127.0.0.1"
ENV GWBACKUPY_OAUTH_PORT="43339"
ENV GWBACKUPY_OAUTH_BIND_ADDRESS="0.0.0.0"
ENV GWBACKUPY_QUICK_SYNC_DAYS="7"
ENV GWBACKUPY_GMAIL_ARGS=""

VOLUME ${GWBACKUPY_WORKDIR}
WORKDIR ${GWBACKUPY_APPDIR}
COPY sync.sh ${GWBACKUPY_APPDIR}/
COPY quick-sync.sh ${GWBACKUPY_APPDIR}/
COPY entrypoint.sh ${GWBACKUPY_APPDIR}/
COPY prepare.sh ${GWBACKUPY_APPDIR}/
COPY access-init.sh ${GWBACKUPY_APPDIR}/
COPY access-check.sh ${GWBACKUPY_APPDIR}/
COPY logcmd.sh ${GWBACKUPY_APPDIR}/
RUN chmod o+x "${GWBACKUPY_APPDIR}/sync.sh"
RUN chmod o+x "${GWBACKUPY_APPDIR}/quick-sync.sh"
RUN chmod o+x "${GWBACKUPY_APPDIR}/entrypoint.sh"
RUN chmod o+x "${GWBACKUPY_APPDIR}/prepare.sh"
RUN chmod o+x "${GWBACKUPY_APPDIR}/access-init.sh"
RUN chmod o+x "${GWBACKUPY_APPDIR}/access-check.sh"
RUN chmod o+x "${GWBACKUPY_APPDIR}/logcmd.sh"
CMD ["/bin/bash", "entrypoint.sh"]
