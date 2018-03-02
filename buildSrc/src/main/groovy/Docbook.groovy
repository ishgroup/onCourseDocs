import com.icl.saxon.TransformerFactoryImpl
import org.apache.xerces.jaxp.SAXParserFactoryImpl
import org.gradle.api.DefaultTask
import org.gradle.api.logging.LogLevel
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.InputFile
import org.gradle.api.tasks.OutputFile
import org.gradle.api.tasks.TaskAction
import org.xml.sax.InputSource
import org.xml.sax.XMLReader

import javax.xml.parsers.SAXParserFactory
import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.TransformerFactory
import javax.xml.transform.sax.SAXSource
import javax.xml.transform.stream.StreamResult
import javax.xml.transform.stream.StreamSource

class Docbook extends DefaultTask {
    @InputDirectory
    File sourceDirectory

    @InputFile
    File stylesheet

    @OutputFile
    File outputFile

    //@TaskAction
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
        System.setProperty('javax.xml.transform.TransformerFactory', 'org.apache.xalan.processor.TransformerFactoryImpl')
        System.setProperty('javax.xml.parsers.SAXParserFactory', 'org.apache.xerces.jaxp.SAXParserFactoryImpl')

        def factory = SAXParserFactory.newInstance()
        factory.setXIncludeAware(true)
        XMLReader reader = factory.newSAXParser().getXMLReader()

        File srcFile = new File(sourceDirectory, "index.xml")
        InputSource inputSource = new InputSource(srcFile.getAbsolutePath())

        outputFile.parentFile.mkdirs()
        Result result = new StreamResult(outputFile.getAbsolutePath())

        URL url = stylesheet.toURI().toURL()
        Source source = new StreamSource(url.openStream(), url.toExternalForm())

        def transformer = TransformerFactory.newInstance().newTransformer(source)

        String rootFilename = outputFile.name
        rootFilename = rootFilename.substring(0, rootFilename.lastIndexOf('.'))
        transformer.setParameter("root.filename", rootFilename)
        transformer.setParameter("base.dir", outputFile.parent + File.separator)
        transformer.setParameter('highlight.xslthl.config', "file://${project.rootDir}/stylesheets/xslthl-config.xml" )

        transformer.transform(new SAXSource(reader, inputSource), result)
    }


    @TaskAction
    def transform() {
        // the docbook tasks issue spurious content to the console. redirect to INFO level
        // so it doesn't show up in the default log level of LIFECYCLE unless the user has
        // run gradle with '-d' or '-i' switches -- in that case show them everything
        switch (project.gradle.startParameter.logLevel) {
            case LogLevel.DEBUG:
            case LogLevel.INFO:
                break;
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

        outputFile.getParentFile().mkdirs();
        Result result = new StreamResult(outputFile.getAbsolutePath())

        URL url = stylesheet.toURI().toURL();
        Source source = new StreamSource(url.openStream(), url.toExternalForm())
        def transformer = transformerFactory.newTransformer(source);

        String rootFilename = outputFile.getName()
        rootFilename = rootFilename.substring(0, rootFilename.lastIndexOf('.'))
        transformer.setParameter("root.filename", rootFilename)
        transformer.setParameter("base.dir", outputFile.getParent() + File.separator)
        transformer.setParameter('highlight.xslthl.config', 'file://' + project.getBuildDir().getAbsolutePath() + '/stylesheets/xslthl-config.xml' )

        transformer.transform(new SAXSource(reader, inputSource), result)
    }
}