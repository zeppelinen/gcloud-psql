# a dockerfile with:
#  * the gcloud client
#  * a storage service account key
#  * psql
FROM google/cloud-sdk
MAINTAINER kaiyadavenport@gmail.com
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list
RUN apt-get update
RUN apt-get install -y python-setuptools postgresql-11
RUN easy_install pip
RUN pip install https://bitbucket.org/dbenamy/devcron/get/tip.tar.gz
ADD ./crontab /cron/crontab
ADD ./run.sh /app/run.sh
ADD ./backup.sh /app/backup.sh
RUN chmod a+x /app/run.sh
RUN chmod a+x /app/backup.sh
ENTRYPOINT ["/app/run.sh"]

