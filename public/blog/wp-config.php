<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'sharinl8_wor0585');

/** MySQL database username */
define('DB_USER', 'sharinl8_wor0585');

/** MySQL database password */
define('DB_PASSWORD', '8fUHQG1z');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY', 'dw//cD[Qu]sGu>u&hlCLq*]bVYB^{&miCE|tOgL-QDH/=H+kZw<coUoq;f>hNTV{WtgnPRe]AASd^&THmqV{$bc{{Ehk+Cr!Ee)$UAe^}p)nt/(h[sMo&f;HJ^-kZY{B');
define('SECURE_AUTH_KEY', 'EyEATylgOBK@G/e$XWtadH_;j{WIiGqeFdJSn^MXk]FVRKp@-scfV(tDKW(RBN<LY[FUCXsi^hch(dDcfNHh@QW>MH/mDc^PB*w(sG%qkGTRqp(&]>GbIbSrceIK^}iU');
define('LOGGED_IN_KEY', 'KMbUhHXwXz/sN!uZEZnpF{*NOfV[l(OH-&e^A/}DBUZ)AcqqsTRoOZ%b[W%+dxctjvoVNz?LWjD}dj]<^I/Q$QhE]D|)FjvOx@{$rc[-%BBF*FxwQwB]+?pjkdZDZW{S');
define('NONCE_KEY', 'IvgYgtmJ?XraTAe-&Jb@EIvtwXA=U/RJKUyudKjI$YmYEGnlDj(k_e_y-/mj(iGQCeHXv$P]GXqNUKTMWRB+K($}MCY}Erh{DdnUphiqw;usZrGs;L-c-;GzjkyfikTm');
define('AUTH_SALT', 'BM?Rzs=NC&</vUx]*Q/*B<cR|saSgu*zrVLNVoh>evZMo>p_XPZsda|Tr<=<*v%Gt^!]]@MMctjqL?VIvU*u*cN>[tv<[v=qC*iX_h|grsG[W@=hwlElev<$=F@GneWi');
define('SECURE_AUTH_SALT', 'D^Rrfj*QMdfpJ=XfoxA$bAyObz[}xUqrRwCnTu)I;pH{p@noVI@hIc>v{dRB>Q^ADDrH*L}BAcE[HBDUQ|eU_UsZ)^(dk]pf=x@@PCYubA+VcBIW/fJp$&]rV>&]Gx}D');
define('LOGGED_IN_SALT', 'p(lS?B}-k>(OP^Rvp%gL[%r(mk{mUogJxfNeSk/[*EvjbXIsM@JkYM]+MoSu+swFl^)WiGI;&LdMGLM]H?Qc&Hik()opT^T*yJ_PrV!sf[}}KGwCvGyH(G&as(;KMMGo');
define('NONCE_SALT', 'I?Ma-(QoYJBDB!FH!LT$SLkQcyoEn?AUx%GkEG)gy!cpg//drZ*S(D-KYwYTF|C&kX?JEpmIz(^csK)V>DCpqYHaWL+;zaz!AHAbAe|&vaVk@Xa*YQf%iTP){pRh^jEy');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_mnfj_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
