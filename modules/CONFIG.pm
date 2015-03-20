package CONFIG;

use strict;
use warnings;
use Exporter;

our ( @ISA, @EXPORT );
@ISA = qw( Exporter );
@EXPORT = qw( $CONFIG $CONFIG_TEMPLATE $CONFIG_IMAGES );

our $CONFIG = { 

        site               => 'admin.clear',
        email              => '2@ivanoff.org.ua',

        modules_extension  => 'hash',
        modules_path       => '../modules',
        config_files_path  => '../modules/admin/config',

# DATABASE
        db_type            => 'mysql',          # mysql or Pg
        db_host            => 'localhost',
        db_dbname          => 'clear',
        db_user            => 'clear',
        db_password        => 'clear',

# SESSIONS
        session_dir        => '../tmp/session', # path to store sesions
        session_expires    => 60*60*3,          # session expires ( in seconds )

# CACHE
        cache              => 0,                # 0 - don't cache pages, 1 - do cache pages
        cache_dir          => '../tmp/cache',   # path to store cache
        cache_time         => 60*60*24*31,      # cache expire time (in seconds )

# LANGUAGE
        default_language   => 'ru',
        languages          => [ qw( ru ) ],

        languages_t        => { en=>'english language', ru=>'русский язык', ua=>'українська мова', },
        languages_dont_translate => {
#                     ru => '2@ivanoff.org.ua',
#                     ua => '', #default email
#                     en => '',
                    },
        phrases_dont_translate => [
                     'Simpleness CMS', 'cms.simpleness.org', 'simpleness.org',
                    ],

        languages_cache    => 1,
        languages_cache_path => '../modules/admin/config/lang/cache',

# ERROR CONFIG
        show_errors        => 1,
        log_error          => '../log/error.log',
        log_sql            => '../log/clear.sql',

# Automatically updates section
# frequency parameter regexp string 'YYYY-MM-DD;HH:MM:SS;DOW;DOY'
        update_automatically    => 1,
        update_log_file         => '../log/upgate.log',
        update_rules_file       => '../modules/admin/config/update.pl',
        update_rules_timeout    => 60*60*24,
        update_frequency_regexp => qr/;6;/,  #every friday

# DEMO
        demo_enabled    => 0,   # enable demo mode ( login: demo/demo )

# COMMENTS
        comments_enabled => 0,  # show comments

};

# Images section

our $CONFIG_IMAGES = {
        PATH    => 'images/gallery/',
        SIZE    => ['174x174', '640x480'],
};

# Template toolkit section

our $CONFIG_TEMPLATE = {
        INCLUDE_PATH    => '../template',  # or list ref
        POST_CHOMP      => 1,              # cleanup whitespace 
        PRE_PROCESS     => '',             # prefix each template
        EVAL_PERL       => 1,              # evaluate Perl code blocks
#        INTERPOLATE     => 1,             # expand "$var" in plain text
#        DEBUG           => 1,
        RECURSION       => 1,
        POST_CHOMP      => 1,
};

1;
