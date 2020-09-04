FROM osrm/osrm-backend
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /data
RUN  wget --no-check-certificate https://download.geofabrik.de/asia/cambodia-latest.osm.pbf -O /data/cambodia-latest.osm.pbf

RUN  /usr/local/bin/osrm-extract -p /opt/car.lua /data/cambodia-latest.osm.pbf && \
     /usr/local/bin/osrm-partition /data/cambodia-latest.osrm && \
     /usr/local/bin/osrm-customize /data/cambodia-latest.osrm

ENTRYPOINT /usr/local/bin/osrm-routed --algorithm mld /data/cambodia-latest.osrm