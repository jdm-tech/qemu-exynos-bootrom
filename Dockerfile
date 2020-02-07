From ubuntu:xenial

USER root
#Install Dependencies
RUN apt-get update && apt-get install -yq git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev gcc-5 g++-5 git-email libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev libcap-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev librbd-dev librdmacm-dev libsasl2-dev libsdl1.2-dev libseccomp-dev libsnappy-dev libssh2-1-dev libvde-dev libvdeplug-dev libvte-dev libxen-dev liblzo2-dev valgrind xfslibs-dev libnfs-dev libiscsi-dev ncurses-base ncurses-dev libncursesw5 libncursesw5-dev

#Add a user and stop being root
RUN useradd -r -m -d /home/quser -u 999 -U quser
USER quser
WORKDIR /home/quser/

#Clone the git repo
RUN git clone https://github.com/frederic/qemu-exynos-bootrom.git

#Build Qemu
#To speed up the compile with multiple cores add -j# where # is the number of cores on your computer ex. on a 4 core pc -j4.
RUN cd qemu-exynos-bootrom && mkdir build && cd build && ../configure --enable-curses && make -j

CMD ["/bin/bash"]
