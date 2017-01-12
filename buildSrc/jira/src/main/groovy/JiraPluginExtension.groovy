import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.InputFile

public class JiraPluginExtension {

	JiraPlugin plugin

	@InputFile
	File cayenneMap

	
	public JiraPluginExtension(JiraPlugin plugin) {
		this.plugin = plugin
	}



}