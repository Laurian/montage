FROM ubuntu

RUN apt-get update && apt-get install -y curl python-pip python-dev build-essential libpng-dev libmysqlclient-dev mysql-client git

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    \curl -sSL https://get.rvm.io | bash -s stable --ruby && \
    /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc" && \
    /bin/bash -l -c "gem install sass --no-ri --no-rdoc"

RUN mkdir /app
WORKDIR /app

COPY ./package.json ./package-lock.json /app/
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs && \
    npm i -g grunt bower && \
    npm i

COPY ./requirements.txt /app
RUN pip install -r requirements.txt

EXPOSE 8000 8080 8081 8082 8083 8084

COPY ./docker-entrypoint.sh /app
CMD ["/app/docker-entrypoint.sh"]
