### 2023-07-02

* Travail sur [tvout.asm](tvout.asm), amélioration au prix de la réduction du nombre de caractère par ligne 34 au lieu de 40. 

 * Abandon de l'utilisation du périphérique SPI. 

 * les pixels sont sérialisés avec déroulement des boucles en utilisant des macros. C'est la seule façon de réduire le nombre de cycles machine par pixel. Avec cette méthode j'obtient 28 cycles par pixel. 7 pixels par caractères sont envoyés.

### 2023-07-01

 * Ajout de [tv_term.asm](tv_term.asm). Encore un problème avec la qualité de l'affichage sur la tV.

 * Travail sur [tvout.asm](tvout.asm), maintenant affiche les caractères presque correctement sauf qu'il en affiche 41 par ligne au lieu d 40. 
 l'affichage ne semble pas tenir compte des scan_lines!!.

### 2023-06-29

* Travail sur [tvout.asm](tvout.asm)

### 2023-06-28

* Démarrage du projet. 

