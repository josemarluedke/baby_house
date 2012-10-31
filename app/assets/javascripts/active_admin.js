//= require active_admin/base
//= require tinymce
//= require tinymce-jquery



// WYSIWYG Editor
$(function () {
  tinymce.init({
    mode : "textareas",
    theme : "advanced",
    plugins : "autolink,lists,style,table,advimage,advlink,iespell,inlinepopups,contextmenu,paste",
    editor_selector: 'mceEditor',

    // Theme options
    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect,|,bullist,numlist,outdent,indent,|,link,unlink,image,|,table,pasteword,code",
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
