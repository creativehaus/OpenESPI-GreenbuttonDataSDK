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
<pattern name="" /><xsl:apply-templates select="/" mode="M2" /><pattern name="" /><xsl:apply-templates select="/" mode="M3" /><pattern name="" /><xsl:apply-templates select="/" mode="M4" /></anElement>
</xsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed" priority="4000" mode="M2">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:entry[*/espi:ElectricPowerQualitySummary]" />
<xsl:otherwise>
<assert TestID="D126">
<role></role>
<TestName>ElectricPowerQualitySummary</TestName>
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
<xsl:template match="/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]" priority="4000" mode="M3">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:flickerPlt" />
<xsl:otherwise>
<assert TestID="D113">
<role></role>
<TestName>ElectricPowerQualitySummary flickerPlt</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:flickerPst" />
<xsl:otherwise>
<assert TestID="D114">
<role></role>
<TestName>ElectricPowerQualitySummary flickerPst</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:harmonicVoltage" />
<xsl:otherwise>
<assert TestID="D115">
<role></role>
<TestName>ElectricPowerQualitySummary harmonicVoltage</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:longInterruptions" />
<xsl:otherwise>
<assert TestID="D116">
<role></role>
<TestName>ElectricPowerQualitySummary longInterruptions</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:mainsVoltage" />
<xsl:otherwise>
<assert TestID="D117">
<role></role>
<TestName>ElectricPowerQualitySummary mainsVoltage</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:powerFrequency" />
<xsl:otherwise>
<assert TestID="D118">
<role></role>
<TestName>ElectricPowerQualitySummary powerFrequency</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:rapidVoltageChanges" />
<xsl:otherwise>
<assert TestID="D119">
<role></role>
<TestName>ElectricPowerQualitySummary rapidVoltageChanges</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:shortInterruptions" />
<xsl:otherwise>
<assert TestID="D120">
<role></role>
<TestName>ElectricPowerQualitySummary shortInterruptions</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:summaryInterval" />
<xsl:otherwise>
<assert TestID="D121">
<role></role>
<TestName>ElectricPowerQualitySummary summaryInterval</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:summaryInterval/espi:duration and atom:content/espi:ElectricPowerQualitySummary/espi:summaryInterval/espi:start" />
<xsl:otherwise>
<assert TestID="D134">
<role></role>
<TestName>summaryInterval DateTimeInterval</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:supplyVoltageDips" />
<xsl:otherwise>
<assert TestID="D122">
<role></role>
<TestName>ElectricPowerQualitySummary supplyVoltageDips</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:supplyVoltageImbalance" />
<xsl:otherwise>
<assert TestID="D123">
<role></role>
<TestName>ElectricPowerQualitySummary supplyVoltageImbalance</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:supplyVoltageVariations" />
<xsl:otherwise>
<assert TestID="D124">
<role></role>
<TestName>ElectricPowerQualitySummary supplyVoltageVariations</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ElectricPowerQualitySummary/espi:tempOvervoltage" />
<xsl:otherwise>
<assert TestID="D125">
<role></role>
<TestName>ElectricPowerQualitySummary tempOvervoltage</TestName>
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
<xsl:template match="/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]" priority="4000" mode="M4">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:id" />
<xsl:otherwise>
<assert TestID="D128">
<role></role>
<TestName>ElectricPowerQualitySummary id</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='self']/@href" />
<xsl:otherwise>
<assert TestID="D129">
<role></role>
<TestName>ElectricPowerQualitySummary self link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='up']/@href" />
<xsl:otherwise>
<assert TestID="D130">
<role></role>
<TestName>ElectricPowerQualitySummary up link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:published" />
<xsl:otherwise>
<assert TestID="D131">
<role></role>
<TestName>ElectricPowerQualitySummary published</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:title" />
<xsl:otherwise>
<assert TestID="D127">
<role></role>
<TestName>ElectricPowerQualitySummary title</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:updated" />
<xsl:otherwise>
<assert TestID="D132">
<role></role>
<TestName>ElectricPowerQualitySummary updated</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" />
<xsl:otherwise>
<assert TestID="D133">
<role></role>
<TestName>ElectricPowerQualitySummary self link</TestName>
<Report>verify that link is unique</Report>
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
</xsl:stylesheet>
