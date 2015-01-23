FROM ubuntu:trusty
MAINTAINER Uchio KONDO <udzura@udzura.jp>

RUN apt-get -y update

RUN apt-get -y install ruby2.0 ruby2.0-dev build-essential
RUN apt-get -y install git
RUN update-alternatives \
        --install /usr/bin/ruby ruby /usr/bin/ruby2.0 0 \
        --slave /usr/bin/gem gem /usr/bin/gem2.0

RUN gem install bundler -v=1.7.12 --no-ri --no-rdoc

RUN apt-get -y install stone

RUN mkdir /app
RUN echo 'source "https://rubygems.org"' >  /app/Gemfile
RUN echo 'gem "fluentd", "0.12.3"'       >> /app/Gemfile
RUN echo 'gem "fluent-plugin-irc", github: "udzura/fluent-plugin-irc"' >> /app/Gemfile
RUN echo 'gem "foreman", "0.77.0"'       >> /app/Gemfile

WORKDIR /app
RUN bundle install

ADD files/Procfile /app/Procfile
ADD files/fluentd.conf /etc/fluentd.conf
ADD files/bin/run.sh /usr/local/bin/run
RUN chmod a+x /usr/local/bin/run

EXPOSE 24224 24220 6667

CMD ["/usr/local/bin/run"]
