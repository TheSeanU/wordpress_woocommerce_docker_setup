# post-install.sh

# Wait for WordPress installation to complete
sleep 10

# Install and activate plugins
wp core install --path="/var/www/html" --url="http://localhost:8000" --title="${COMPOSE_PROJECT_NAME}" --admin_user=${WORDPRESS_ADMIN_USER} --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL}

sleep 10

# Check if WooCommerce ZIP file exists
if [ -f /var/www/html/woocommerce/woocommerce.$WOOCOMMERCE_VERSION.zip ]; then
  unzip /var/www/html/woocommerce/woocommerce.$WOOCOMMERCE_VERSION.zip -d /tmp/woocommerce-$WOOCOMMERCE_VERSION
  mkdir -p $WOOCOMMERCE_DEST
  cp -r /tmp/woocommerce-$WOOCOMMERCE_VERSION/. $WOOCOMMERCE_DEST
  rm -rf /tmp/woocommerce-$WOOCOMMERCE_VERSION
  echo "WooCommerce version $WOOCOMMERCE_VERSION has been unzipped and moved to $WOOCOMMERCE_DEST."
else
  echo "WooCommerce ZIP file not found."
fi

if [ -f $WOOCOMMERCE_DEST/akismet ]; then
  rm -rf $WOOCOMMERCE_DEST/akismet
fi

if [ -f $WOOCOMMERCE_DEST/hello.php ]; then
  rm -rf $WOOCOMMERCE_DEST/hello.php
fi

# Activate plugins
wp plugin activate woocommerce

sleep 5

wp plugin activate --all --quiet --allow-root

echo "WordPress and WooCommerce setup is complete!"
