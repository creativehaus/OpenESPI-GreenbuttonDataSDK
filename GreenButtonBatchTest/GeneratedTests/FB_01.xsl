<?xml version="1.0" encoding="UTF-16" standalone="yes"?>
<xsl:stylesheet espi:dummy-for-xmlns="" atom:dummy-for-xmlns="" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:espi="http://naesb.org/espi" xmlns:atom="http://www.w3.org/2005/Atom">
<!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. The name or details of 
    this mode may change during 1Q 2007.-->


<!--PHASES-->


<!--PROLOG-->
<xsl:output method="xml" indent="yes" />

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''"><xsl:value-of select="name()" /></xsl:when>
<xsl:otherwise>
<xsl:text>*:</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>[namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
<xsl:variable name="preceding" select="count(preceding-sibling::*[local-name()=local-name(current())&#xA;	  		                             and namespace-uri() = namespace-uri(current())])" />
<xsl:text>[</xsl:text>
<xsl:value-of select="1+ $preceding" />
<xsl:text>]</xsl:text>
</xsl:template>
<xsl:template match="@*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''">@sch:schema</xsl:when>
<xsl:otherwise>
<xsl:text>@*[local-name()='</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>' and namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
<xsl:for-each select="ancestor-or-self::*">
<xsl:text>/</xsl:text>
<xsl:value-of select="name(.)" />
<xsl:if test="preceding-sibling::*[name(.)=name(current())]">
<xsl:text>[</xsl:text>
<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />
<xsl:text>]</xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:if test="not(self::*)">
<xsl:text />/@<xsl:value-of select="name(.)" />
</xsl:if>
</xsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path" />
<xsl:template match="text()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')" />
</xsl:template>
<xsl:template match="comment()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')" />
</xsl:template>
<xsl:template match="processing-instruction()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.@', name())" />
</xsl:template>
<xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:text>.</xsl:text>
<xsl:choose>
<xsl:when test="count(. | ../namespace::*) = count(../namespace::*)">
<xsl:value-of select="concat('.namespace::-',1+count(namespace::*),'-')" />
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
<xsl:template match="*" mode="generate-id-2" priority="2">
<xsl:text>U</xsl:text>
<xsl:number level="multiple" count="*" />
</xsl:template>
<xsl:template match="node()" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>n</xsl:text>
<xsl:number count="node()" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>_</xsl:text>
<xsl:value-of select="string-length(local-name(.))" />
<xsl:text>_</xsl:text>
<xsl:value-of select="translate(name(),':','.')" />
</xsl:template>
<!--Strip characters-->
<xsl:template match="text()" priority="-1" />

<!--SCHEMA METADATA-->
<xsl:template match="/"><anElement>
<pattern name="" /><xsl:apply-templates select="/" mode="M2" /><pattern name="" /><xsl:apply-templates select="/" mode="M3" /><pattern name="" /><xsl:apply-templates select="/" mode="M4" /><pattern name="" /><xsl:apply-templates select="/" mode="M5" /><pattern name="" /><xsl:apply-templates select="/" mode="M6" /><pattern name="" /><xsl:apply-templates select="/" mode="M7" /></anElement>
</xsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/" priority="4000" mode="M2">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:feed" />
<xsl:otherwise>
<assert TestID="D000">
<role></role>
<TestName>feed</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M2" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M2" />
<xsl:template match="@*|node()" priority="-2" mode="M2">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M2" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M2" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed" priority="4000" mode="M3">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:entry[*/espi:LocalTimeParameters]" />
<xsl:otherwise>
<assert TestID="D136">
<role></role>
<TestName>LocalTimeParameters</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:entry[*/espi:UsagePoint]" />
<xsl:otherwise>
<assert TestID="D006">
<role></role>
<TestName>UsagePoint</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:id" />
<xsl:otherwise>
<assert TestID="D001">
<role></role>
<TestName>feed id</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:title" />
<xsl:otherwise>
<assert TestID="D002">
<role></role>
<TestName>feed title</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:updated" />
<xsl:otherwise>
<assert TestID="D003">
<role></role>
<TestName>feed updated</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M3" />
<xsl:template match="@*|node()" priority="-2" mode="M3">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M3" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M3" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry" priority="4000" mode="M4">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[atom:id = current()/atom:id])&gt;0" />
<xsl:otherwise>
<assert TestID="D004">
<role></role>
<TestName>entry id's (URNs)</TestName>
<Report>verify the uniqueness</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M4" />
<xsl:template match="@*|node()" priority="-2" mode="M4">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M4" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M4" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:LocalTimeParameters]" priority="4000" mode="M5">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:id" />
<xsl:otherwise>
<assert TestID="D138">
<role></role>
<TestName>LocalTimeParameters id</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='self']/@href" />
<xsl:otherwise>
<assert TestID="D139">
<role></role>
<TestName>LocalTimeParameters self link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='up']/@href" />
<xsl:otherwise>
<assert TestID="D140">
<role></role>
<TestName>LocalTimeParameters up link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:published" />
<xsl:otherwise>
<assert TestID="D141">
<role></role>
<TestName>LocalTimeParameters published</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:title" />
<xsl:otherwise>
<assert TestID="D137">
<role></role>
<TestName>LocalTimeParameters title</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:updated" />
<xsl:otherwise>
<assert TestID="D142">
<role></role>
<TestName>LocalTimeParameters updated</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:LocalTimeParameters]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" />
<xsl:otherwise>
<assert TestID="D143">
<role></role>
<TestName>LocalTimeParameters self link</TestName>
<Report>verify that link is unique</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:UsagePoint]/atom:link[@rel='related' and @href=current()/atom:link[@rel='self']/@href])&gt;0" />
<xsl:otherwise>
<assert TestID="D135">
<role></role>
<TestName>LocalTimeParameters self link</TestName>
<Report>verify that each LocalTimeParameter points to at least one UsagePoint</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M5" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M5" />
<xsl:template match="@*|node()" priority="-2" mode="M5">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M5" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M5" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:UsagePoint]" priority="4000" mode="M6">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:UsagePoint/espi:ServiceCategory/espi:kind" />
<xsl:otherwise>
<assert TestID="D008">
<role></role>
<TestName>UsagePoint ServiceCategory</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M6" />
<xsl:template match="@*|node()" priority="-2" mode="M6">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M6" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M6" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:UsagePoint]" priority="4000" mode="M7">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:id" />
<xsl:otherwise>
<assert TestID="D011">
<role></role>
<TestName>UsagePoint id</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='related']/@href" />
<xsl:otherwise>
<assert TestID="D016">
<role></role>
<TestName>UsagePoint related MeterReadingList</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='self']/@href" />
<xsl:otherwise>
<assert TestID="D013">
<role></role>
<TestName>UsagePoint self link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='up']/@href" />
<xsl:otherwise>
<assert TestID="D015">
<role></role>
<TestName>UsagePoint up link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:published" />
<xsl:otherwise>
<assert TestID="D009">
<role></role>
<TestName>UsagePoint published</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:title" />
<xsl:otherwise>
<assert TestID="D012">
<role></role>
<TestName>UsagePoint title</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:updated" />
<xsl:otherwise>
<assert TestID="D010">
<role></role>
<TestName>UsagePoint updated</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:LocalTimeParameters]/atom:link[@rel='self' and @href=current()/atom:link[@rel='related']/@href])=1" />
<xsl:otherwise>
<assert TestID="D007">
<role></role>
<TestName>UsagePoint related LocalTimeParameters</TestName>
<Report>verify that UsagePoint points to at most one LocalTimeParameters</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:UsagePoint]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" />
<xsl:otherwise>
<assert TestID="D014">
<role></role>
<TestName>UsagePoint self link</TestName>
<Report>verify that link is unique</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M7" />
<xsl:template match="@*|node()" priority="-2" mode="M7">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M7" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M7" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
