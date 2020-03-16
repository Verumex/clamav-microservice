FROM ruby:2.6-alpine
MAINTAINER Verumex

# Install build dependencies
RUN apk --no-cache add clamav clamav-libunrar bash bind-tools rsync ncurses \
    && mkdir /run/clamav \
    && chown clamav:clamav /run/clamav

# Install community virus signatures, setup cron updater, and update virus DB
RUN mkdir -p /usr/local/sbin/ \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/clamav-unofficial-sigs.sh -O /usr/local/sbin/clamav-unofficial-sigs.sh \
    && chmod 755 /usr/local/sbin/clamav-unofficial-sigs.sh \
    && mkdir -p /etc/clamav-unofficial-sigs/ \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/config/master.conf -O /etc/clamav-unofficial-sigs/master.conf \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/config/user.conf -O /etc/clamav-unofficial-sigs/user.conf \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/config/os/os.alpine.conf -O /etc/clamav-unofficial-sigs/os.conf \
    && /usr/local/sbin/clamav-unofficial-sigs.sh --install-cron \
    && freshclam --no-dns

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]
