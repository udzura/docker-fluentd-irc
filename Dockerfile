FROM ubuntu:trusty
MAINTAINER Uchio KONDO <udzura@udzura.jp>

RUN apt-get -y update

RUN apt-get -y install ruby2.0 ruby2.0-dev build-essential
RUN update-alternatives \
        --install /usr/bin/ruby ruby /usr/bin/ruby2.0 0 \
        --slave /usr/bin/gem gem /usr/bin/gem2.0

RUN gem install fluentd -v=0.12.3 --no-ri --no-rdoc
RUN gem install fluent-plugin-irc -v=0.0.5 --no-ri --no-rdoc
RUN gem install foreman -v=0.77.0 --no-ri --no-rdoc

RUN apt-get -y install stone

RUN mkdir /app
ADD files/Procfile /app/Procfile
ADD files/fluentd.conf /etc/fluentd.conf
ADD files/bin/run.sh /usr/local/bin/run
RUN chmod a+x /usr/local/bin/run

EXPOSE 24224 24220 6667

CMD ["/usr/local/bin/run"]
