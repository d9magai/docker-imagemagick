FROM centos:centos6
MAINTAINER d9magai

COPY ImageMagick-6.8.6-10.tar.gz /usr/local/src/ImageMagick-6.8.6-10.tar.gz
COPY imagemagick.conf /etc/ld.so.conf.d/imagemagick.conf

RUN yum update -y && \
yum install -y gcc make tar libjpeg-turbo-devel libpng-devel freetype-devel && \
yum clean all

RUN cd /usr/local/src/ && \
tar xf ImageMagick-6.8.6-10.tar.gz && \
cd ImageMagick-6.8.6-10 && \
./configure --prefix=/opt/ImageMagick --enable-shared --disable-openmp --disable-opencl --without-x && \
make && \
make install && \
ldconfig

ENV PATH /opt/ImageMagick/bin/:$PATH

RUN rm -rf /usr/local/src/*

