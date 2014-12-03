<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 4, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:strip-space elements="xsl:*"/>
    <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="TEI">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:atilf="http//www.atilf.fr">
            <xsl:call-template name="TEIHEADER"/>
            <!--<xsl:call-template name="TITLEPAGE"/>-->
            <xsl:call-template name="TEXT"/>
            <xsl:call-template name="STDF"/>
        </TEI>
    </xsl:template>
    <!-- Niveau teiHeader -->
    <xsl:template name="TEIHEADER">
        <teiHeader  xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="teiHeader/child::*"/>
        </teiHeader>
    </xsl:template>
    <!-- Niveau text -->
    <xsl:template name="TEXT">
        <xsl:if test="text">
            <text xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="FRONT"/>
                <xsl:call-template name="BODY"/>
                <xsl:call-template name="BACK"/>
            </text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="FRONT">
        <front xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:call-template name="TITLEPAGE"/>
            <xsl:call-template name="ABSTRACT"/>
        </front>
    </xsl:template>

    <xsl:template name="TITLEPAGE">
        <titlePage xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:call-template name="DOCTITLE"/>
            <xsl:call-template name="DOCAUTHOR"/>
            <xsl:call-template name="DOCIMPRINT"/>
            <xsl:call-template name="IMPRIMATUR"/>
            <xsl:call-template name="DOCEDITION"/>
            <xsl:call-template name="DIV"/>
        </titlePage>
    </xsl:template>
    
    <xsl:template name="DOCTITLE">
        <xsl:if test="text/front/teiHeader/fileDesc/titleStmt/title">
            <docTitle xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="TITLEPART"/>
            </docTitle>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="TITLEPART">
        <xsl:if test="text/front/teiHeader/fileDesc/titleStmt/title[@type='main']">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="level">a</xsl:attribute>
                <xsl:attribute name="type">main</xsl:attribute>
                <xsl:attribute name="lang">fr</xsl:attribute>
                <xsl:copy-of select="text/front/teiHeader/fileDesc/titleStmt/title[@type='main']/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="text/front/teiHeader/fileDesc/titleStmt/title[@type='sub']">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">sub</xsl:attribute>
                <xsl:attribute name="lang">fr</xsl:attribute>
                <xsl:copy-of select="text/front/teiHeader/fileDesc/titleStmt/title[@type='sub']/child::*"/>
            </titlePart>
        </xsl:if>
        <!-- <xsl:for-each select="text/front/teiHeader/fileDesc/titleStmt/title[@type='alt']">
            <xsl:copy-of select="child::node()"/>
        </xsl:for-each>-->
        <xsl:if test="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='en' and @type='alt')]">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="lang">en</xsl:attribute>
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:copy-of select="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='en' and @type='alt')]/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='de' and @type='alt')]">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="lang">de</xsl:attribute>
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:copy-of select="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='de' and @type='alt')]/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='it' and @type='alt')]">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="lang">it</xsl:attribute>
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:copy-of select="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='it' and @type='alt')]/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='sp' and @type='alt')]">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="lang">sp</xsl:attribute>
                <xsl:attribute name="type">alt</xsl:attribute>
                <xsl:copy-of select="text/front/teiHeader/fileDesc/titleStmt/title[(@lang='sp' and @type='alt')]/child::*"/>
            </titlePart>
            </xsl:if>
    </xsl:template>
    
    <xsl:template name="DOCAUTHOR">
        <xsl:for-each select="text/front/teiHeader/fileDesc/titleStmt/author">
            <docAuthor xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="PERSNAME"/>
                <xsl:call-template name="AFFILIATION"/>
                <xsl:call-template name="EMAIL"/>
                <xsl:call-template name="ROLENAME"/>
            </docAuthor>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="PERSNAME">
        <xsl:if test="persName">
            <persName xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:if test="persName/forename">
                    <forename xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:copy-of select="persName/forename/child::*"/>
                    </forename>
                </xsl:if>
                <xsl:if test="persName/surname">
                    <surname xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:copy-of select="persName/surname/child::*"/>
                    </surname>
                </xsl:if>
            </persName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="AFFILIATION">
        <affiliation xmlns="http://www.tei-c.org/ns/1.0">
                <!-- 1ere expression d'affiliation -->
           <xsl:if test="affiliation/s">
               <orgName xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="affiliation/s/child::*"/>
             </orgName>
           </xsl:if>
                <!-- 2e expression d'affiliation -->
           <xsl:if test="orgName/s">
               <orgName xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="orgName/s/child::*"/>
               </orgName>
           </xsl:if>
        </affiliation>
    </xsl:template>
    
    <xsl:template name="EMAIL">
       <xsl:if test="email/s">
           <email xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="email/s/child::*"/>
           </email>
       </xsl:if>
    </xsl:template>
    
    <xsl:template name="ROLENAME">
        <xsl:if test="roleName/s">
            <roleName xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="roleName/s/child::node()"/>
            </roleName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="DOCIMPRINT">
        <docImprint xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:if test="text/front/teiHeader/fileDesc/publicationStmt/date">
                <docDate xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="when">
                        <xsl:value-of select="text/front/teiHeader/fileDesc/publicationStmt/date/@when"/>
                    </xsl:attribute>
                    <xsl:copy-of select="text/front/teiHeader/fileDesc/publicationStmt/date/child::*"/>
                </docDate>
            </xsl:if>
            <xsl:if test="text/front/teiHeader/fileDesc/publicationStmt/idno[@type='url']">
                <ref xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="type">url</xsl:attribute>
                    <xsl:copy-of select="text/front/teiHeader/fileDesc/publicationStmt/idno[@type='url']/child::*"/>
                </ref>
            </xsl:if>
            <xsl:if test="text/front/teiHeader/profileDesc/langUsage/language">
                <language xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="ident">
                        <xsl:value-of select="text/front/teiHeader/profileDesc/langUsage/language/@ident"/>
                    </xsl:attribute>
                    <xsl:copy-of select="text/front/teiHeader/profileDesc/langUsage/language/child::*"/>
                </language>
            </xsl:if>
        </docImprint>
    </xsl:template>
    
    <xsl:template name="IMPRIMATUR">
        <xsl:if test="text/front/teiHeader/fileDesc/publicationStmt/availability/p">
            <imprimatur xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="text/front/teiHeader/fileDesc/publicationStmt/availability/child::*"/>
            </imprimatur>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="DOCEDITION">
        <docEdition xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:call-template name="BIBLFULL"/>
        </docEdition>
    </xsl:template>
    
    <xsl:template name="BIBLFULL">
        <biblFull xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:call-template name="TITLESTMT"/>
            <xsl:call-template name="PUBLICATIONSTMT"/>
            <xsl:call-template name="EDITIONSTMT"/>
        </biblFull>
    </xsl:template>
    
    <xsl:template name="TITLESTMT">
        <titleStmt xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:if test="text/front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title">
                <title xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="text/front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title/child::*"/>
                </title>
            </xsl:if>
            <xsl:call-template name="RESPSTMT"/>
        </titleStmt>
    </xsl:template>
    
    <xsl:template name="RESPSTMT">
        <xsl:for-each select="text/front/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/respStmt">
            <respStmt xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:if test="resp">
                    <resp xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:copy-of select="resp/child::*"/>
                    </resp>
                </xsl:if>
                <xsl:if test="name">
                    <name xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:copy-of select="name/child::*"/>
                    </name>
                </xsl:if>
            </respStmt>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="PUBLICATIONSTMT">
        <publicationStmt xmlns="http://www.tei-c.org/ns/1.0">
            <date xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="text/front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/date/child::*"/>
            </date>
            <idno xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <xsl:value-of select="text/front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno/@type"
                    />
                </xsl:attribute>
                <xsl:copy-of select="text/front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno/child::*"/>
            </idno>
        </publicationStmt>
    </xsl:template>
    
    <xsl:template name="EDITIONSTMT">
        <xsl:for-each select="text/front/teiHeader/fileDesc/titleStmt/editor">
            <editionStmt xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="."/>
            </editionStmt>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="DIV">
       <xsl:for-each select="text/front/teiHeader/profileDesc/keywords">
           <xsl:variable name="keywordLanguage" select="@lang"/>
           <div xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="xml:lang"><xsl:value-of select="$keywordLanguage"/></xsl:attribute>
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:copy-of select="child::node()"/>
            </div>
       </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="ABSTRACT">
            <xsl:for-each select="text/front/div">
                <xsl:variable name="abstractLanguage" select="@lang"/>
                <xsl:variable name="divType" select="@type"/>
                <div xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="xml:lang"><xsl:value-of select="$abstractLanguage"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="$divType"/></xsl:attribute>
                    <xsl:copy-of select="child::node()"/>
                </div>
            </xsl:for-each>
        <xsl:for-each select="text/front/note">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="BODY">
        <xsl:if test="text/body">
            <body xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="text/body/child::*"/>
            </body>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="BACK">
        <xsl:if test="text/back">
            <back xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="text/back/child::*"/>
            </back>
        </xsl:if>
    </xsl:template>
    
    <!-- niveau stdf -->
    <xsl:template name="STDF">
        <xsl:if test="stdf">
            <stdf xmlns="http://standoff.proposal">
                <xsl:copy-of select="stdf/child::*"/>
            </stdf>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>


