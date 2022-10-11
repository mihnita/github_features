FROM openjdk:11.0.15-jdk-slim

RUN apt-get -q update --yes \
    && apt-get -q install --yes --no-install-recommends git maven ant curl gpg \
    && rm -rf /var/lib/apt/lists/*

RUN echo ============== \
    && java -version \
    && javac -version \
    && mvn -version \
    && ant -version \
    && git --version \
    && gpg --version \
    && curl --version \
    && date

WORKDIR /root

ENTRYPOINT /bin/bash
