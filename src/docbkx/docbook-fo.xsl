<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:date="http://exslt.org/dates-and-times"
	version="1.0">

	<xsl:import href="urn:docbkx:stylesheet" />

	<xsl:param name="paper.type">A4</xsl:param>
	<xsl:param name="title.font.family" select="'Times New Roman'"></xsl:param>
	<xsl:param name="monospace.font.family" select="'Arial'"></xsl:param>
	<xsl:param name="body.font.family" select="'Arial'"></xsl:param>
	<xsl:param name="symbol.font.family" select="'Arial'"></xsl:param>
	<xsl:param name="generate.index" select="0"></xsl:param>
	<xsl:param name="l10n.gentext.default.language" select="'ru'"></xsl:param>
	<xsl:param name="toc.max.depth" select="0"></xsl:param>
	<xsl:param name="body.margin.bottom">0.75in</xsl:param>
	<xsl:param name="generate.toc"></xsl:param>
	<xsl:attribute-set name="normal.para.spacing">
		<xsl:attribute name="space-before.minimum">0.50em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">0.60em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.70em</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="list.block.spacing">
		<xsl:attribute name="space-before.minimum">0.70em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">0.75em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.80em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.70em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">0.75em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">0.80em</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="list.item.spacing">
		<xsl:attribute name="space-before.minimum">0.50em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">0.60em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.70em</xsl:attribute>
	</xsl:attribute-set>
	<xsl:param name="header.rule" select="0" />
	<xsl:attribute-set name="header.content.properties">
	</xsl:attribute-set>
	<xsl:attribute-set name="footer.content.properties">
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="font-family">
			<xsl:value-of select="$body.fontset" />
		</xsl:attribute>
		<xsl:attribute name="margin-left">
			<xsl:value-of select="$title.margin.left" />
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="table.cell.padding">
		<xsl:attribute name="padding-left">8pt</xsl:attribute>
		<xsl:attribute name="padding-right">2pt</xsl:attribute>
		<xsl:attribute name="padding-top">2pt</xsl:attribute>
		<xsl:attribute name="padding-bottom">2pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:template name="header.content">
		<xsl:param name="pageclass" select="''" />
		<xsl:param name="sequence" select="''" />
		<xsl:param name="position" select="''" />
		<xsl:param name="gentext-key" select="''" />
		<fo:block>
			<xsl:choose>
				<xsl:when test="$pageclass = 'titlepage'">
					<!--no footer on title pages-->
				</xsl:when>
				<xsl:when test="$pageclass = 'body' and $sequence = 'first'">
					<xsl:choose>
						<xsl:when test="$position = 'right'">
							<xsl:call-template name="datetime.format">
								<xsl:with-param name="date" select="date:date-time()" />
								<xsl:with-param name="format" select="'m-d-Y'" />
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</fo:block>
	</xsl:template>
	<xsl:template name="footer.content">
		<xsl:param name="pageclass" select="''" />
		<xsl:param name="sequence" select="''" />
		<xsl:param name="position" select="''" />
		<xsl:param name="gentext-key" select="''" />
		<fo:block>
			<xsl:choose>
				<xsl:when test="$pageclass = 'titlepage'">
					<!-- no footer on title pages -->
				</xsl:when>
				<xsl:when test="$pageclass = 'body' and $sequence = 'first'">
					<!-- off -->
				</xsl:when>
				<xsl:otherwise> <!-- not a title page -->
					<xsl:choose>
						<xsl:when test="$double.sided = 0"> <!-- single-sided -->
							<xsl:choose>
								<xsl:when test="$position = 'left'">
									<xsl:text> Name</xsl:text>
								</xsl:when>
								<xsl:when test="$position = 'center'">
									<fo:page-number />
								</xsl:when>
								<xsl:when test="$position = 'right'">
									<xsl:text>Position Title</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:when> <!-- single-sided -->
						<xsl:otherwise> <!-- double-sided -->
							<xsl:choose>
								<xsl:when test="$position = 'left'">
									<xsl:choose>
										<xsl:when
											test="$sequence = 'even' or
												$sequence = 'blank'">
											<fo:page-number />
										</xsl:when>
										<xsl:otherwise> <!-- left/odd -->
											<xsl:text>Name</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="$position = 'center'">
									<xsl:apply-templates select="." mode="titleabbrev.markup" />
								</xsl:when>
								<xsl:when test="$position = 'right'">
									<xsl:choose>
										<xsl:when
											test="$sequence = 'even' or
												$sequence = 'blank'">
											<xsl:text>Name</xsl:text>
										</xsl:when>
										<xsl:otherwise> <!-- left/odd -->
											<fo:page-number />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:otherwise> <!-- double-sided -->
					</xsl:choose>
				</xsl:otherwise> <!-- not a title page-->
			</xsl:choose>
		</fo:block>
	</xsl:template>
	<xsl:attribute-set name="section.title.level1.properties"
		use-attribute-sets="section.properties">
		<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
		<xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.728" />
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level2.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.44" />
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level3.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.2" />
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>
