FROM centos
MAINTAINER d9magai

ENV IMAGEMAGICK_VERSION 6.8.6-10
ENV IMAGEMAGICK_ARCHIVE ImageMagick-$IMAGEMAGICK_VERSION.tar.gz
ENV IMAGEMAGICK_PREFIX /opt/ImageMagick
ENV IMAGEMAGICK_LD_CONF /etc/ld.so.conf.d/imagemagick.conf

RUN yum update -y \
&&  yum install -y \
    gcc \
    make \
    tar \
    libjpeg-turbo-devel \
    libpng-devel \
    freetype-devel \
&&  yum clean all

RUN mkdir -p $IMAGEMAGICK_PREFIX/src \
&& cd $IMAGEMAGICK_PREFIX/src \
&& curl -sL http://www.imagemagick.org/download/releases/$IMAGEMAGICK_ARCHIVE -o $IMAGEMAGICK_ARCHIVE \
&& tar xf $IMAGEMAGICK_ARCHIVE \
&& rm $IMAGEMAGICK_ARCHIVE \
&& cd ImageMagick-$IMAGEMAGICK_VERSION \
&& ./configure --prefix=$IMAGEMAGICK_PREFIX --enable-shared --disable-openmp --disable-opencl --without-x \
&& make \
&& make install \
&& rm -rf $IMAGEMAGICK_PREFIX/share \
&& rm -rf $IMAGEMAGICK_PREFIX/src

RUN echo $IMAGEMAGICK_PREFIX/lib/ > $IMAGEMAGICK_LD_CONF && ldconfig

ENV PATH /opt/ImageMagick/bin/:$PATH

