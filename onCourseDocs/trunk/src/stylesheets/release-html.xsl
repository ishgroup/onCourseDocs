<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xslthl="http://xslthl.sf.net"
				xmlns:date="http://exslt.org/dates-and-times"
				xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
				exclude-result-prefixes="date xslthl l"
				version='1.0'>

	<xsl:import href="@rootDir@/build/xslt/docbook/javahelp/javahelp.xsl"/>
	<xsl:import href="@rootDir@/build/xslt/docbook/html/highlight.xsl"/>

	<xsl:param name="highlight.source">"1"</xsl:param>
	<xsl:param name="keep.relative.image.uris" select="1"/>

	<xsl:param name="toc.max.depth">2</xsl:param>
	<!-- enable TOC for book and chapter but not part -->
	<xsl:param name="generate.toc">
		book      toc,title
		part      toc,title
	</xsl:param>
	<xsl:param name="chapter.autolabel">0</xsl:param>
  
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

	<xsl:param name="html.stylesheet">css/ish.css css/release-ish.css</xsl:param>

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
		<meta name="date">
			<xsl:attribute name="content">
				<xsl:call-template name="datetime.format">
					<xsl:with-param name="date" select="date:date-time()"/>
					<xsl:with-param name="format" select="'d B Y'"/>
				</xsl:call-template>
			</xsl:attribute>
		</meta>
		<xsl:copy-of select="document('@buildDir@/processed/js/analytics.js',/)"/>
	</xsl:template>


	<!-- Add the publication date on the TOC page -->
	<xsl:template name="toc.line">
		<xsl:param name="toc-context" select="."/>
		<xsl:param name="depth" select="1"/>
		<xsl:param name="depth.from.context" select="8"/>
		
		<span>
			<xsl:attribute name="class"><xsl:value-of select="local-name(.)"/></xsl:attribute>
				
			<a>
				<xsl:attribute name="href">
					<xsl:call-template name="href.target">
						<xsl:with-param name="context" select="$toc-context"/>
						<xsl:with-param name="toc-context" select="$toc-context"/>
					</xsl:call-template>
				</xsl:attribute>

				<xsl:apply-templates select="." mode="titleabbrev.markup"/>

			</a>
		</span>
		<span>
			<xsl:attribute name="class">releaseDate</xsl:attribute>
			<xsl:value-of select="chapterinfo/pubdate"/>
		</span>
	</xsl:template>


</xsl:stylesheet>
