FROM ruby:3.3.3-alpine
MAINTAINER Verumex, Inc.

# Install build dependencies
RUN apk --no-cache add clamav clamav-libunrar bash bind-tools rsync ncurses \
    && mkdir /run/clamav \
    && chown clamav:clamav /run/clamav

# Install community virus signatures, setup cron updater, and update virus DB
# Using virus signature updater from 7.2.5 release.
# See https://github.com/extremeshok/clamav-unofficial-sigs/releases/tag/7.2.5
RUN mkdir -p /usr/local/sbin/ \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/ececc4b53286666d9bb65336a9ab079c804b28a6/clamav-unofficial-sigs.sh -O /usr/local/sbin/clamav-unofficial-sigs.sh \
    && chmod 755 /usr/local/sbin/clamav-unofficial-sigs.sh \
    && mkdir -p /etc/clamav-unofficial-sigs/ \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/ececc4b53286666d9bb65336a9ab079c804b28a6/config/master.conf -O /etc/clamav-unofficial-sigs/master.conf \
    && sed -i 's/^enable_random="yes"/enable_random="no"/g' /etc/clamav-unofficial-sigs/master.conf \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/ececc4b53286666d9bb65336a9ab079c804b28a6/config/user.conf -O /etc/clamav-unofficial-sigs/user.conf \
    && wget https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/ececc4b53286666d9bb65336a9ab079c804b28a6/config/os/os.alpine.conf -O /etc/clamav-unofficial-sigs/os.conf \
    && /usr/local/sbin/clamav-unofficial-sigs.sh --install-cron \
    && freshclam --no-dns

COPY . /app
WORKDIR /app

RUN gem install bundler \
    && bundle config set without development test \
    && bundle install

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]
