<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://standoff.proposal" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 27, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:strip-space elements="xsl:*"/>
    <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="TEI">
        <xsl:copy>
            <xsl:apply-templates select="teiHeader"/>
            <xsl:apply-templates select="stdf"/>
            <xsl:apply-templates select="text"/>
        </xsl:copy>
    </xsl:template>
    
    <!--=== TEIHEADER level : start ===-->
    <xsl:template match="teiHeader">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="fileDesc">
        <xsl:copy>
            <xsl:apply-templates select="titleStmt"/>
            <xsl:apply-templates select="publicationStmt"/>
            <xsl:apply-templates select="sourceDesc"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="titleStmt">
        <xsl:copy>
            <xsl:for-each select="title">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="respStmt">
                <xsl:element name="respStmt">
                    <xsl:copy-of select="child::node()"/>
                    <xsl:element name="persName">
                        <xsl:element name="forename">Sabine</xsl:element>
                        <xsl:element name="surname">Barreaux</xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="publicationStmt">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="sourceDesc">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="profileDesc">
        <xsl:copy>
            <xsl:apply-templates select="langUsage"/>
            <xsl:apply-templates select="textClass"/>
            <xsl:apply-templates select="abstract"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="langUsage">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="textClass">
        <xsl:copy>
            <xsl:apply-templates select="keywords[@scheme='cc']"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-francis' and @xml:lang='fr')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-francis' and @xml:lang='en')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-pascal' and @xml:lang='fr')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-pascal' and @xml:lang='en')]"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="keywords[@scheme='cc']">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- copy kwords and add xml:id for keywords from inist-francis in french -->
    <xsl:template match="keywords[(@scheme='inist-francis' and @xml:lang='fr')]">
        <xsl:element name="keywords">
            <xsl:for-each select="@*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="term">
                <xsl:element name="term">
                    <!-- generation identifier for each term in the form 'ikwfr[index]' -->
                    <!-- index ID is reset for each document -->
                    <!-- identifier on each document at a time T -->
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="concat('ikwfr',count(./preceding-sibling::term)+1)"/>
                    </xsl:attribute>
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <!-- copy keywords form inist-francis in english -->
    <xsl:template match="keywords[(@scheme='inist-francis' and @xml:lang='en')]">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- copy keywords and add xml:id for keywords from inist-pascal in french -->
    <xsl:template match="keywords[(@scheme='inist-pascal' and @xml:lang='fr')]">
        <xsl:element name="keywords">
            <xsl:for-each select="@*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="term">
                <xsl:element name="term">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="concat('ikwfr',count(./preceding-sibling::term)+1)"/>
                    </xsl:attribute>
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <!-- copy keywords from inist-pascal in english -->
    <xsl:template match="keywords[(@scheme='inist-pascal' and @xml:lang='en')]">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="abstract">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!--=== TEIHEADER level : end ===-->
    <!--=== TEXT level : start ===-->
    <!-- TEXT level: copy and modify nodes-->
    <xsl:template match="text">
        <xsl:element name="text">
            <xsl:for-each select="@*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:call-template name="FRONT"/>
            <xsl:call-template name="BODY"/>
            <xsl:call-template name="BACK"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="FRONT">
        <xsl:element name="front">
            <xsl:call-template name="TITLEPAGE"/>
            <xsl:call-template name="ABSTRACT"/>
            <xsl:call-template name="DIV"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="TITLEPAGE">
        <xsl:element name="titlePage">
            <xsl:call-template name="DOCTITLE"/>
            <xsl:call-template name="DOCAUTHOR"/>
            <xsl:call-template name="DOCDATE"/>
            <!--<xsl:call-template name="IMPRIMATUR"/>-->
            <xsl:call-template name="DOCEDITION"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="DOCTITLE">
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title">
            <xsl:element name="docTitle">
                <xsl:call-template name="TITLEPART"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
     
    <xsl:template name="TITLEPART">
        <xsl:for-each select="front/teiHeader/fileDesc/titleStmt/title">
            <xsl:element name="titlePart">
                <xsl:for-each select="@*">
                    <xsl:attribute name="{name()}">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:for-each>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>            
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="DOCAUTHOR">
        <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/author">
            <xsl:element name="docAuthor">
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="DOCDATE">
            <xsl:for-each select="front/teiHeader/fileDesc/publicationStmt/date">
                <xsl:element name="docDate">
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:copy-of select="child::text()"/>
                </xsl:element>
            </xsl:for-each>
    </xsl:template>
    
   <!-- <xsl:template name="IMPRIMATUR">
        <xsl:if test="front/teiHeader/fileDesc/publicationStmt/availability/p">
            <xsl:element name="imprimatur">
                <xsl:for-each select="front/teiHeader/fileDesc/publicationStmt/availability/@*">
                    <xsl:attribute name="{name()}">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:for-each>
                <xsl:for-each select="front/teiHeader/fileDesc/publicationStmt/availability/p">
                    <xsl:element name="s"><xsl:copy-of select="text()"/></xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        </xsl:template>-->
    
    <xsl:template name="DOCEDITION">
        <xsl:element name="docEdition">
            <xsl:call-template name="BIBL"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="BIBL">
        <xsl:element name="bibl">
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/publicationStmt/publisher">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/availability">
                <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/availability"/>
            </xsl:if>
            <!--<xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprintbiblScope">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/idno">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/note">
                <xsl:copy-of select="."/>
            </xsl:for-each>-->
        </xsl:element>
    </xsl:template>
    
    <!-- export textClass/keywords to a div element out of titlePage element -->
    <xsl:template name="DIV">
        <xsl:for-each select="front/teiHeader/profileDesc/textClass/keywords">
            <xsl:variable name="kwType" select="@type"/>
            <xsl:element name="div">
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:attribute name="subtype"><xsl:value-of select="$kwType"/></xsl:attribute>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <!-- abstract in front -->
    <xsl:template name="ABSTRACT">
        <xsl:for-each select="front/*[not(self::teiHeader)]">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>
    
    <!-- BODY level -->
    <xsl:template name="BODY">
        <xsl:if test="body">
            <xsl:element name="body">
                <xsl:copy-of select="body/child::*"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <!--== BACK level ==-->
    <xsl:template name="BACK">
        <xsl:if test="back">
            <xsl:element name="back">
                <xsl:copy-of select="back/child::*"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <!--=== TEXT level : end ===-->
    <!--=== STDF level : start ===-->
    <xsl:template match="stdf">
        <xsl:element name="ns:stdf">
            <xsl:copy-of select="*"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
