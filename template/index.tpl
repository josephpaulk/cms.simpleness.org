<!DOCTYPE html>
<html lang="en-US" [% IF language.search('il|fa|ar') %] dir="rtl" [% END %]>
    <head>
        <title>[% title %]</title>
        <meta charset="utf-8" />
        <meta name="description" content="[% meta.description %]" />
        <meta name="keywords" content="[% meta.keywords %]" />
        <meta name="category" content="[% meta.category %]" />
        <link rel="stylesheet" href="/css/mobile.css" media="screen and (max-width: 600px)" />
        <link rel="stylesheet" href="/css/style.css" media="screen and (min-width: 600px)" />
        <link rel="stylesheet" href="/css/print.css" media="print" />
        <link rel="stylesheet" href="/css/default.css" />
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
[% PROCESS js/variables.tpl %]
        <script src="/js/default.js"></script>
[% IF access.edit_content %]
        <link rel="stylesheet" href="/css/default_admin.css" />
        <script src="/js/default_admin.js"></script>
        <script src="/js/nicEdit.js"></script>
[% END %]
    </head>
    <body>
[% PROCESS panel_edit.tpl %]
<!-- Shell -->
    <div id="shell">
	<!-- Header -->
	    <div id="header" class="big-box">
		<div class="bg-bottom">

[% PROCESS editable.tpl name='?_header'; %]

                    <div class="bg-bottom-right">
                        <select name="languages" id="languages"></select>
                    </div>
		    <div class="cl">&nbsp;</div>
		</div>
	    </div>
	<!-- /Header -->
	<!-- Navigation -->
	<nav id="navigation">
	    <menu>
		<ul class="dropdown dropdown-horizontal">
[% BLOCK main_menu     %]
[%   FOREACH m IN menu %]
[%     NEXT IF m.menu_parent != level %]
        <li><a href="[% m.menu_url %]" [% 'class="active"' IF env('REDIRECT_URL') == m.menu_url %]><span>[% m.menu_name %]</span></a>
            <ul>[% INCLUDE main_menu level = m.menu_key %]</ul>
        </li>
[%     END %]
[%   END   %]
[% INCLUDE main_menu level = 0 %]

[% IF session('slogin') %]
	<li><a href="/admin" [% 'class="active"' IF env('REDIRECT_URL') == '/admin' %]><span>[% t('Admin page') %]</span></a></li>
	<li><a href="/login/exit"><span>[% t('exit') %]</span></a></li>
[%   IF access.edit_menu %]
        <li><a href="/admin/menu"><i class="icon-tasks"></i></a></li>
[%   END %]
[% ELSE %]
	<li><a href="/login" [% 'class="active"' IF env('REDIRECT_URL') == '/login' %]><span>[% t('login') %]</span></a></li>
	<li><a href="/login/register" [% 'class="active"' IF env('REDIRECT_URL') == '/login/register' %]><span>[% t('Register') %]</span></a></li>
[% END %]
		</ul>
		<div class="cl">&nbsp;</div>
	    </menu>
	</nav>
	<!-- /Navigation -->
	<!-- Main -->
	<div id="main" class="big-box">
	    <div class="bg-top">
	        <div class="bg-bottom">

[% IF access.print_page %]
                    <span id="print_button"><a href="#" onclick="print();return false;"><i class="icon-print"></i></a></span>
[% END %]

[% UNLESS read_only;
     PROCESS editable.tpl 
        name=env('REDIRECT_URL') 
        value=(access.edit_content)? content_edit : content;
   END %]

[% body %]

[% IF access.view_addthis; PROCESS panel_addThis.tpl; END %]
		</div>
	    </div>
	</div>
	<!-- /Main -->
	<!-- Footer -->
	<footer>
[% PROCESS editable.tpl name='?_bottom'; %]
            <p>
	        Created by <a href="http://ivanoff.org.ua" target="_blank">ivanoff</a> / 
	        Powered by <a href="http://cms.simpleness.org" target="_blank">Simpleness CMS</a>
	        <a href="/login"><img src="/images/btn_key.png" class="admin_key" border="0"></a>
            </p>
	</footer>
	<!-- /Footer -->
    </div>
<!-- /Shell -->
</body>
</html>