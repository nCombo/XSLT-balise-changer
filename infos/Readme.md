# TermITH


## **Programme**

### **Scenario 2**

Évaluation (texte par texte) de la pertinence des mots-clés tirés automatiquement par les robots du Lina .  
Avec comme référence et comparaison les mots clés INIST (Pascal,Francis) issus de ces même textes.

#### ***Phase 4***

- ***IDEFIX 7.11.1***
  https://github.com/termith-anr/idefix/releases/tag/v7.11.1

- ***4-6 METHODES***
  1. Notice&Body_TFIDF  
  2. Notice&Body_TOPICRANK  
  3. Notice&Body_TOPICRANK&TTC  
  4. Notice&Body_TOPICCORANK  
  5. Notice&Body_TOPICCORANK&TTC  
  6. Notice&Body_KEA  
    
  Attention : 2 & 1 ne sont pas présents en Linguistique

- ***ARTICLE  INTÉGRAL***

- ***TEI (2015/02/13***)
  Candidats termes dans des balises stdf  
    
  Originalement prévu : TEI PREMAFF

- ***CHIMIE / LINGUISTIQUE / SC. INFO***

- ***INIST***

	- ***Évaluateurs***

		- ***NATHALIE SABINE SIMONE VALERIE VERONIQUE***

- ***ATILF***

	- ***Évaluateurs***

		- ***CORNELIA***

#### ***Phase 3***

- ***IDEFIX 7.6.0***
  https://github.com/termith-anr/idefix/releases/tag/v7.6.0

- ***RÈSUMÈ***

- ***4-6 METHODES***
  1. Notice_TFIDF  
  2. Notice_TOPICRANK  
  3. Notice_TOPICRANK&TTC  
  4. Notice_TOPICCORANK  
  5. Notice_TOPICCORANK&TTC  
  6. Notice&Body_KEA  
    
  Attention : 2 & 1 ne sont pas présents en Linguistique

- ***TEI (2015/02/13***)
  Candidats termes dans des balises stdf

- ***ARCHÈOLOGIE / CHIMIE / LINGUISTIQUE / SC. INFO***

- ***INIST***

	- ***Évaluateurs***

		- ***BERNARD CORALIE NATHALIE SABINE SIMONE VALERIE VERONIQUE***

- ***ATILF***

	- ***Évaluateurs***

		- ***CORNELIA***

#### ***Phase 2***

- ***IDEFIX 7.0.0***
  https://github.com/termith-anr/idefix/releases/tag/v7.0.0

- ***LINGUISTIQUE***

- ***3 METHODES***
  1. Notice&Body_TFIDF  
  2. Notice&Body_TOPICRANK  
  3. Notice&Body_TOPICRANK&TTC

- ***ARTICLE  INTÉGRAL***

- ***TEI (2015/02/13***)
  Candidats termes dans des balises stdf

- ***INIST***

	- ***Évaluateurs***

		- ***SABINE***

#### ***Phase 1***

- ***IDEFIX 3.0***
  https://github.com/termith-anr/idefix/releases/tag/v3.0.0

- ***RÈSUMÈ***

- ***TEI (2014/11/01***)

- ***LINGUISTIQUE***

- ***2 METHODES***
  1. Notice_TFIDF_Nom&Adj  
  2. Notice_TOPICRANK_Nom&Adj

- ***INIST***

	- ***Évaluateurs***

		- ***SABINE***

### **Scenario 1**

Validation des termes à  ajouter dans les ressources terminologiques  
  
Utilisation de totem, d’excel et dans une moindre mesure d’ITM

## **Outils**

### **MergeXML3CSV1**

Script node permettant de reporter les résultats CSV de la phase 1 du scénario 2 dans des fichiers XML de phase 3 du sc2.  
  
Logiciel : https://github.com/termith-anr/mergePhase1and3

### **CorrespSmatiesConvert**

Script node permettant l’attribution de correspondant unique pour les fichiers Scénario 1   
  
Cause :  Passage version TTC termsuite 1.4->2.0  
  
Liens : https://github.com/termith-anr/CorrespSmartiesConversion

### **TOTEM**

Permet d’effectuer une recherche d’un mot dans un corpus tokenisé au format premaff.   
Il reçoit l'identifiant d'un terme desambiguisé et retourne les paragraphes (contextes) oû ce mot est situé  
  
Forme de concordancier  
  
Logiciel : http://github.com/termith-anr/totem

### **ITM**

Il nous permet d’effectuer des alignements grâce à  3 algos   
  
concrètement il compare des chaines de caractère et retourne une liste de match avec un score  
  
Algo :  
« SubsDist Name Alignment » SMOA  
- alignement sur chaÃ®ne de caractères  
- alignement en se basant sur les attributs de type Â« nom Â» seulement  
- les relations créées sont toujours des « exact match »  
- Ces 2 algorithmes ont sensiblement le même fonctionnement au sein d’ITM/ITM Match, mais avec 2 classes java différentes, donc des résultats légèrement différents  
AROMA  
- utilisation sur chaine de caractères et utilisation de la hiérarchie des termes  
- alignement en se basant sur les attributs de type « nom » et « texte »  
- les relations créées sont des « exact match »; « broader match », « narrow match »

### **IDEFIX**

Affiche les donnés d’un élément TEI , fichier par fichier  
  
Il permet aussi de jouer avec les mots-clés  
  
Tuto : https://termith-anr.github.io/scripts-formats/formation/  
  
Logiciel : https://github.com/termith-anr/idefix  
  
Guide : https://termith-anr.github.io/scripts-formats/guides/readme.pdf

## **Données**

### **XML**

#### **TEI**

- **v2015/06/10**

- **v2015/02/13**

- **v2014/11/01**

#### **TBX**

La liste des candidats termes du scénario 1 est en TBX  
  
Les ressources INIST (ML,MX ..) sont en TBX

#### **RDF**

Format d’entrée d’ITM ,.  
Prend obligatoirement un identifiant , une url .   
Peut prendre des variantes

#### **SKOS**

Format minimaliste .  
  
Mauvais en sortie d’ITM pour être exploiter car ne renvoie que les ID des match sans le score

#### **ALIGN**

Format propriétaire de mondera , ressors les ID match avec le score.

#### **TEI PREMAFF**

Ce format ne sera jamais utilisé le scénario 2 . II s’agit en revanche du format d’entrée obligatoire pour TOTEM

- **v2015/02/13**

#### **EOLOD**

Format propriétaire de mondera , ressors les ID match avec le score.

### **CSV**

