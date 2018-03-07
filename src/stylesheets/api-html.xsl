<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
                exclude-result-prefixes="date xslthl l"
                version='1.0'>

    
    <xsl:param name="html.stylesheet">css/ish.css css/api-ish.css</xsl:param>
    <xsl:param name="toc.section.depth">0</xsl:param>
    <xsl:param name="toc.max.depth">2</xsl:param>
    
    <!-- disable numbering -->
    <xsl:param name="part.autolabel">0</xsl:param>
    <xsl:param name="chapter.autolabel">0</xsl:param>
    <xsl:param name="section.autolabel">0</xsl:param>
    
    <xsl:include href="common-html.xsl"/>

    <!-- The component.toc (really the chapter) should display all its sibliings as well as children -->
    <xsl:template name="component.toc">
        <xsl:param name="toc-context" select="."/>
        <xsl:param name="toc.title.p" select="true()"/>
        <xsl:for-each select="ancestor::book">
            <xsl:call-template name="division.toc">
                <xsl:with-param name="toc-context" select="$toc-context"/>
                <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <!-- don't export sections in the TOC -->
    <xsl:template match="preface|chapter|appendix|article" mode="toc">
        <xsl:param name="toc-context" select="."/>
            <xsl:call-template name="subtoc">
                <xsl:with-param name="toc-context" select="$toc-context"/>
                <xsl:with-param name="nodes" select="no-such-node"/>
            </xsl:call-template>
    </xsl:template>
    
</xsl:stylesheet>
