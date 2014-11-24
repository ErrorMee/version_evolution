package Editor.main.command
{
	import Editor.module.GridEditorModule.GridNavigationMediator;
	import Editor.module.GridEditorModule.GridNavigationView;
	import Editor.module.GridEditorModule.createPart.CreateMediator;
	import Editor.module.GridEditorModule.createPart.CreateView;
	import Editor.module.GridEditorModule.gridPart.CellMediator;
	import Editor.module.GridEditorModule.gridPart.CellView;
	import Editor.module.GridEditorModule.gridPart.WallMediator;
	import Editor.module.GridEditorModule.gridPart.WallView;
	import Editor.module.GridEditorModule.setPart.SetMediator;
	import Editor.module.GridEditorModule.setPart.SetView;
	
	import module.cmd.ModuleCommand;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitMediatorCommand extends ModuleCommand
	{
		public function InitMediatorCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			mediatorMap.mapView(GridNavigationView,GridNavigationMediator);
			mediatorMap.mapView(CreateView,CreateMediator);
			mediatorMap.mapView(CellView,CellMediator);
			mediatorMap.mapView(WallView,WallMediator);
			mediatorMap.mapView(SetView,SetMediator);
		}
	}
}