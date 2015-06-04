<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://standoff.proposal" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 27, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> combo</xd:p>
            <xd:p><xd:b>Organization:</xd:b>INIST-CNRS</xd:p>
            <xd:p>this styleSheet is used for corpora in TEI parsed by Grobid Tool</xd:p>
            <xd:p>this styleSheet uses template match and call-template method</xd:p>
            <xd:p>this styleSheet mapps teiHeader element in article to titlePage</xd:p>
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
            <xsl:element name="encodingDesc">
                <xsl:element name="projectDesc">
                    <xsl:element name="p">
                        <xsl:text>le présent document rassemblent des métadonnées sont issues de différents éditeurs: soit INIST-CNRS, soit de Canadian Journal of Chemestry, soit d'Elsevier ( à compléter avec Sabine) </xsl:text>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="editorialDecl">
                    <xsl:element name="normalization">
                        <xsl:element name="p">
                            <xsl:text>Les métadonnées issues de l'INIST figurent dans l'entête du présent document. Les métadonnées issues des éditeurs sont transférées vers l'élément titlePage</xsl:text>
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
        <!-- <xsl:copy-of select="."/> -->
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
            <xsl:value-of select="substring-before($filename, '.')"/>
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
                <xsl:copy-of select="child::node()[not(self::occupation)]"/>
                <xsl:if test="occupation">
                    <xsl:element name="note">
                        <xsl:attribute name="type">occupation</xsl:attribute>
                        <xsl:copy-of select="occupation/child::node()"/>
                    </xsl:element>
                </xsl:if>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="DOCDATE">
            <xsl:for-each select="front/teiHeader/fileDesc/publicationStmt/date">
                <xsl:element name="docDate">
                    <xsl:element name="date">
                        <xsl:for-each select="@*">
                            <xsl:attribute name="{name()}">
                                <xsl:value-of select="."/>
                            </xsl:attribute>
                        </xsl:for-each>
                        <xsl:copy-of select="child::text()"/> 
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
    </xsl:template>

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
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/idno">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/idno">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <!--<xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope">
                <xsl:variable name="biblscopeType" select="@type"/>
                <xsl:element name="biblScope">
                    <xsl:attribute name="unit">
                         <xsl:value-of select="$biblscopeType"/>
                     </xsl:attribute>
                    <xsl:copy-of select="child::text()"/>
                </xsl:element>
                </xsl:for-each>-->
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='vol']">
                <xsl:element name="biblScope">
                    <xsl:attribute name="unit"><xsl:text>vol</xsl:text></xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='vol']/child::text()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='issue']">
                <xsl:element name="biblScope">
                    <xsl:attribute name="unit"><xsl:text>issue</xsl:text></xsl:attribute>
                    <xsl:copy-of select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='issue']/child::text()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='fpage']">
                <xsl:variable name="page1" select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='fpage']"/>
            
                <xsl:if test="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='lpage']">
                    <xsl:variable name="page2" select="front/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type='lpage']"/>
                
                    <xsl:element name="biblScope">
                        <xsl:attribute name="unit"><xsl:text>page</xsl:text></xsl:attribute>
                            <xsl:value-of select="$page1"/><xsl:text>-</xsl:text><xsl:value-of select="$page2"/>
                    </xsl:element>
                </xsl:if>
            </xsl:if>
            
            <xsl:for-each select="front/teiHeader/fileDesc/sourceDesc/biblStruct/note">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="front/teiHeader/revisionDesc/change">
                <xsl:variable name="changeDate" select="@when"/>
                <xsl:element name="note">
                    <xsl:attribute name="type">revision</xsl:attribute>
                    <xsl:element name="date">
                        <xsl:attribute name="when"><xsl:value-of select="$changeDate"/></xsl:attribute>
                        <xsl:copy-of select="child::text()"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <!-- for CJC and Cairn -->
            <!--ajout systématique de lang xml:lang=fr-->
            <xsl:element name="lang">
                <xsl:attribute name="xml:lang">fr</xsl:attribute>
                <xsl:text>fr</xsl:text>
            </xsl:element>
            <!--<xsl:if test="front/teiHeader[@xml:lang='fr']">
                <xsl:variable name="teiHeaderLang" select="@xml:lang"/>
                <xsl:element name="lang">
                    <xsl:attribute name="xml:lang"><xsl:value-of select="$teiHeaderLang"/></xsl:attribute>
                    <xsl:value-of select="$teiHeaderLang"/>
                </xsl:element>
            </xsl:if>-->
            <!-- for Elsevier -->
        </xsl:element>
    </xsl:template>
    
    <!-- export textClass/keywords to a div element out of titlePage element -->
    <xsl:template name="DIV">
        <xsl:for-each select="front/teiHeader/profileDesc/textClass/keywords">
            <xsl:variable name="kwType" select="@type"/>
            <xsl:element name="div">
                <xsl:attribute name="type">keyword</xsl:attribute>
                <xsl:if test="$kwType != ''">
                    <xsl:attribute name="subtype"><xsl:value-of select="$kwType"/></xsl:attribute>
                </xsl:if>
                <xsl:element name="list">
                <xsl:if test="list/head">
                    <xsl:copy-of select="list/head"/>
                </xsl:if>
                    <xsl:for-each select="list/item/term">                        
                        <xsl:element name="item">
                            <xsl:copy-of select="child::text()"/>
                        </xsl:element>    
                    </xsl:for-each>
                </xsl:element>
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
</xsl:stylesheet>
