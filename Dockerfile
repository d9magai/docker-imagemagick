FROM centos
MAINTAINER d9magai

COPY ImageMagick-6.8.6-10.tar.gz /usr/local/src/ImageMagick-6.8.6-10.tar.gz
COPY imagemagick.conf /etc/ld.so.conf.d/imagemagick.conf

RUN yum update -y && yum clean all
RUN yum install -y gcc && yum clean all
RUN yum install -y make && yum clean all
RUN yum install -y tar && yum clean all
RUN yum install -y libjpeg-turbo-devel && yum clean all
RUN yum install -y libpng-devel && yum clean all
RUN yum install -y freetype-devel && yum clean all

RUN cd /usr/local/src/ && \
tar xf ImageMagick-6.8.6-10.tar.gz && \
cd ImageMagick-6.8.6-10 && \
./configure --prefix=/opt/ImageMagick --enable-shared --disable-openmp --disable-opencl --without-x && \
make && \
make install && \
ldconfig

ENV PATH /opt/ImageMagick/bin/:$PATH

RUN rm -rf /usr/local/src/*

