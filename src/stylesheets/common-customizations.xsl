<?xml version='1.0'?>
<!-- These are common to both PDF and html for all different manuals -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xslthl="http://xslthl.sf.net"
      xmlns:date="http://exslt.org/dates-and-times"
      xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
      exclude-result-prefixes="date xslthl l"
      version='1.0'>

  <xsl:param name="highlight.source">"1"</xsl:param>
  <xsl:param name="keep.relative.image.uris" select="1"/>
  
  <!-- enable TOC for book and chapter but not part -->
  <xsl:param name="generate.toc">
    book      toc,title,figure,table,example,equation
    chapter   toc,title
    part      nop
    section   nop
  </xsl:param>
  
  <!-- The following line points the local.l10n.xml to this document
  This is how we can edit anything in build/xslt/docbook/common/en.xml -->
  <xsl:param name="local.l10n.xml" select="document('')" />
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en">
      <l:gentext key="TableofContents" text="Contents"/>

      <!-- Remove the word "Chapter" -->
      <l:context name="title-numbered"> 
        <l:template name="chapter" text="%t"/> 
      </l:context>
    </l:l10n>
  </l:i18n>

</xsl:stylesheet>
