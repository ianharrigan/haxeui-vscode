package commands;

import haxe.Template;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import sys.io.File;
import vscode.ExtensionContext;

class Show
{
	var context : ExtensionContext;

	public function new (ctx)
	{
		context = ctx;
		Vscode.commands.registerCommand("haxeui.show", run);
	}

	function run () : Void
	{
		if (Vscode.window.activeTextEditor != null)
		{
			var doc = Vscode.window.activeTextEditor.document;
			var previewUri = doc.uri.with({ scheme: "haxeui", path: doc.uri.path + ".rendered", query: doc.uri.toString() });

			Vscode.workspace.registerTextDocumentContentProvider("haxeui", { provideTextDocumentContent: provide });
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
				return makeHtmlPage(doc.getText());
			}
		}

		return 'Error: couldn\'t find document for uri "$uri"';
	}

	function makeHtmlPage (data:String) : String
	{
		var html = File.getContent(context.asAbsolutePath("./data/preview.tpl.html"));
		var previewScript = File.getContent(context.asAbsolutePath("./bin/preview.js"));

		var template = new Template(html);
		return template.execute({ previewScript: previewScript, data: Base64.encode(Bytes.ofString(data)) });
	}
}
