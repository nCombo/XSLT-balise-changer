<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://standoff.proposal" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 13, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b>combo</xd:p>
            <xd:p><xd:b>Organization:</xd:b>INIST-CNRS</xd:p>
            <xd:p>this styleSheet is used for scientext corpora</xd:p>
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
        <xsl:copy>
            <xsl:apply-templates select="titleStmt"/>
            <xsl:apply-templates select="publicationStmt"/>
            <xsl:apply-templates select="sourceDesc"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="titleStmt">
        <xsl:element name="titleStmt">
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
        </xsl:element>
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
    
    <xsl:template match="stdf">
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
        </xsl:element>
    </xsl:template>
    
    <!-- informations contained in front out of teiHeader -->
    <xsl:template name="NAME">
        <xsl:for-each select="front/div">
            <xsl:copy-of select="."/>
        </xsl:for-each>
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
        <xsl:if test="front/head">
            <xsl:element name="docTitle">
                <xsl:element name="titlePart">
                    <xsl:attribute name="level">a</xsl:attribute>
                    <xsl:copy-of select="front/head/child::node()"/>
                </xsl:element>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DOCAUTHOR">
        <xsl:for-each select="front/docAuthor">
            <xsl:element name="docAuthor">
                <xsl:if test="@id">
                    <xsl:attribute name="xml:id"><xsl:copy-of select="@id"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="@next">
                    <xsl:attribute name="next"><xsl:copy-of select="@next"/></xsl:attribute>
                </xsl:if>
                <xsl:for-each select="name">
                    <xsl:element name="persName">
                        <xsl:element name="name">
                            <xsl:if test="@id">
                                <xsl:attribute name="xml:id"><xsl:copy-of select="@id"/></xsl:attribute>
                            </xsl:if>
                            <xsl:if test="@next">
                                <xsl:attribute name="next"><xsl:copy-of select="@next"/></xsl:attribute>
                            </xsl:if>
                            <xsl:copy-of select="child::node()"/>
                            <!--<xsl:for-each select="anchor">
                                <xsl:element name="anchor">
                                    <xsl:if test="@id">
                                        <xsl:attribute name="xml:id"><xsl:copy-of select="@id"/></xsl:attribute>
                                    </xsl:if>
                                    <xsl:copy-of select="child::node()"/>
                                </xsl:element>
                            </xsl:for-each>-->
                        </xsl:element>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="DOCIMPRINT">
        <xsl:element name="docImprint">
            <xsl:if test="front/teiHeader/fileDesc/titleStmt/title">
                <xsl:copy-of select="front/teiHeader/fileDesc/titleStmt/title"/>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/publisher[position()=1]">
                <xsl:element name="publisher">
                      <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/publisher[position()=1]/child::node()"/> 
                    <xsl:if test="front/teiHeader/fileDesc/publicationStmt/publisher[position()=2]">
                        <xsl:element name="ref">
                            <xsl:attribute name="type">url</xsl:attribute>
                            <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/publisher[position()=2]/child::node()"/>
                        </xsl:element>
                    </xsl:if>
                    <xsl:if test="front/teiHeader/fileDesc/publicationStmt/distributor">
                        <xsl:element name="abbr">
                            <xsl:attribute name="type">acronym</xsl:attribute>
                            <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/distributor/child::node()"/>
                        </xsl:element>
                    </xsl:if>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/address">
                <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/address"/>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/date">
                <xsl:element name="docDate">
                    <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/date/child::*"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/idno">
                <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/idno"/>
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
            <!-- project description -->
            <xsl:if test="front/teiHeader/encodingDesc/projectDesc">
                <xsl:element name="note">
                    <xsl:copy-of select="front/teiHeader/encodingDesc/projectDesc/child::node()"/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>

    <xsl:template name="IMPRIMATUR">
        <xsl:if test="front/teiHeader/fileDesc/publicationStmt/availability">
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
    </xsl:template>

    <xsl:template name="DOCEDITION">
        <xsl:element name="docEdition">
            <xsl:call-template name="BIBL"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="BIBL">
        <xsl:element name="bibl">
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/title[position()=1]">
                <xsl:element name="title">
                    <xsl:attribute name="level">a</xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/title[position()=1]/child::node()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/title[position()=2]">
                <xsl:element name="title">
                    <xsl:attribute name="level">j</xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/title[position()=2]/child::node()"/>
                </xsl:element>
            </xsl:if>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/bibl/author">
                <xsl:element name="respStmt">
                    <xsl:element name="resp">
                        <xsl:text>auteur</xsl:text>
                    </xsl:element>
                    <xsl:element name="name">
                        <xsl:copy-of select="child::node()"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/bibl/editor">
                <xsl:copy-of select="."/>
            </xsl:for-each>

            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/date">
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/date"/>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/extent">
                <xsl:element name="idno">
                    <xsl:attribute name="type">pp</xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/extent/child::node()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/bibl/pubPlace">
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/bibl/pubPlace"/>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    
    <!-- export textClass/keywords to a div element out of titlePage element -->
    <xsl:template name="DIV">
        <xsl:for-each select="front/teiHeader/profileDesc/textClass/keywords">
            <xsl:element name="div">
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:if test="@scheme">
                    <xsl:attribute name="subtype"><xsl:copy-of select="@scheme"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="@next">
                    <xsl:attribute name="next"><xsl:copy-of select="@next"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="@id">
                    <xsl:attribute name="id"><xsl:copy-of select="@id"/></xsl:attribute>
                </xsl:if>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

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
