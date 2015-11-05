<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://standoff.proposal" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 9, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p><xd:b>Organization:</xd:b>INIST-CNRS</xd:p>
            <xd:p>this style sheet is used for TEI and preMaf format</xd:p>
            <xd:p>this style sheet is used for Open Edition corpora</xd:p>
            <xd:p>this style sheet uses template match method and call-template method</xd:p>
            <xd:p>this style sheet copies TEI element and mapps teiHeader elements to titlePage elements</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

    <xsl:strip-space elements="xsl:*"/>
    <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8"/>

    <xsl:template match="TEI">
        <xsl:copy>
            <xsl:namespace name="ns"><xsl:text>http://standoff.proposal</xsl:text></xsl:namespace>
            <xsl:apply-templates select="teiHeader"/>
            <xsl:apply-templates select="stdf"/>
            <xsl:apply-templates select="text"/>
        </xsl:copy>
    </xsl:template>

    <!--=== TEIHEADER level : start ===-->
    <xsl:template match="teiHeader">
        <xsl:copy>
            <xsl:apply-templates/>
            <xsl:element name="encodingDesc">
                <xsl:element name="projectDesc">
                    <xsl:element name="p">
                        <xsl:text>TermITH est un projet ANR sur 3 ans et demi (2013 - 2016) qui a pour objectif de développer une plateforme d'indexation automatique de textes en sciences humaines et sociales en fançais en s'appuyant sur les termes qu'ils contiennent.</xsl:text>
                    </xsl:element>
                    <xsl:element name="p">
                        <xsl:text>Le présent document fait partie du corpus disciplinaire sur lequel les diffférents traittements développés dans TermITH sont testés.</xsl:text>
                    </xsl:element>
                    <xsl:element name="p">
                        <xsl:text>Le présent document est le résultat de la fusion entre l'article en texte intégral provenant de l'editeur et sa notice bibliographique provenant de l'INIST-CNRS.</xsl:text>
                    </xsl:element>
                    <xsl:element name="p">
                        <xsl:text>La fusion entre la notice et son article est réalisée par Sabine Barreaux.</xsl:text>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="editorialDecl">
                    <xsl:element name="normalization">
                        <xsl:element name="p">
                            <xsl:text>La notice bibliographique de l'INIST-CNRS figure dans l'entête(teiHeader)du présent document. Les métadonnées provenant de l'éditeur de l'article sont transférées vers l'élément titlePage.</xsl:text>
                        </xsl:element>
                        <xsl:element name="p">
                            <xsl:text>Le transfert des informations du teiHeader de l'article est réalisé par Nourdine Combo.</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
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
        <xsl:copy>
            <xsl:apply-templates select="availability"/>
            <xsl:apply-templates select="idno"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="availability">
        <xsl:copy>
            <xsl:if test="licence">
                <xsl:copy-of select="licence"/>
            </xsl:if>
            <!-- licence fournisseur -->
            <xsl:element name="licence">
                <xsl:element name="p">
                    <xsl:text>Selon la convention signée avec l'éditeur, le présent document n'est utilisable que par les partenaires du projet TermITH dans le cadre des traitements développés pour TermITH.</xsl:text>
                </xsl:element>
                <xsl:element name="p">
                    <xsl:text>Ce document n'est pas diffusable en l'état.</xsl:text>
                </xsl:element>
            </xsl:element>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="idno">
        <xsl:copy-of select="."/>
        <!-- identifiant termith: recupere le nom de fichier -->
        <xsl:element name="idno">
            <xsl:attribute name="type">
                <xsl:value-of>termithIdentifier</xsl:value-of>
            </xsl:attribute>
            <xsl:variable name="filename" select="tokenize(base-uri(.), '/')[last()]"/>
            <xsl:value-of select="$filename"/>
        </xsl:element>
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
    
    <!--=== STDF level: start ===-->
    <!--this level could be modified when preMaf v2 will be ready-->
    <xsl:template match="stdf">
        <xsl:if test="spanGrp[@type='wordForms']">
            <xsl:element name="ns:stdf">
                <xsl:apply-templates select="spanGrp[@type='wordForms']"/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="spanGrp[@type='candidatsTermes']">
            <xsl:element name="ns:stdf">
                <xsl:apply-templates select="spanGrp[@type='candidatsTermes']"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="spanGrp[@type='wordForms']">
        <xsl:variable name="spanGrpType" select="@type"/>
        <xsl:element name="ns:soHeader">
            <xsl:element name="tei:encodingDesc">
                <xsl:element name="appInfo">
                    <xsl:element name="application">
                        <xsl:attribute name="ident">acompleterparatilf</xsl:attribute><xsl:attribute name="version">acompleterparatilf</xsl:attribute>
                        <xsl:element name="label">acompleterparatilf</xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="titleStmt">
                <xsl:element name="title"><xsl:value-of select="$spanGrpType"/></xsl:element>
                <xsl:element name="author">
                    <xsl:attribute name="role">acompleterparatilf</xsl:attribute>
                    <xsl:text>acompleterparatilf</xsl:text>
                </xsl:element>
            </xsl:element>
        </xsl:element>
        <xsl:element name="ns:annotations">
            <xsl:copy-of select="child::node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="spanGrp[@type='candidatsTermes']">
        <xsl:variable name="spanGrpType" select="@type"/>
        <xsl:element name="ns:soHeader">
            <xsl:element name="tei:encodingDesc">
                <xsl:element name="appInfo">
                    <xsl:element name="application">
                        <xsl:attribute name="ident">acompleterparatilf</xsl:attribute><xsl:attribute name="version">acompleterparatilf</xsl:attribute>
                        <xsl:element name="label">acompleterparatilf</xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="titleStmt">
                <xsl:element name="title"><xsl:value-of select="$spanGrpType"/></xsl:element>
                <xsl:element name="author">
                    <xsl:attribute name="role">acompleterparatilf</xsl:attribute>
                    <xsl:text>acompleterparatilf</xsl:text>
                </xsl:element>
            </xsl:element>
        </xsl:element>
        <xsl:element name="ns:annotations">
            <xsl:copy-of select="child::node()"/>
        </xsl:element>
    </xsl:template>
    
    <!--=== TEXT level : start ===-->
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
            <xsl:call-template name="ABSTRACT"/>
            <xsl:call-template name="DIV"/>
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
                <xsl:call-template name="REF"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="PERSNAME">
        <xsl:if test="persName">
            <xsl:copy-of select="persName"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="AFFILIATION">
        <xsl:for-each select="affiliation">
            <!--<xsl:element name="affiliation">-->
                <xsl:copy-of select="."/>
                <xsl:if test="orgName">
                    <xsl:copy-of select="orgName"/>
                </xsl:if>
            <!--</xsl:element>-->
        </xsl:for-each>
        <xsl:for-each select="orgName">
            <xsl:copy-of select="."/>
        </xsl:for-each>        
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
    
    <xsl:template name="REF">
        <xsl:if test="ref">
            <xsl:copy-of select="ref"/>
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
                    <xsl:copy-of select="front/teiHeader/fileDesc/publicationStmt/date/child::node()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/idno[@type='url']">
                <xsl:element name="ref">
                    <xsl:attribute name="type">url</xsl:attribute>
                    <xsl:copy-of
                        select="front/teiHeader/fileDesc/publicationStmt/idno[@type='url']/child::node()"
                    />
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/publicationStmt/idno[@type='documentnumber']">
                <xsl:copy-of
                    select="front/teiHeader/fileDesc/publicationStmt/idno[@type='documentnumber']"
                />
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
                    <xsl:element name="s"><xsl:copy-of select="node()"/></xsl:element>
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
                <xsl:element name="biblScope">
                    <xsl:attribute name="unit"><xsl:text>page</xsl:text></xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblFull/publicationStmt/idno[@type='pp']/child::node()"/>
                </xsl:element>
            </xsl:if>
            <xsl:for-each select="front/teiHeader/fileDesc/titleStmt/editor">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:if test="front/teiHeader/profileDesc/langUsage/language">
                <xsl:element name="lang">
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="front/teiHeader/profileDesc/langUsage/language/@ident"
                        />
                    </xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/profileDesc/langUsage/language/child::node()"/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>

    <!-- export textClass/keywords to a div element out of titlePage element -->
    <xsl:template name="DIV">
        <xsl:for-each select="front/teiHeader/profileDesc/textClass/keywords">
            <xsl:variable name="keywordLanguage" select="@xml:lang"/>
            <xsl:element name="div">
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:if test="$keywordLanguage != ''">
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="$keywordLanguage"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <!-- abstract in front -->
    <xsl:template name="ABSTRACT">
        <xsl:for-each select="front/*[not(self::teiHeader)]">
            <xsl:copy-of select="."/>
        </xsl:for-each>
       <!-- <xsl:for-each select="front/div">
            <xsl:variable name="abstractLanguage" select="@lang"/>
            <xsl:variable name="divType" select="@type"/>
            <xsl:element name="div">
                <xsl:attribute name="type">
                    <xsl:value-of select="$divType"/>
                </xsl:attribute>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="$abstractLanguage"/>
                </xsl:attribute>
                <xsl:copy-of select="child::node()"/>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="front/note">
            <xsl:copy-of select="."/>
        </xsl:for-each>-->
    </xsl:template>
    
    <!-- BODY level -->
    <xsl:template name="BODY">
        <xsl:if test="body">
            <xsl:element name="body">
                <xsl:copy-of select="body/child::node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <!--== BACK level ==-->
    <xsl:template name="BACK">
        <xsl:if test="back">
            <xsl:element name="back">
                <xsl:copy-of select="back/child::node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <!--=== TEXT level : end ===-->
    <!--=== STDF level : start ===-->
    <!--<xsl:template match="stdf">
        <xsl:element name="ns:stdf">
            <xsl:copy-of select="*"/>
        </xsl:element>
    </xsl:template>-->
</xsl:stylesheet>
