<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://standoff.proposal" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 13, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p>this styleSheet is used for Open Edition corpora</xd:p>
            <xd:p>this styleSheet uses template match method and call-template method</xd:p>
            <xd:p>this styleSheet copies TEI element and mapps teiHeader elements to titlePage elements</xd:p>
            <xd:p/>
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
        <xsl:element name="profileDesc">
            <xsl:apply-templates select="langUsage"/>
            <xsl:apply-templates select="textClass"/>
            <xsl:apply-templates select="abstract"/>
        </xsl:element>
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

    <!-- TEXT level: copy and modify nodes-->
    <xsl:template match="text">
        <xsl:element name="text">
            <xsl:call-template name="FRONT"/>
            <xsl:call-template name="BODY"/>
            <xsl:call-template name="BACK"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="FRONT">
        <xsl:element name="front">
            <xsl:call-template name="TITLEPAGE"/>
            <xsl:call-template name="DIV"/>
            <xsl:call-template name="ABSTRACT"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="TITLEPAGE">
        <xsl:element name="titlePage">
            <xsl:call-template name="DOCTITLE"/>
            <xsl:call-template name="DOCAUTHOR"/>
            <xsl:call-template name="DOCIMPRINT"/>
            <xsl:call-template name="IMPRIMATUR"/>
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
        <xsl:for-each select="front/teiHeader/fileDesc/titleStmt/author">
            <xsl:element name="docAuthor">
                <xsl:call-template name="PERSNAME"/>
                <xsl:call-template name="AFFILIATION"/>
                <xsl:call-template name="EMAIL"/>
                <xsl:call-template name="ROLENAME"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="PERSNAME">
        <xsl:if test="persName">
            <xsl:copy-of select="persName"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="AFFILIATION">
        <!-- affiliation 1 -->
        <xsl:if test="affiliation">
            <xsl:copy-of select="affiliation"/>
        </xsl:if>
        <!--affiliation 2 -->
        <xsl:if test="orgName">
            <xsl:copy-of select="orgName"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="EMAIL">
        <xsl:if test="email">
            <xsl:copy-of select="email"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ROLENAME">
        <xsl:if test="roleName">
            <xsl:copy-of select="roleName"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DOCIMPRINT">
        <xsl:element name="docImprint">
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/date">
                <xsl:element name="docDate">
                    <xsl:for-each select="front/teiHeader/fileDesc/publicationStmt/date/@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/date/child::*"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/idno[@type='url']">
                <xsl:element name="ref">
                    <xsl:attribute name="type">url</xsl:attribute>
                    <xsl:copy-of
                        select="front/teiHeader/fileDesc/publicationStmt/idno[@type='url']/child::*"
                    />
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/profileDesc/langUsage/language">
                <xsl:element name="lang">
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="front/teiHeader/profileDesc/langUsage/language/@ident"
                        />
                    </xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/profileDesc/langUsage/language/child::*"/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>

    <xsl:template name="IMPRIMATUR">
        <xsl:if test="front/teiHeader/fileDesc/publicationStmt/availability/p">
            <xsl:element name="imprimatur">
                <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/availability/p/child::*"
                />
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DOCEDITION">
        <xsl:element name="docEdition">
            <xsl:call-template name="BIBL"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="BIBL">
        <xsl:element name="bibl">
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title">
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title"/>
            </xsl:if>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/respStmt">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/date">
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/date"/>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno[@type='pp']">
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno[@type='pp']"/>
            </xsl:if>
            <xsl:for-each select="front/teiHeader/fileDesc/titleStmt/editor">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template name="DIV">
        <xsl:for-each select="front/teiHeader/profileDesc/keywords">
            <xsl:variable name="keywordLanguage" select="@lang"/>
            <div>
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="$keywordLanguage"/>
                </xsl:attribute>
                <xsl:copy-of select="child::node()"/>
            </div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="ABSTRACT">
        <xsl:for-each select="front/div">
            <xsl:variable name="abstractLanguage" select="@lang"/>
            <xsl:variable name="divType" select="@type"/>
            <div>
                <xsl:attribute name="type">
                    <xsl:value-of select="$divType"/>
                </xsl:attribute>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="$abstractLanguage"/>
                </xsl:attribute>
                <xsl:copy-of select="child::node()"/>
            </div>
        </xsl:for-each>
        <xsl:for-each select="front/note">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="BODY">
        <xsl:if test="body">
            <body>
                <xsl:copy-of select="body/child::*"/>
            </body>
        </xsl:if>
    </xsl:template>
    <!-- BACK level -->
    <xsl:template name="BACK">
        <xsl:if test="back">
            <back>
                <xsl:copy-of select="back/child::*"/>
            </back>
        </xsl:if>
    </xsl:template>
    <!-- STDF level -->
    <xsl:template match="stdf">
        <xsl:element name="ns:stdf">
            <xsl:copy-of select="*"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
