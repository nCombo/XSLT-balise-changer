# TermITH


## **Programme**

### **Scenario 1**

Validation des termes à ajouter dans les ressources terminologiques 

### **Scenario 2**

Évaluation (texte par texte) de la pertinence des mots-clés de tirés automatiquement par les robots du Lina .  
Avec comme  référence et comparaison  les mots clés INIST (Pascal,Francis) issus de ces même texte.

#### ***Phase 1***

- **RÈSUMÈ**

- **2 METHODES**
  1. Notice_TFIDF_Nom&Adj  
  2. Notice_TOPICRANK_Nom&Adj

- **LINGUISTIQUE**

- **TEI (2014/11/01**)

- **INIST**

	- ***Évaluateurs***

		- **SABINE**

- **IDEFIX**

#### ***Phase 2***

- **ARTICLE  INTÉGRAL**

- **3 METHODES**
  1. Notice&Body_TFIDF  
  2. Notice&Body_TOPICRANK  
  3. Notice&Body_TOPICRANK&TTC

- **LINGUISTIQUE**

- **TEI (2015/02/13**)
  Candidats termes dans des balises stdf

- **INIST**

	- ***Évaluateurs***

		- **SABINE**

- **IDEFIX**

#### ***Phase 3***

- **RÈSUMÈ**

- **4-6 METHODES**
  1. Notice_TFIDF  
  2. Notice_TOPICRANK  
  3. Notice_TOPICRANK&TTC  
  4. Notice_TOPICCORANK  
  5. Notice_TOPICCORANK&TTC  
  6. Notice&Body_KEA  
    
  Attention : 2 & 1 ne sont pas présents en Linguistique

- **ARCHÈOLOGIE / CHIMIE / LINGUISTIQUE / SC. INFO**

- **TEI (2015/02/13**)
  Candidats termes dans des balises stdf

- **INIST**

	- ***Évaluateurs***

		- **BERNARD CORALIE NATHALIE SABINE SIMONE VALERIE VERONIQUE**

- **ATILF**

	- ***Évaluateurs***

		- **CORNELIA**

- **IDEFIX**

#### ***Phase 4***

- **ARTICLE  INTÉGRAL**

- **4-6 METHODES**
  1. Notice&Body_TFIDF  
  2. Notice&Body_TOPICRANK  
  3. Notice&Body_TOPICRANK&TTC  
  4. Notice&Body_TOPICCORANK  
  5. Notice&Body_TOPICCORANK&TTC  
  6. Notice&Body_KEA  
    
  Attention : 2 & 1 ne sont pas présents en Linguistique

- **CHIMIE / LINGUISTIQUE / SC. INFO**

- **TEI (2015/02/13**)
  Candidats termes dans des balises stdf  
    
  Originalement prévu : TEI PREMAFF

- **INIST**

	- ***Évaluateurs***

		- **NATHALIE SABINE SIMONE VALERIE VERONIQUE**

- **ATILF**

	- ***Évaluateurs***

		- **CORNELIA**

- **IDEFIX**

### **Scenario 3**

## **Outils**

### **ITM**

Il nous permet d’effectuer des alignements grâce à 3 algo   
  
Concrètement il compare des chaines de caractère et retourne une liste de match avec un score

### **IDEFIX**

Affiche les données d’un élément TEI , fichier par fichier  
  
Il permet aussi de jouer avec les mots-clés  
  
Tuto : [https://termith-anr.github.io/scripts-formats/formation/](https://termith-anr.github.io/scripts-formats/formation/)  
  
Logiciel : [https://github.com/termith-anr/idefix](https://github.com/termith-anr/idefix)  
  
Guide : [https://termith-anr.github.io/scripts-formats/guides/readme.pdf](https://termith-anr.github.io/scripts-formats/guides/readme.pdf)

### **TOTEM**

Permet d’effectuer une recherche d’un mot dans un corpus tokenisé au format premaff.   
Il reçoit l’identifiant d’un terme desambiguisé et retourne les paragraphes (contextes) ou ce mot est situé

## **Données**

### **XML**

#### **TEI**

- **v2014/11/01**

- **v2015/02/13**

- **v2015/06/10**

#### **TBX**

La liste des candidats termes du scénario 1 est en TBX  
  
Les ressources INIST (ML,MX ..) sont en TBX

#### **TEI PREMAFF**

Ce format ne sera jamais utilisé le scénario 2 . II s’agit en revanche du format d’entrée obligatoire pour TOTEM

- **v2015/02/13**

#### **SKOS**

Format minimaliste .  
  
Mauvais en sortie d’ITM pour être exploiter car ne renvoie que les ID des match sans le score

#### **RDF**

Format d’entrée d’ITM ,.  
Prend obligatoirement un identifiant , une url .   
Peut prendre des variantes

#### **ALIGN**

Format propriétaire de mondera , ressors les ID match avec le score.

#### **EOLOD**

Format propriétaire de mondera , ressors les ID match avec le score.

### **CSV**

