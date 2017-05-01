import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;
import haxe.ui.core.Component;

extern class PreviewUtils
{
	public static function getData () : String;
}

class PreviewApp
{
	public static function main () : Void
	{
		Toolkit.init();

		var app = new HaxeUIApp();

		//TODO: error support if invalid data
		app.ready(onReady.bind(app));
	}

	static function onReady (app:HaxeUIApp) : Void
	{
		var main:Component = Toolkit.componentFromString(PreviewUtils.getData());
		app.addComponent(main);
		app.start();
	}
}
