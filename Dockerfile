FROM base/archlinux:2017.10.01
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG SVN_ACCOUNT=anonymous
ARG SVN_PASS=''

# Define environment vars
ENV SVN_ACCOUNT=${SVN_ACCOUNT} \
    SVN_PASS=${SVN_PASS} \
    SVN_CHECKOUT_DIR=/opt/svn-checkout

# Mount point for Edomi backups
VOLUME ${SVN_CHECKOUT_DIR}
