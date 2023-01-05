# hestiacp-pluginable
Extend Hestia Control Panel via simple, WordPress-like plugins API.

### Installation
Simply download and unpack the source code files and move the hooks folder to /etc/hestiacp/hooks:

```
cd /tmp
wget https://github.com/Steveorevo/hestiacp-pluginable/archive/refs/heads/main.zip
unzip main.zip
sudo mv hestiacp-pluginable-main,/hooks /etc/hestiacp
```

Run the post_install.sh script. This will automatically be run anytime HestiaCP updates itself. Currently, this project is compatible with HestiaCP v1.6.14.

```
sudo /etc/hestiacp/hooks/post_install.sh
```

### Creating a plugin
Plugins live in a folder of their own name within `/usr/local/hestia/plugins` and must contain a file called plugin.php. For instance, an example plugin would be at:

```
/usr/local/hestia/plugins/example
```
and contain the file plugin.php at:
```
/usr/local/hestia/plugins/example/plugin.php
```

A plugin can hook and respond to actions that HestiaCP invokes whenever an API call or web page control panel is viewed. A simple hook that can intercept whenever the API call v-list-users is invoked, either by the REST API or website control panel would look like:

```
<?php
/**
 * A sample plugin for hestiacp-pluginhooks 
 */

add_action( 'list-users', function( $args ) {
    file_put_contents( '/tmp/hestia.log', "intercepted in test-plugin\n" . json_encode( $args, JSON_PRETTY_PRINT ) . "\n", FILE_APPEND );
    return $args;
});
```

It is important that an add_action hook returns (passes along) the incomming arguments ( the `$args` parameter above).

The above sample plugin will write the response to `/tmp/hestia.log`. Note that the old "v-" prefix (that was used to denote the original VestaCP project that HestiaCP was derived from), is not needed to hook the action with the `add_action` function. You can view all the possible hook names that the hestiacp-pluginable API can respond to by uncommenting line 43 in pluginable.php:

```
file_put_contents( '/tmp/hestia.log', "add_action " . $tag . " " . substr(json_encode( $args ), 0, 50) . "...\n", FILE_APPEND );
```

This will cause all possible hooks to be logged with a sample of the arguments in the log file at:
`/tmp/hestia.log`. Be sure to re-run the post_install.sh script if you modify the pluginable.php file; as described at the top of this document in the installation section. 
