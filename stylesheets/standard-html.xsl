<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
                exclude-result-prefixes="date xslthl l"
                version='1.0'>

    <xsl:param name="html.stylesheet">css/ish.css</xsl:param>
    <xsl:param name="toc.section.depth">2</xsl:param>
    
    <xsl:include href="common-html.xsl"/>

</xsl:stylesheet>
