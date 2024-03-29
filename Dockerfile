FROM tensorflow/tensorflow:1.14.0-gpu-py3

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	build-essential \
	cmake \
	pkg-config \
	libjpeg8-dev \
	libtiff5-dev \
	libpng-dev \
	python3-matplotlib \
	python3-cairosvg \
	python3-openslide \
	python3-shapely \
	git

#installs opencv 4.1.0
RUN curl -o 4.1.0.zip https://codeload.github.com/opencv/opencv/zip/4.1.0 \
	&& unzip 4.1.0.zip \
	&& cd opencv-4.1.0/ \
	&& mkdir build \
	&& cd build \
	&& cmake CMAKE_BUILD_TYPE=RELEASE \
		-D CMAKE_INSTALL_PREFIX=/usr/local \
		-D INSTALL_PYTHON_EXAMPLES=ON \
		 -D INSTALL_C_EXAMPLES=OFF \
		.. \
	&& make -j16 \
	&& make install \
	&& cd / \
	&& rm /4.1.0.zip 
RUN rm -r opencv-4.1.0

# Cytomine-python-client

RUN mkdir /root/Cytomine
RUN cd /root/Cytomine/ && git clone https://github.com/cytomine-uliege/Cytomine-python-client.git && cd Cytomine-python-client/ && git checkout v2.2.0
RUN cd /root/Cytomine/Cytomine-python-client/ && python3 setup.py install

WORKDIR app

