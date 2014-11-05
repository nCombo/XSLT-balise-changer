<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0" xml:lang="fr-FR"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 29, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
   <xsl:strip-space elements="xsl:*"/>
       <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"/>

    <xsl:template match="TEI">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema">
            <xsl:call-template name="TITLEPAGE"/>
            <xsl:call-template name="TEXT"/>
            <xsl:call-template name="STDF"/>
        </TEI>
    </xsl:template>

    <xsl:template name="TITLEPAGE">
        <titlePage xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:call-template name="DOCTITLE"/>
            <xsl:call-template name="DOCAUTHOR"/>
            <xsl:call-template name="DOCIMPRINT"/>
            <xsl:call-template name="IMPRIMATUR"/>
            <xsl:call-template name="DOCEDITION"/>
        </titlePage>
    </xsl:template>

    <xsl:template name="DOCTITLE">
        <xsl:if test="teiHeader/fileDesc/titleStmt/title[@level='a' and @type='main']">
        <docTitle xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:call-template name="TITLEPART"/>
        </docTitle>
        </xsl:if>
    </xsl:template>

    <xsl:template name="TITLEPART">
        <xsl:if test="teiHeader/fileDesc/titleStmt/title[@type='main']">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">main</xsl:attribute>
                <xsl:copy-of select="teiHeader/fileDesc/titleStmt/title/child::*"/>
            </titlePart>
        </xsl:if>
        <xsl:if test="teiHeader/fileDesc/titleStmt/title[@type='sub']">
            <titlePart xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">sub</xsl:attribute>
                <xsl:copy-of select="teiHeader/fileDesc/titleStmt/title/child::*"/>
            </titlePart>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DOCAUTHOR">
        <xsl:for-each select="teiHeader/fileDesc/titleStmt/author">
            <docAuthor xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:call-template name="PERSNAME"/>
                <xsl:call-template name="AFFILIATION"/>
                <xsl:call-template name="EMAIL"/>
            </docAuthor>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="PERSNAME">
        <xsl:if test="persName/forename">
            <persName xmlns="http://www.tei-c.org/ns/1.0">
                <!--  <forename xmlns="http://www.tei-c.org/ns/1.0">-->
            <!-- <xsl:copy-of select="persName/child::*"/>-->
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
        <xsl:if test="fileDesc/titleStmt/author/affiliation/s">
            <!-- 1ere expression d'affiliation -->
            <affiliation xmlns="http://www.tei-c.org/ns/1.0">
                <orgName>
                    <xsl:value-of select="fileDesc/titleStmt/author/affiliation/s"/>
                </orgName>
            </affiliation>
        </xsl:if>
        <xsl:if test="fileDesc/titleStmt/author/orgName/s">
            <!-- 2e expression d'affiliation -->
            <affiliation xmlns="http://www.tei-c.org/ns/1.0">
                <orgName>
                    <xsl:value-of select="fileDesc/titleStmt/author/orgName/s"/>
                </orgName>
            </affiliation>
        </xsl:if>
    </xsl:template>

    <xsl:template name="EMAIL">
        <xsl:if test="fileDesc/titleStmt/author/email/s">
            <email xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:value-of select="fileDesc/titleStmt/author/email/s"/>
            </email>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DOCIMPRINT">
        <docImprint xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:if test="teiHeader/fileDesc/publicationStmt/date">
                <docDate xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="when">
                        <xsl:value-of select="teiHeader/fileDesc/publicationStmt/date/@when"/>
                    </xsl:attribute>
                    <xsl:copy-of select="teiHeader/fileDesc/publicationStmt/date/child::*"/>
                </docDate>
            </xsl:if>
            <xsl:if test="teiHeader/fileDesc/publicationStmt/idno[@type='url']">
                <!--<idno>-->
                <!-- peut-être préférable d'utiliser <ref> à la place de <idno> -->
                <!--<xsl:attribute name="type">url</xsl:attribute>
                    <xsl:value-of select="fileDesc/publicationStmt/idno[@type='url']"></xsl:value-of>
                </idno>-->
                <ref xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="type">url</xsl:attribute>
                    <xsl:copy-of select="teiHeader/fileDesc/publicationStmt/idno[@type='url']/child::*"/>
                </ref>
            </xsl:if>
            <xsl:if test="teiHeader/profileDesc/langUsage/language">
                <language>
                    <xsl:attribute name="ident">
                        <xsl:value-of select="teiHeader/profileDesc/langUsage/language/@ident"/>
                    </xsl:attribute>
                    <xsl:copy-of select="teiHeader/profileDesc/langUsage/language/child::*"/>
                </language>
            </xsl:if>
        </docImprint>
    </xsl:template>

    <xsl:template name="IMPRIMATUR">
        <xsl:if test="teiHeader/fileDesc/publicationStmt/availability/p">
            <imprimatur xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="teiHeader/fileDesc/publicationStmt/availability/child::*"/>
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
        </biblFull>
    </xsl:template>

    <xsl:template name="TITLESTMT">
         <titleStmt xmlns="http://www.tei-c.org/ns/1.0">
             <xsl:if test="teiheader/fileDesc/sourceDesc/biblFull/titleStmt/title">
                <title>
                    <xsl:copy-of select="teiheader/fileDesc/sourceDesc/biblFull/titleStmt/title/child::*"/>
                </title>
             </xsl:if>
            <xsl:call-template name="RESPSTMT"/>
            </titleStmt>
    </xsl:template>

    <xsl:template name="RESPSTMT">
        <xsl:for-each select="teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/respStmt">
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
            <date>
                <xsl:copy-of select="teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/date/child::*"/>
            </date>
            <idno>
                <xsl:attribute name="type">
                    <xsl:value-of select="teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno/@type"
                    />
                </xsl:attribute>
                <xsl:copy-of select="teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno/child::*"/>
            </idno>
        </publicationStmt>
    </xsl:template>
    <xsl:template name="TEXT">
        <xsl:if test="text">
            <text  xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="text/child::*"/>
            </text>
        </xsl:if>
    </xsl:template>
    <xsl:template name="STDF">
        <xsl:if test="stdf">
            <stdf  xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="stdf/child::*"/>
            </stdf>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
