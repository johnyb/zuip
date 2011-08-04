$(function() {
  var click_target; // HACK: somehow evt.cancelBubble = true isn’t propagated in function select(evt)
  function resetSelection(evt){
    if (click_target) {
      click_target = null;
      return;
    }
    rect = document.getElementById("selectionBB");
    rect.setAttributeNS(null,"style","visibility:hidden; pointer-events : none;");

    $('form div#assets_fields > textarea').hide();
  }
  function select(evt){
    click_target=evt.target;
    group = findParentWithClass(evt.target,"content");

    rect = document.getElementById("selectionBB");
    rect.setAttributeNS(null,"style","visibility:visible; pointer-events : all;");
    rect.setAttributeNS(null,"x",group.getBBox().x);
    rect.setAttributeNS(null,"y",group.getBBox().y);
    rect.setAttributeNS(null,"width",group.getBBox().width);
    rect.setAttributeNS(null,"height",group.getBBox().height);
    rect.setAttributeNS(null, "class", "selectionBB");
    rect.setAttributeNS(null, "transform", group.getAttributeNS(null, "transform"));

    evt.cancelBubble = true;
  }
  function findParentWithClass(node, cssClass){
    result = node;
    while (result && result.getAttributeNS(null,"class") != cssClass) {
      result = result.parentNode;
    }
    return result;
  }
  function show_edit_textarea(evt){
    group = findParentWithClass(evt.target,"content");
    $('form div#assets_fields > textarea').hide();

    $('form div#assets_fields > textarea').each(function(i,elem) {
      if (elem.value.indexOf("id=\"" + group.id + '"') > 0) {
        $("#"+elem.id).show();
      }
    });
    evt.cancelBubble = true;
  }

  $("#svgcanvas > svg").find("#content").click(select);
  $("#svgcanvas > svg").find("#content").click(show_edit_textarea);
  $("#svgcanvas > svg").click(resetSelection);
  $("#svgcanvas > svg").svg();
  var svg = $('#svgcanvas > svg').svg('get');
  var selBB = svg.rect(0,0,200,200,0,0,{ id : 'selectionBB', class : 'selectionBB'});
});
