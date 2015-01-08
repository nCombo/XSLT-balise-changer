<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:so="http://standoff.proposal"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jan 1, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:strip-space elements="xsl:*"/>
    <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="TEI">
        <TEI>
            <xsl:apply-templates/>
        </TEI>
    </xsl:template>
    <!-- teiHeader level : copy nodes -->
    <xsl:template match="teiHeader">
        <teiHeader>
            <xsl:apply-templates select="fileDesc"/>
            <xsl:apply-templates select="profileDesc"/>
        </teiHeader>
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
                    <xsl:attribute name="xml:id"><xsl:value-of select="concat('ikwfr',count(./preceding-sibling::term)+1)"/></xsl:attribute>
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
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
                    <xsl:attribute name="xml:id"><xsl:value-of select="concat('ikwfr',count(./preceding-sibling::term)+1)"/></xsl:attribute>
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
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
            <text>
                <xsl:call-template name="FRONT"/>
                <xsl:call-template name="BODY"/>
                <xsl:call-template name="BACK"/>
            </text>
    </xsl:template>
    
    <xsl:template name="FRONT">
        <front>
            <xsl:call-template name="TITLEPAGE"/>
            <xsl:call-template name="DIV"/>
            <xsl:call-template name="ABSTRACT"/>
        </front>
    </xsl:template>
    
    <xsl:template name="TITLEPAGE">
        <titlePage>
            <xsl:call-template name="DOCTITLE"/>
            <xsl:call-template name="DOCAUTHOR"/>
            <xsl:call-template name="DOCIMPRINT"/>
            <xsl:call-template name="IMPRIMATUR"/>
            <xsl:call-template name="DOCEDITION"/>
        </titlePage>
    </xsl:template>
    
    <xsl:template name="DOCTITLE">
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title">
            <docTitle>
                <xsl:call-template name="TITLEPART"/>
            </docTitle>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="TITLEPART">
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[@type='main']">
            <titlePart>
                <xsl:attribute name="type">main</xsl:attribute>
                <xsl:attribute name="xml:lang">fr</xsl:attribute>
                <xsl:copy-of select="front/teiHeader/fileDesc/titleStmt/title[@type='main']/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[@type='sub']">
            <titlePart>
                <xsl:attribute name="type">sub</xsl:attribute>
                <xsl:attribute name="xml:lang">fr</xsl:attribute>
                <xsl:copy-of select="front/teiHeader/fileDesc/titleStmt/title[@type='sub']/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='en' and @type='alt')]">
            <titlePart>
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:attribute name="xml:lang">en</xsl:attribute>
                <xsl:copy-of select="front/teiHeader/fileDesc/titleStmt/title[(@lang='en' and @type='alt')]/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='de' and @type='alt')]">
            <titlePart>
                <xsl:attribute name="type">alt</xsl:attribute>               
                <xsl:attribute name="xml:lang">de</xsl:attribute>
                <xsl:copy-of select="front/teiHeader/fileDesc/titleStmt/title[(@lang='de' and @type='alt')]/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='it' and @type='alt')]">
            <titlePart>
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:attribute name="xml:lang">it</xsl:attribute>
                <xsl:copy-of select="front/teiHeader/fileDesc/titleStmt/title[(@lang='it' and @type='alt')]/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="front/teiHeader/fileDesc/titleStmt/title[(@lang='sp' and @type='alt')]">
            <titlePart>
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:attribute name="xml:lang">sp</xsl:attribute>
                <xsl:copy-of select="front/teiHeader/fileDesc/titleStmt/title[(@lang='sp' and @type='alt')]/child::*"/>
            </titlePart>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="DOCAUTHOR">
        <xsl:for-each select="front/teiHeader/fileDesc/titleStmt/author">
            <docAuthor>
                <xsl:call-template name="PERSNAME"/>
                <xsl:call-template name="AFFILIATION"/>
                <xsl:call-template name="EMAIL"/>
                <xsl:call-template name="ROLENAME"/>
            </docAuthor>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="PERSNAME">
        <xsl:if test="persName">
            <xsl:copy-of select="persName"/>
            <!--<persName>
                <xsl:if test="persName/forename">
                    <forename>
                        <xsl:copy-of select="persName/forename/child::*"/>
                    </forename>
                </xsl:if>
                <xsl:if test="persName/surname">
                    <surname>
                        <xsl:copy-of select="persName/surname/child::*"/>
                    </surname>
                </xsl:if>
            </persName>-->
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
        <docImprint>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/date">
                <docDate>
                    <xsl:attribute name="when">
                        <xsl:value-of select="front/teiHeader/fileDesc/publicationStmt/date/@when"/>
                    </xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/date/child::*"/>
                </docDate>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/idno[@type='url']">
                <ref>
                    <xsl:attribute name="type">url</xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/idno[@type='url']/child::*"/>
                </ref>
            </xsl:if>
            <xsl:if test="front/teiHeader/profileDesc/langUsage/language">
                <language>
                    <xsl:attribute name="ident">
                        <xsl:value-of select="front/teiHeader/profileDesc/langUsage/language/@ident"/>
                    </xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/profileDesc/langUsage/language/child::*"/>
                </language>
            </xsl:if>
        </docImprint>
    </xsl:template>
    
    <xsl:template name="IMPRIMATUR">
        <xsl:if test="front/teiHeader/fileDesc/publicationStmt/availability/p">
            <imprimatur>
                <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/availability/child::*"/>
            </imprimatur>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="DOCEDITION">
        <docEdition>
            <xsl:call-template name="BIBLFULL"/>
        </docEdition>
    </xsl:template>
    
    <xsl:template name="BIBLFULL">
        <biblFull>
            <xsl:call-template name="TITLESTMT"/>
            <xsl:call-template name="PUBLICATIONSTMT"/>
            <xsl:call-template name="EDITIONSTMT"/>
        </biblFull>
    </xsl:template>
    
    <xsl:template name="TITLESTMT">
        <titleStmt>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title">
                <title>
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title/child::*"/>
                </title>
            </xsl:if>
            <xsl:call-template name="RESPSTMT"/>
        </titleStmt>
    </xsl:template>
    
    <xsl:template name="RESPSTMT">
        <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/respStmt">
            <respStmt>
                <xsl:if test="resp">
                    <resp>
                        <xsl:copy-of select="resp/child::*"/>
                    </resp>
                </xsl:if>
                <xsl:if test="name">
                    <name>
                        <xsl:copy-of select="name/child::*"/>
                    </name>
                </xsl:if>
            </respStmt>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="PUBLICATIONSTMT">
        <publicationStmt>
            <date>
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/date/child::*"/>
            </date>
            <idno>
                <xsl:attribute name="type">
                    <xsl:value-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno/@type"
                    />
                </xsl:attribute>
                <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno/child::*"/>
            </idno>
        </publicationStmt>
    </xsl:template>
    
    <xsl:template name="EDITIONSTMT">
        <xsl:for-each select="front/teiHeader/fileDesc/titleStmt/editor">
            <editionStmt>
                <xsl:copy-of select="."/>
            </editionStmt>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="DIV">
        <xsl:for-each select="front/teiHeader/profileDesc/keywords">
            <xsl:variable name="keywordLanguage" select="@lang"/>
            <div>
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:attribute name="xml:lang"><xsl:value-of select="$keywordLanguage"/></xsl:attribute>
                <xsl:copy-of select="child::node()"/>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="ABSTRACT">
        <xsl:for-each select="front/div">
            <xsl:variable name="abstractLanguage" select="@lang"/>
            <xsl:variable name="divType" select="@type"/>
            <div>
                <xsl:attribute name="type"><xsl:value-of select="$divType"/></xsl:attribute>
                <xsl:attribute name="xml:lang"><xsl:value-of select="$abstractLanguage"/></xsl:attribute>
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
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>
