<?xml version='1.0'?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xslthl="http://xslthl.sf.net"
      xmlns:date="http://exslt.org/dates-and-times"
      exclude-result-prefixes="date xslthl"
      version='1.0'>

  <xsl:import href="../build/xslt/docbook/html/chunk.xsl"/>
  <xsl:import href="../build/xslt/docbook/html/highlight.xsl"/>

  <xsl:include href="common-customizations.xsl"/>


  <xsl:param name="html.stylesheet" select="'css/ish.css'"/>
  <xsl:param name="chunker.output.encoding">UTF-8</xsl:param>
  <xsl:output doctype-system="about:legacy-compat"/>

  <!-- Only chapters start a new page -->
  <xsl:param name="chunk.section.depth">0</xsl:param>

  <!-- Don't add any embedded styles -->
  <xsl:param name="css.decoration">0</xsl:param>
  
  <xsl:param name="ignore.image.scaling">1</xsl:param>

  <xsl:param name="use.id.as.filename">1</xsl:param>

  <xsl:template name="user.head.content">
    <xsl:comment>[if lt IE 9]&gt;&lt;script src="js/html5shiv.js"&gt;&lt;/script>&lt;![endif]</xsl:comment>
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
        <xsl:text>https://www.ish.com.au/s/onCourse/doc/latest/manual/</xsl:text>
        <xsl:call-template name="href.target.uri">
          <xsl:with-param name="object" select="."/>
        </xsl:call-template>
      </xsl:attribute>
    </link>
  </xsl:template>

  <xsl:template match="xslthl:string" mode="xslthl">
    <strong class="hl-string">
        <xsl:apply-templates mode="xslthl"/>
    </strong>
  </xsl:template>

</xsl:stylesheet>
