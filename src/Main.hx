import vscode.ExtensionContext;

using StringTools;

class Main
{
	var context : ExtensionContext;

	public function new (ctx)
	{
		context = ctx;
		Vscode.commands.registerCommand("haxeui-preview.show", show);
	}

	function show ()
	{
		if (Vscode.window.activeTextEditor != null)
		{
			var doc = Vscode.window.activeTextEditor.document;
			var previewUri = doc.uri.with({ scheme: "haxeui-preview", path: doc.uri.path + ".rendered", query: doc.uri.toString() });

			Vscode.workspace.registerTextDocumentContentProvider("haxeui-preview", { provideTextDocumentContent: provide });
			Vscode.commands.executeCommand("vscode.previewHtml", previewUri, vscode.ViewColumn.Two, 'HaxeUI preview "${doc.uri.toString()}"');

			//TODO: add preview update on document save
		}
	}

	function provide (uri, token) : String
	{
		for (doc in Vscode.workspace.textDocuments)
		{
			if (uri.path == doc.uri.path + ".rendered")
			{
				var xml = doc.getText().replace("\n", "");

				return makeHtmlPage(xml);
			}
		}

		return 'Error: couldn\'t find document for uri "$uri"';
	}

	function makeHtmlPage (data:String) : String
	{
		var previewScript = CompileTime.readFile("bin/preview.js");
		data = data.replace("\"", "\\\""); //TODO: better sanitizing

		return '<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8"/>
		<title>HaxeUI preview</title>
		<meta name="description" content="" />

		<style>
			* {
				box-sizing: border-box;
			}

			html {
				margin: 0;
				width: 100%;
				height: 100%;
			}

			body {
				font-family: "Arial";
				font-size: 13px;
				margin: 0;
				width: 100%;
				height: 100%;
			}
		</style>
	</head>
	<body>
		<script>
			var PreviewUtils = {};
			PreviewUtils.getData = function () {
				return "${data}";
			};
		</script>
		<script>
			${previewScript}
		</script>
	</body>
</html>';
	}

	@:keep
	@:expose("activate")
	public static function main (context:ExtensionContext)
	{
		new Main(context);
	}
}
