import vscode.ExtensionContext;

class Main
{
	var context : ExtensionContext;

	public function new (ctx)
	{
		context = ctx;

		// Setup commands
		new commands.Show(context);
		new commands.InitProject(context);
	}

	@:keep
	@:expose("activate")
	public static function main (context:ExtensionContext) : Void
	{
		new Main(context);
	}
}
