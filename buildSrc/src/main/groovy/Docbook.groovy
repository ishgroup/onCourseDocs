import com.icl.saxon.TransformerFactoryImpl
import org.apache.xerces.jaxp.SAXParserFactoryImpl
import org.gradle.api.DefaultTask
import org.gradle.api.logging.LogLevel
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.InputFile
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.Optional
import org.gradle.api.tasks.TaskAction
import org.xml.sax.InputSource
import org.xml.sax.XMLReader

import javax.xml.parsers.SAXParserFactory
import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.sax.SAXSource
import javax.xml.transform.stream.StreamResult
import javax.xml.transform.stream.StreamSource

class Docbook extends DefaultTask {
    Docbook() {
        group = "documentation"
    }
    @Input @Optional
    String type = "html"

    @InputDirectory
    File sourceDirectory

    @InputDirectory @Optional
    File sourceJs

    @InputDirectory @Optional
    File sourceImages

    @InputDirectory @Optional
    File sourceCss

    @InputFile
    File stylesheet

    @OutputDirectory
    File outputDirectory

    @TaskAction
    def run() {
        // the docbook tasks issue spurious content to the console. redirect to INFO level
        // so it doesn't show up in the default log level of LIFECYCLE unless the user has
        // run gradle with '-d' or '-i' switches -- in that case show them everything
        switch (project.gradle.startParameter.logLevel) {
            case LogLevel.DEBUG:
            case LogLevel.INFO:
                break
            default:
                logging.captureStandardOutput(LogLevel.INFO)
                logging.captureStandardError(LogLevel.INFO)
        }

        SAXParserFactory factory = new SAXParserFactoryImpl()
        factory.setXIncludeAware(true)
        XMLReader reader = factory.newSAXParser().getXMLReader()
        def transformerFactory = new TransformerFactoryImpl()

        File srcFile = new File(sourceDirectory, "index.xml")
        InputSource inputSource = new InputSource(srcFile.getAbsolutePath())

        outputDirectory.mkdirs()
        Result result = new StreamResult("${outputDirectory}/index.${type}")

        URL url = stylesheet.toURI().toURL()
        Source source = new StreamSource(url.openStream(), url.toExternalForm())
        def transformer = transformerFactory.newTransformer(source)

        transformer.setParameter("root.filename", 'index')
        transformer.setParameter("base.dir", "${outputDirectory}")
        transformer.setParameter('highlight.xslthl.config', "file://${sourceDirectory}/stylesheets/xslthl-config.xml")

        transformer.transform(new SAXSource(reader, inputSource), result)

        if (sourceImages) {
            project.copy {
                into "${outputDirectory}/images"
                from sourceImages
            }
        }

        if (sourceCss) {
            project.copy {
                into "${outputDirectory}/css"
                from sourceCss
            }
        }

        if (sourceJs) {
            project.copy {
                into "${outputDirectory}/js"
                from sourceJs
            }
        }
    }
}