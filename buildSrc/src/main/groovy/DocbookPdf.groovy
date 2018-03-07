import org.apache.fop.apps.FopFactory
import org.apache.fop.apps.MimeConstants
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.InputFile
import org.gradle.api.tasks.OutputFile
import org.gradle.api.tasks.TaskAction

import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.Transformer
import javax.xml.transform.TransformerFactory
import javax.xml.transform.sax.SAXResult
import javax.xml.transform.stream.StreamSource
import org.apache.fop.apps.FopConfParser
import org.apache.fop.apps.Fop

class DocbookPdf extends DefaultTask {
    DocbookPdf() {
        group = "documentation"
    }
    @InputFile
    File foFile

    @InputFile
    File fopConfFile

    @InputDirectory
    File sourceDirectory

    @OutputFile
    File outputFile

    @TaskAction
    def run() {
        FopFactory fopFactory = new FopConfParser(fopConfFile,sourceDirectory.toURI()).getFopFactoryBuilder().build()
        OutputStream out = new BufferedOutputStream(new FileOutputStream(outputFile))

        try {
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out)

            TransformerFactory factory = TransformerFactory.newInstance()
            Transformer transformer = factory.newTransformer()
            transformer.setParameter('highlight.xslthl.config', "file://${sourceDirectory}/stylesheets/xslthl-config.xml" )

            Source src = new StreamSource(foFile)
            Result res = new SAXResult(fop.getDefaultHandler())

            transformer.transform(src, res)

        } finally {
            out.close()
        }
    }
}