<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://standoff.proposal" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 13, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p>this styleSheet is used for scientext corpora</xd:p>
            <xd:p>this styleSheet uses template match method</xd:p>
            <xd:p>this styleSheet copies TEI element and mapps teiHeader elements to titlePage elements</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:strip-space elements="xsl:*"/>
    <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"/>

    <xsl:template match="TEI | teiHeader">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="fileDesc">
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
        <xsl:element name="textClass">
            <xsl:apply-templates select="keywords[@scheme='cc']"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-francis' and @xml:lang='fr')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-francis' and @xml:lang='en')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-pascal' and @xml:lang='fr')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-pascal' and @xml:lang='en')]"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="keywords[@scheme='cc']">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- copy kwords and add xml:id for keywords from inist-francis in french-->
    <xsl:template match="keywords[(@scheme='inist-francis' and @xml:lang='fr')]">
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
    <!-- copy keywords form inist-francis in english -->
    <xsl:template match="keywords[(@scheme='inist-francis' and @xml:lang='en')]">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- copy kwords and add xml:id for keywords from inist-pascal in french -->
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
    <!-- copy keywords from inist-pascal in english-->
    <xsl:template match="keywords[(@scheme='inist-pascal' and @xml:lang='en')]">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="abstract">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="stdf">
        <xsl:copy-of select="."/>
    </xsl:template>

    <!-- TEXT level: copy and modify nodes-->
    <xsl:template match="text">
        <xsl:copy>
            <xsl:apply-templates select="front"/>
            <xsl:apply-templates select="body"/>
            <xsl:apply-templates select="back"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="front">
        <xsl:copy>
            <xsl:element name="titlePage">
                <xsl:apply-templates select="teiHeader/fileDesc/titleStmt"/>
                <xsl:apply-templates select="teiHeader/fileDesc/publicationStmt"/>
                <xsl:apply-templates select="teiHeader/fileDesc/sourceDesc/bibl"/>
                <xsl:apply-templates select="teiHeader/profileDesc/langUsage"/>
            </xsl:element>
            <xsl:apply-templates select="teiHeader[position()=2]/profileDesc/textClass"/>
            <xsl:if test="head">
                <xsl:copy-of select="head"/>
            </xsl:if>
            <xsl:if test="docAuthor">
                <xsl:copy-of select="docAuthor"/>
            </xsl:if>
            <xsl:for-each select="div">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="teiHeader[position()=2]/profileDesc/textClass">
        <xsl:for-each select="keywords">
            <xsl:element name="div">
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:for-each select="@*">
                    <xsl:attribute name="{name()}">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:for-each>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="teiHeader/fileDesc/titleStmt">
        <xsl:element name="docTitle">
            <xsl:for-each select="title">
                <xsl:element name="titlePart">
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:copy-of select="child::node()"/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
        <xsl:for-each select="author">
            <xsl:element name="docAuthor">
                <xsl:for-each select="@*">
                    <xsl:attribute name="{name()}">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:for-each>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="editor">
             <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="teiHeader/fileDesc/publicationStmt">
        <xsl:element name="docImprint">
            <xsl:if test="publisher[position()=1]">
                <xsl:element name="publisher">
                    <xsl:copy-of select="publisher[position()=1]/child::node()"/>
                    <xsl:if test="distributor">
                        <xsl:element name="abbr">
                            <xsl:attribute name="type">acronym</xsl:attribute>
                            <xsl:copy-of select="distributor/child::node()"/>
                        </xsl:element>
                    </xsl:if>
                    <xsl:if test="publisher[position()=2]">
                        <xsl:element name="ref">
                            <xsl:attribute name="type">url</xsl:attribute>
                            <xsl:copy-of select="publisher[position()=2]/child::node()"/>
                        </xsl:element>
                    </xsl:if>
                </xsl:element>
            </xsl:if>
            <xsl:for-each select="address">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:if test="date">
                <xsl:element name="docDate">
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:copy-of select="date/child::node()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="idno">
                <xsl:copy-of select="idno"/>
            </xsl:if>
        </xsl:element>
        <xsl:for-each select="availability">
             <xsl:element name="imprimatur">
                 <xsl:for-each select="@*">
                    <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:copy-of select="child::node()"/>
                </xsl:element>
         </xsl:for-each>        
    </xsl:template>
    
    <xsl:template match="teiHeader/fileDesc/sourceDesc/bibl">
        <xsl:element name="docEdition">
            <xsl:copy-of select="."/>
        </xsl:element>
    </xsl:template>
    <!--- cette partie pose problème. Je souhaite ranger cette partie sous docImprint -->
    <!--<xsl:template match="teiHeader[position()=2]/profileDesc/langUsage">
        <xsl:if test="language">
            <xsl:element name="lang">
                <xsl:for-each select="@*">
                    <xsl:attribute name="{name()}">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:for-each>
                <xsl:copy-of select="language/child::node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>-->
    
    <xsl:template match="front/teiHeader/profileDesc/textClass">
        <xsl:for-each select="keywords">
            <xsl:element name="div">
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:for-each select="@*">
                    <xsl:attribute name="{name()}">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:for-each>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>       
    
    <xsl:template match="body">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="back">
        <xsl:copy-of select="."/>
    </xsl:template>

</xsl:stylesheet>
