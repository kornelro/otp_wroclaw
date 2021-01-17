FROM library/ubuntu:20.04

USER root

RUN apt-get update
RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y wget

RUN mkdir -p /opt/otp/home/wroclaw && mkdir -p /opt/otp/jar
RUN wget https://repo1.maven.org/maven2/org/opentripplanner/otp/2.0.0/otp-2.0.0-shaded.jar -O /opt/otp/jar/otp.jar

RUN wget https://www.wroclaw.pl/open-data/87b09b32-f076-4475-8ec9-6020ed1f9ac0/archiwumOtwartyWroclaw_rozklad_jazdy_GTFS.zip -O /opt/otp/home/wroclaw/mpk.gtfs.zip
RUN wget http://download.bbbike.org/osm/bbbike/Wroclaw/Wroclaw.osm.pbf -O /opt/otp/home/wroclaw/Wroclaw.osm.pbf

EXPOSE 8080
EXPOSE 8081

ENTRYPOINT [ "java", "-Xmx2G", "-jar", "/opt/otp/jar/otp.jar", "--build", "--serve", "/opt/otp/home/wroclaw"]
