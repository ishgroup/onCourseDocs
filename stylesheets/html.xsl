<?xml version='1.0'?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xslthl="http://xslthl.sf.net"
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
    <meta name="date">
      <xsl:attribute name="content">
          <!--<xsl:value-of select="current-dateTime()"/>-->
          <!-- Not available in XSLT 1.0, but docbook only works in xslt 1.0 -->
      </xsl:attribute>
    </meta>
    <xsl:comment>[if lt IE 9]&gt;&lt;script src="js/html5shiv.js"&gt;&lt;/script>&lt;![endif]</xsl:comment>
  </xsl:template>

  <xsl:template match="xslthl:string" mode="xslthl">
    <strong class="hl-string">
        <xsl:apply-templates mode="xslthl"/>
    </strong>
  </xsl:template>

</xsl:stylesheet>
