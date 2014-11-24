//author cory

fl.outputPanel.clear();

var dom=fl.getDocumentDOM();

var lib=dom.library;

var itemArray = lib.items;

for(var i=0;i<itemArray.length;i++)
{
	var item = itemArray[i];
	if(item.linkageExportForAS)
	{
		handleItem(item);
	}
}

function handleItem(item)
{
	fl.trace("select item " + item.name);
	lib.selectItem(item.name);
	lib.editItem();
	dom.selectAll();

	var selects=dom.selection;
	for(var j=0;j<selects.length;j++){
		var element = selects[j];
		handleElement(element);
	}
}

function handleElement(element)
{
	element.x = Math.round(element.x);
	element.y = Math.round(element.y);

	if(element.elementType == "text")
	{
		element.setTextAttr('face', 'SimHei');//STXihei SimHei
		fl.trace("   element " + element.name + " face " + element.getTextAttr('face'));
	}

	if(element.elementType == "instance")
	{
		var elementLib = element.libraryItem;
		handleItem(elementLib);
	}
}

dom.exitEditMode();
dom.save();
dom.publish();

//fl.closeDocument(dom,true);