<h1>[% t('Menu') %]</h1>

<link href="/css/sort.css" rel="stylesheet">
<link href="/css/icon.css" rel="stylesheet">

<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script src="/js/sort.js"></script>

<script>

    $(function  () {
        $('ol.default').sortable( {
            group: 'no-drop',
            handle: 'i.icon-move',

  onDragStart: function (item, container, _super) {
    // Duplicate items of the no drop area
    if(!container.options.drop)
      item.clone().insertAfter(item)
    _super(item)
  },
            stop: function () {

                var arr = [];
                var keys = [];
                var result = '';

                function a ( t ) {
                    t.find('li').each( function() {
                        if( !arr[$(this).attr('id')] ) {
                            keys.push( $(this).attr('id') );
                            arr[$(this).attr('id')] = t.attr('id');
                        }
                        if( $(this).find('ol') ) a( $(this) );
                    });
                };

                a( $('#menu') );

                for (var i = 0; i < keys.length; i++) {
                    if (arr.hasOwnProperty(keys[i]))
                        result = result + keys[i] + ':' + arr[keys[i]] +';';
                }

                $.ajax({
                    type: "GET",
                    url: '/admin/menu/sort/'+result,
                });

            }
        } );
    });

    function add_new_menu() {
        $.ajax({
            type: "GET",
            url: '/admin/menu/add/'+$("#new_menu").val(),
            data: ({ issession : 123 }),
            dataType: "xml",
//            async: false,
            success: function(xml) {
                data = '<li id="' + $(xml).find("id").text() + '">';

                data += '<i class="icon-move"></i> ';
                data += '<i class="icon-trash" onclick="delete_menu(this);return(false);"></i> ';
                data += '<span id="menu/[% m.menu_key %]:body" class="editable"> ';
                data += '<a href="' + $(xml).find("url").text() + '">';
                data += $(xml).find("name").text() + '</a> ';
                data += '</span> ';
                data += '<ol></ol></li>';
                $("#menu").append( data );
                $("#new_menu").val('');

                myNicEditor.addInstance('menu/[% m.menu_key %]:body'); 
            },
        });
    }

    function delete_menu(a) {
        $(a).closest('li').fadeTo('slow', 0.5);
        $.ajax({
            type: "GET",
            url: '/admin/menu/delete/'+$(a).closest('li').attr('id'),
            dataType: "xml",
//            async: false,
            success: function(data) {
                $(a).closest('li').remove();
            },
        });
    }

</script>

    <ol class="default vertical" id="menu">
[% INCLUDE 'admin/menu/item.tpl' level=0 %]
    </ol>

<input type="text" name="new_menu" value="" id="new_menu" placeholder="enter new menu name">
<input type="button" value="add menu" onclick="add_new_menu();">
 