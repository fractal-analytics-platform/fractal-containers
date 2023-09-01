#!/bin/bash

RELEASE="0.5.3"

echo "*** Fetching a clean copy of fractal-web ${RELEASE} ***"

rm -fr fractal-web-${RELEASE}
rm -f ${RELEASE}.tar.gz

# wget https://github.com/fractal-analytics-platform/fractal-web/archive/refs/tags/${RELEASE}.tar.gz
# tar -xvf ${RELEASE}.tar.gz
# mv fractal-web-${RELEASE}/ fractal-web/
# rm ${RELEASE}.tar.gz

git clone https://github.com/fractal-analytics-platform/fractal-web.git
cd fractal-web
git checkout 274-fix-cookie-issue

