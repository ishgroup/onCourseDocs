import org.gradle.api.GradleException
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.api.Task

public class JiraPlugin implements Plugin<Project> {
	Project project

    def void apply(Project project) {
        this.project = project

        JiraPluginExtension extension = project.getExtensions().create("jira", JiraPluginExtension.class, this)

        Task releaseNotes = project.task('jira') {

        }
        releaseNotes.description = "Jira release notes"
	}

}