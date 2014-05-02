<?xml version='1.0'?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xslthl="http://xslthl.sf.net"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        exclude-result-prefixes="xslthl"
        version="1.0">

    <xsl:import href="../build/xslt/docbook/fo/docbook.xsl"/>
    <xsl:import href="../build/xslt/docbook/fo/highlight.xsl"/>

    <xsl:include href="common-customizations.xsl"/>

    <xsl:param name="paper.type">A4</xsl:param>

    <!-- don't indent the body text -->
    <xsl:param name="body.start.indent">0pt</xsl:param>

    <!-- print headers and footers mirrored so double sided printing works -->
    <xsl:param name="fop1.extensions" select="1"/>
    <xsl:param name="double.sided" select="1"/>

    <xsl:param name="admon.graphics" select="0"/>
    <xsl:param name="admon.graphics.extension">.png</xsl:param>
    <xsl:param name="admon.graphics.path">stylesheets/docbook-xsl-ns/images/</xsl:param>
    <xsl:param name="admon.textlabel" select="1"/>

    <xsl:param name="callout.graphics" select="1"/>
    <xsl:param name="callout.graphics.extension">.png</xsl:param>
    <xsl:param name="callout.graphics.path">stylesheets/docbook-xsl-ns/images/callouts/</xsl:param>

    <xsl:param name="footer.rule">0</xsl:param>

    <!-- Separation between glossary terms and descriptions when glossaries are presented using lists. -->
    <xsl:param name="glossterm.separation">2em</xsl:param>

    <!-- This parameter specifies the width reserved for glossary terms when a list presentation is used.  -->
    <xsl:param name="glossterm.width">10em</xsl:param>

    <!--  Specifies the longest term in variablelists. In variablelists, the listitem is indented to leave room for the term elements. The indent may be computed if it is not specified with a termlength attribute on the variablelist element. The computation counts characters in the term elements in the list to find the longest term. However, some terms are very long and would produce extreme indents. This parameter lets you set a maximum character count. Any terms longer than the maximum would line wrap. The default value is 24. The character counts are converted to physical widths by multiplying by 0.50em. There is some variability in how many characters fit in the space since some characters are wider than others. -->
    <xsl:param name="variablelist.max.termlength">18</xsl:param>

    <!-- Custom font settings - preferred truetype font -->
    <xsl:param name="title.font.family">CabinSketch,sans-serif</xsl:param>
    <xsl:param name="body.font.family">Times,serif</xsl:param>
    <xsl:param name="sans.font.family">Interstate,sans-serif</xsl:param>
    <xsl:param name="dingbat.font.family">Lucinda Grande,serif</xsl:param>
    <xsl:param name="monospace.font.family">monospace</xsl:param>

    <!-- Specify the default text alignment. The default text alignment is used for most body text. -->
    <xsl:param name="alignment">left</xsl:param>

    <!--  Specifies the default point size for body text. The body font size is specified in two parameters (body.font.master and body.font.size) so that math can be performed on the font size by XSLT. -->
    <xsl:param name="body.font.master">10</xsl:param>
    <xsl:param name="body.font.size">10</xsl:param>

    <xsl:param name="hyphenate">false</xsl:param>

    <!-- "normal" is 1.6. This value is multiplied by the font size -->
    <xsl:param name="line-height">1.5</xsl:param>

    <!--  Specify the spacing required between normal paragraphs. -->
    <xsl:attribute-set name="normal.para.spacing">
        <xsl:attribute name="space-before.optimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0.6em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.0em</xsl:attribute>
    </xsl:attribute-set>

    <!--  Tables, examples, figures, and equations don't need to be forced onto onto one page without page breaks. -->
    <xsl:attribute-set name="formal.object.properties">
        <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
    </xsl:attribute-set>

    <!-- The body bottom margin is the distance from the last line of text in the page body to the bottom of the region-after. -->
    <xsl:param name="body.margin.bottom">20mm</xsl:param>

    <!-- The body top margin is the distance from the top of the region-before to the first line of text in the page body. -->
    <xsl:param name="body.margin.top">10mm</xsl:param>

    <!-- The top page margin is the distance from the physical top of the page to the top of the region-before. -->
    <xsl:param name="page.margin.top">10mm</xsl:param>

    <!-- The bottom page margin is the distance from the bottom of the region-after to the physical bottom of the page. -->
    <xsl:param name="page.margin.bottom">10mm</xsl:param>

    <!-- The inner page margin. The inner page margin is the distance from binding edge of the page to the first column of text. In the left-to-right, top-to-bottom writing direction, this is the left margin of recto pages. The inner and outer margins are usually the same unless the output is double-sided. -->
    <xsl:param name="page.margin.inner">20mm</xsl:param>

    <!-- The outer page margin. The outer page margin is the distance from non-binding edge of the page to the last column of text. In the left-to-right, top-to-bottom writing direction, this is the right margin of recto pages. The inner and outer margins are usually the same unless the output is double-sided. -->
    <xsl:param name="page.margin.outer">20mm</xsl:param>

    <!-- Make hyperlinks blue and don't display the underlying URL -->
    <xsl:param name="ulink.show" select="0"/>

    <xsl:attribute-set name="xref.properties">
        <xsl:attribute name="color">#C8706B</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="section.title.properties">
        <xsl:attribute name="font-family">CabinSketch</xsl:attribute>
        <xsl:attribute name="color">#F69256</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <!-- font size is calculated dynamically by section.heading template -->
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="space-before.minimum">2.0em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">2.0em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">2.0em</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0em</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="monospace.properties">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"></xsl:value-of>
        </xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="color">#666</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="monospace.verbatim.properties">
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
        <xsl:attribute name="hyphenation-character">\</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="list.item.spacing">
        <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.2em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.2em</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="variablelist.term.properties">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template match='xslthl:keyword' mode="xslthl">
        <fo:inline font-weight="bold">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:string' mode="xslthl">
        <fo:inline font-weight="normal" font-style="italic" color="darkred">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:comment' mode="xslthl">
        <fo:inline font-style="italic" color="green">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:tag' mode="xslthl">
        <fo:inline font-weight="bold" color="blue">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:attribute' mode="xslthl">
        <fo:inline font-weight="bold">
            <xsl:apply-templates mode="xslthl"/>
            <xsl:text> </xsl:text>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:value' mode="xslthl">
        <fo:inline font-weight="normal" color="darkred">
            <xsl:text> </xsl:text>
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:number' mode="xslthl">
        <fo:inline color="blue">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:annotation' mode="xslthl">
        <fo:inline color="gray">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:directive' mode="xslthl">
        <fo:inline color="red">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:doccomment' mode="xslthl">
        <fo:inline font-weight="bold" font-style="italic" color="green">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:doctype' mode="xslthl">
        <fo:inline font-weight="bold" font-style="italic" color="green">
            <xsl:apply-templates mode="xslthl"/>
        </fo:inline>
    </xsl:template>
</xsl:stylesheet>
