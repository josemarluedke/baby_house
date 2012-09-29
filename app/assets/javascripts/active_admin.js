//= require active_admin/base
//= require tinymce
//= require tinymce-jquery



// WYSIWYG Editor
$(function () {
  tinymce.init({
    mode : "textareas",
    theme : "advanced",
    plugins : "autolink,lists,style,table,save,advhr,advimage,advlink,iespell,inlinepopups,media,searchreplace,contextmenu,paste,fullscreen,xhtmlxtras",
    editor_selector: 'mceEditor',

    // Theme options
    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,|,forecolor,backcolor",
    theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,iespell,media,advhr,,ltr,rtl,|,fullscreen",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_statusbar_location : "bottom",
    theme_advanced_resizing : true,

    // Skin options
    skin : "o2k7",
    skin_variant : "silver",

    // Drop lists for link/image/media/template dialogs
    template_external_list_url : "js/template_list.js",
    external_link_list_url : "js/link_list.js",
    external_image_list_url : "js/image_list.js",
    media_external_list_url : "js/media_list.js",
  });
});
