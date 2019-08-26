# #!/bin/bash
# # Build Path: /app/.heroku/php/
# perl isntall swoole

#!/bin/bash
# Build Path: /app/.heroku/php/
dep_url=https://github.com/swoole/swoole-src.git
swoole_dir=swoole-src
echo "-----> Building Swoole..."

### Phalcon
echo "[LOG] Downloading SwoolePHP"
git clone $dep_url -q
if [ ! -d "$swoole_dir" ]; then
  echo "[ERROR] Failed to find phalconphp directory $swoole_dir"
  exit
fi
cd $swoole_dir/
git checkout v4.3.6

# /app/php/bin/phpize
# ./configure --enable-phalcon --with-php-config=$PHP_ROOT/bin/php-config
# make
# make install
BUILD_DIR=$1

PHPIZE_BIN=$(command -v phpize 2>/dev/null)
# PHPCONFIG_BIN=$(command -v php-config 2>/dev/null)

ln -s $BUILD_DIR/.heroku /app/.heroku
export PATH=/app/.heroku/php/bin:$PATH

bash ${PHPIZE_BIN} && \
./configure --enable-openssl --enable-sockets && \
make && make install

# cd
echo "important extension phalcon into php.ini"
echo "extension=swoole.so" >> /app/.heroku/php/etc/php/php.ini