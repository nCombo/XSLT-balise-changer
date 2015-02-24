<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://standoff.proposal" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jan 1, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p>this styleSheet uses call-template method</xd:p>
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
        <profileDesc>
            <xsl:apply-templates select="langUsage"/>
            <xsl:apply-templates select="textClass"/>
            <xsl:apply-templates select="abstract"/>
        </profileDesc>
    </xsl:template>

    <xsl:template match="langUsage">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="textClass">
        <textClass>
            <xsl:apply-templates select="keywords[@scheme='cc']"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-francis' and @xml:lang='fr')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-francis' and @xml:lang='en')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-pascal' and @xml:lang='fr')]"/>
            <xsl:apply-templates select="keywords[(@scheme='inist-pascal' and @xml:lang='en')]"/>
        </textClass>
    </xsl:template>

    <xsl:template match="keywords[@scheme='cc']">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- copy kwords and add xml:id for kwords 1 -->
    <xsl:template match="keywords[(@scheme='inist-francis' and @xml:lang='fr')]">
        <keywords>
            <xsl:attribute name="scheme">inist-francis</xsl:attribute>
            <xsl:attribute name="xml:lang">fr</xsl:attribute>
            <xsl:for-each select="term">
                <term>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="concat('ikwfr',count(./preceding-sibling::term)+1)"/>
                    </xsl:attribute>
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:value-of select="."/>
                </term>
            </xsl:for-each>
        </keywords>
    </xsl:template>
    <!-- copy kwords 1 -->
    <xsl:template match="keywords[(@scheme='inist-francis' and @xml:lang='en')]">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- copy kwords and add xml:id for kwords 2 -->
    <xsl:template match="keywords[(@scheme='inist-pascal' and @xml:lang='fr')]">
        <keywords>
            <xsl:attribute name="scheme">inist-pascal</xsl:attribute>
            <xsl:attribute name="xml:lang">fr</xsl:attribute>
            <xsl:for-each select="term">
                <term>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="concat('ikwfr',count(./preceding-sibling::term)+1)"/>
                    </xsl:attribute>
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:value-of select="."/>
                </term>
            </xsl:for-each>
        </keywords>
    </xsl:template>
    <!-- copy kwords 2 -->
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
            <xsl:call-template name="NAME"/>
            <xsl:call-template name="ARGUMENT"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="NAME">
        <xsl:for-each select="front/head">
            <xsl:copy-of select="."/>
        </xsl:for-each>
        <xsl:for-each select="front/docAuthor">
            <xsl:copy-of select="."/>
        </xsl:for-each>
        <xsl:for-each select="front/div">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>
    <!-- Prject description-->
    <xsl:template name="ARGUMENT">
        <xsl:if test="front/teiHeader/encodingDesc/projectDesc">
            <xsl:element name="argument">
                <xsl:copy-of select="front/teiHeader/encodingDesc/projectDesc/child::node()"/>
            </xsl:element>
        </xsl:if>
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
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title">
            <xsl:element name="titlePart">
                <xsl:attribute name="type">main</xsl:attribute>
                <xsl:attribute name="xml:lang">fr</xsl:attribute>
                <xsl:copy-of
                    select="front/teiHeader/fileDesc/titleStmt/title/child::*"/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='en' and @type='alt')]">
            <xsl:element name="titlePart">
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:attribute name="xml:lang">en</xsl:attribute>
                <xsl:copy-of
                    select="front/teiHeader/fileDesc/titleStmt/title[(@lang='en' and @type='alt')]/child::*"
                />
            </xsl:element>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='de' and @type='alt')]">
            <xsl:element name="titlePart">
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:attribute name="xml:lang">de</xsl:attribute>
                <xsl:copy-of
                    select="front/teiHeader/fileDesc/titleStmt/title[(@lang='de' and @type='alt')]/child::*"
                />
            </xsl:element>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='it' and @type='alt')]">
            <xsl:element name="titlePart">
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:attribute name="xml:lang">it</xsl:attribute>
                <xsl:copy-of
                    select="front/teiHeader/fileDesc/titleStmt/title[(@lang='it' and @type='alt')]/child::*"
                />
            </xsl:element>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='sp' and @type='alt')]">
            <xsl:element name="titlePart">
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:attribute name="xml:lang">sp</xsl:attribute>
                <xsl:copy-of
                    select="front/teiHeader/fileDesc/titleStmt/title[(@lang='sp' and @type='alt')]/child::*"
                />
            </xsl:element>
        </xsl:if>
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
                    <xsl:attribute name="ident">
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
                <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/availability/child::*"
                />
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DOCEDITION">
        <xsl:element name="docEdition">
            <xsl:call-template name="BIBLFULL"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="BIBLFULL">
        <xsl:element name="biblFull">
            <xsl:call-template name="TITLESTMT"/>
            <xsl:call-template name="PUBLICATIONSTMT"/>
            <xsl:call-template name="EDITIONSTMT"/>
            <xsl:call-template name="EXTENT"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="TITLESTMT">
        <xsl:element name="titleStmt">
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/title">
                <xsl:element name="title">
                    <xsl:copy-of
                        select="front/teiHeader/fileDesc/sourceDesc/bibl/title/child::*"
                    />
                </xsl:element>
            </xsl:if>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/bibl/author">
                    <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/bibl/editor">
                    <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template name="PUBLICATIONSTMT">
        <xsl:element name="publicationStmt">
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/publisher">
                <xsl:element name="publisher">
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/publisher/child::*"/>
                </xsl:element>
            </xsl:if>
            <xsl:element name="pubPlace">
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/pubPlace/child::*"/>
            </xsl:element>
            <xsl:element name="date">
                <xsl:copy-of
                    select="front/teiHeader/fileDesc/sourceDesc/bibl/date/child::*"
                />
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template name="EDITIONSTMT">
        <xsl:for-each select="front/teiHeader/fileDesc/titleStmt/editor">
            <xsl:element name="editionStmt">
                <xsl:copy-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="EXTENT">
        <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/extent">
            <xsl:element name="extent">
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/extent/child::*"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DIV">
        <xsl:for-each select="front/teiHeader/profileDesc/textClass/keywords">
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

    <!--<xsl:template name="ABSTRACT">
        <xsl:for-each select="front/div">
            <xsl:copy-of select="."/>
        </xsl:for-each>
        <xsl:for-each select="front/note">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>-->
    
    <xsl:template name="BODY">
        <xsl:if test="body">
            <xsl:element name="body">
                <xsl:copy-of select="body/child::*"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <!-- BACK level -->
    <xsl:template name="BACK">
        <xsl:if test="back">
            <xsl:element name="back">
                <xsl:copy-of select="back/child::*"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <!-- STDF level -->
    <xsl:template match="stdf">
        <xsl:element name="ns:stdf">
            <xsl:copy-of select="*"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
