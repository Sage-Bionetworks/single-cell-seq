FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
       python3 \
       python3-setuptools \
       python3-pip \
       python3-pandas  

RUN pip3 install --upgrade pip
RUN pip3 install unidecode 

COPY bin/reshapeImmunePredictions.py /usr/local/bin/reshapeImmunePredictions.py

RUN chmod 777 /usr/local/bin/reshapeImmunePredictions.py

ENV PATH="/usr/local/bin:${PATH}"
