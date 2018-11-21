# Docker image for Woocommerce with Becopay gateway


### Quick start

The easiest way to start Woocommerce with MySQL is using [Docker Compose](https://docs.docker.com/compose/). Just clone this repo and run following command in the root directory. The default `docker-compose.yml` uses MySQL and phpMyAdmin.

```
$ docker-compose up -d
```

For admin username and password, please refer to the file `env`. You can also update the file `env` to update those configurations. Below are the default configurations.

```
MYSQL_HOST=db
MYSQL_ROOT_PASSWORD=myrootpassword
MYSQL_USER=wpbeco
MYSQL_PASSWORD=wpbeco
MYSQL_DATABASE=wpbecodb
MYSQL_PREFIX=becowp_

BASE_URL=http://127.0.0.1
SITE_TITLE=my-store
ADMIN_EMAIL=amdin@example.com
ADMIN_USERNAME=admin
ADMIN_PASSWORD=Admin123456

```

For example, if you want to change the default currency, just update the variable `ADMIN_USERNAME`, e.g. `ADMIN_USERNAME=adminbeco`.


## Installation

After starting the container, you'll see the setup page of Wordpress. You can use the script `install-wordpress` to quickly install Wordpress. The installation script uses the variables in the `env` file.

### Wordpress

```
$ docker exec -it <container_name> install-wordpress
```

### Database

The default `docker-compose.yml` uses MySQL as the database and starts [phpMyAdmin](https://www.phpmyadmin.net/). The default URL for phpMyAdmin is `http://localhost:8580`. Use MySQL username and password to log in.


## Configure the plugin

__Note :__ You must have a Becopay merchant account to use this plugin.  It's free and easy to [sign-up for a becopay merchant account](https://becopay.com/en/merchant-register/).

To configure the plugin, go to __WooCommerce > Settings__ from the left hand menu, then click "Payment Gateways" from the top tab. You should see __"Becopay"__ as an option at the top of the screen. Click on it to configure the payment gateway.

__*You can select the radio button next to Becopay from the list of payment gateways available to make it the default gateway.*__

* __Enable/Disable__ - check the box to enable Becopay Payment Gateway.
* __Title__ - allows you to determine what your customers will see this payment option as on the checkout page.
* __Description__ - controls the message that appears under the payment fields on the checkout page. Here you can list the types of cards you accept.
* __Mobile Number__  - enter the phone number you registered in the Becopay here.If you don't have Becopay merchat account register [here](https://becopay.com/en/merchant-register/).
* __Becopay Api Base Url__  - enter Becopay api base url here. If you don't have Becopay merchat account register [here](https://becopay.com/en/merchant-register/).
* __Becopay Api Key__  - enter your Becopay Api Key here. If you don't have Becopay merchat account register [here](https://becopay.com/en/merchant-register/).
* Click on __Save Changes__ for the changes you made to be effected.

__Note:__<br>
The format of your callback link is in this format <br>
`https://your-site/wc-api/BecopayGateway/?orderId=ORDER_ID`

## FAQ

### Where is the database?

Wordpress cannot run with a database. This image is for Wordpress only. It doesn't contain MySQL server. MySQL server should be started in another container and linked with Wordpress container. It's recommended to use Docker Compose to start both containers.

### Why getting access denied error after changing the default DB password?

If you change the default DB password in `env` file and get the access denied error when installing Wordpress.

## Becopay Support:

* [GitHub Issues](https://github.com/becopay/becopay-Woocommerce/issues)
  * Open an issue if you are having issues with this plugin
* [Support](https://becopay.com/en/support/#contact-us)
  * Becopay support

## Contribute

Would you like to help with this project?  Great!  You don't have to be a developer, either.  If you've found a bug or have an idea for an improvement, please open an [issue](https://github.com/becopay/becopay-Woocommerce/issues) and tell us about it.

If you *are* a developer wanting contribute an enhancement, bug fix or other patch to this project, please fork this repository and submit a pull request detailing your changes. We review all PRs!

This open source project is released under the [Apache 2.0 license](https://opensource.org/licenses/Apache-2.0) which means if you would like to use this project's code in your own project you are free to do so.  Speaking of, if you have used our code in a cool new project we would like to hear about it!  [Please send us an email](mailto:io@becopay.com).

## License

Please refer to the [LICENSE](https://opensource.org/licenses/Apache-2.0) file that came with this project.

