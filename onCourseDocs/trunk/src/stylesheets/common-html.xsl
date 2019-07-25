<?xml version='1.0'?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xslthl="http://xslthl.sf.net"
      xmlns:date="http://exslt.org/dates-and-times"
      xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
      exclude-result-prefixes="date xslthl l"
      version='1.0'>

  <xsl:import href="@rootDir@/build/xslt/docbook/html/chunk.xsl"/>
  <xsl:import href="@rootDir@/build/xslt/docbook/html/highlight.xsl"/>

  <xsl:include href="common-customizations.xsl"/>
    
  <xsl:param name="chunker.output.encoding">UTF-8</xsl:param>
  <xsl:output doctype-system="about:legacy-compat"/>

  <!-- Only chapters start a new page -->
  <xsl:param name="chunk.section.depth">0</xsl:param>

  <!-- Don't add any embedded styles -->
  <xsl:param name="css.decoration">0</xsl:param>
  
  <xsl:param name="ignore.image.scaling">1</xsl:param>

  <xsl:param name="use.id.as.filename">1</xsl:param>

  <xsl:template match="xslthl:string" mode="xslthl">
    <strong class="hl-string">
      <xsl:apply-templates mode="xslthl"/>
    </strong>
  </xsl:template>
  
  <xsl:template name="user.head.content">
    <meta name="viewport">
      <xsl:attribute name="content">width=device-width</xsl:attribute>
      <xsl:attribute name="initial-scale">1</xsl:attribute>
    </meta>
    <meta name="date">
      <xsl:attribute name="content">
        <xsl:call-template name="datetime.format">
          <xsl:with-param name="date" select="date:date-time()"/>
          <xsl:with-param name="format" select="'d B Y'"/>
        </xsl:call-template>
      </xsl:attribute>
    </meta>
    <link rel="canonical">
      <xsl:attribute name="href">
        <xsl:text>@canonicalLink@</xsl:text>
        <xsl:call-template name="href.target.uri">
          <xsl:with-param name="object" select="."/>
        </xsl:call-template>
      </xsl:attribute>
    </link>
    <xsl:copy-of select="document('@buildDir@/processed/js/analytics.js',/)"/>
    <script type="text/javascript" src="js/documentation.js"/>
    <script type="text/javascript" src="js/jquery.js"/>
    <link rel="stylesheet" type="text/css">
      <xsl:attribute name="href">
        <xsl:text>https://fonts.googleapis.com/css?family=Merriweather:300i,300,400|Port+Lligat+Slab</xsl:text>
      </xsl:attribute>
    </link>

  </xsl:template>

</xsl:stylesheet>
