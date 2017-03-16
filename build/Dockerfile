FROM alpine

VOLUME /code

ADD ../code /stage/
ADD deploy.sh /

ADD configs /stageConfig/
ADD deploy_config.sh

CMD /deploy_config.sh && /deploy.sh