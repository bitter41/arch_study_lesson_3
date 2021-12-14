FROM perl

RUN cpanm install Test::Spec Data::Structure::Util

COPY . /usr/src/calc
WORKDIR /usr/src/calc
CMD [ "perl", "./calc.pl" ]
