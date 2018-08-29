FROM ruby:2.5

RUN set -ex \
      && gem install specific_install \
      && gem specific_install https://github.com/bigwheel/yaml_strict_merge.git master


ENTRYPOINT ["merge_yaml"]
CMD []
