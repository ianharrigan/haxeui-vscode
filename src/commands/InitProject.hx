package commands;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import vscode.ExtensionContext;

class InitProject
{
	var context : ExtensionContext;

	public function new (ctx)
	{
		context = ctx;
		Vscode.commands.registerCommand("haxeui.initproject", run);
	}

	/**
		Adapted from vshaxe code.
		https://github.com/vshaxe/vshaxe/blob/8eeff04f9adc3e8518ae47eab876ffd31f8c1182/src/vshaxe/InitProject.hx
	**/
	function run () : Void
	{
		var workspaceRoot = Vscode.workspace.rootPath;
		if (workspaceRoot == null)
		{
			Vscode.window.showErrorMessage("You must have a folder open to init a HaxeUI project");
			return;
		}

		var initSource = context.asAbsolutePath("./data/emptyProject/");

		if (copyRec(initSource, workspaceRoot, true))
		{
			Vscode.window.showErrorMessage("One or more files from the HaxeUI project would overwrite some of your files, so the project creation was stopped, for best result do this in an empty workspace");
		}
		else
		{
			copyRec(initSource, workspaceRoot);
			Vscode.window.showInformationMessage("HaxeUI project created");
		}
	}

	function copyRec (inPath:String, outPath:String, dryRun:Bool=false) : Bool
	{
		var overwrite = false;

		for (file in FileSystem.readDirectory(inPath))
		{
			var fileInPath = Path.join([ inPath, file ]);
			var fileOutPath = Path.join([ outPath, file ]);

			if (FileSystem.isDirectory(fileInPath))
			{
				FileSystem.createDirectory(fileOutPath);
				copyRec(fileInPath, fileOutPath);
			}
			else
			{
				overwrite = overwrite || FileSystem.exists(fileOutPath);

				if (!dryRun)
				{
					File.copy(fileInPath, fileOutPath);
				}
			}
		}

		return overwrite;
	}
}
