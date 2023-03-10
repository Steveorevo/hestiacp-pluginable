#!/bin/php
<?php
/**
 * Invoke any plugins that wish to intercept pre_install hook.
 *
 * @version 1.0.0
 * @license GPL-3.0
 * @link https://github.com/steveorevo/hestiacp-pluginable
 * 
 */

require_once( '/usr/local/hestia/web/pluginable.php' );
$hcpp->do_action( 'pre_install' );
