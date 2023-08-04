### 2023-08-04

* Modifié le caractère soulignement dans le fichier [font.asm](font.asm).

### 2023-08-02

* V1.0R10 

* Ajout de la commande ANSI  **ESC[6n** qui renvoie la position du curseur sous la forme: **ESC[n;mR**

* Ajout de la commande d'application **ESC_V** pour demander au terminal d'imprimer la version de son firwmare.


### 2023-07-31

* V1.0R9  Ajout de la commande ANSI 
    * **ESC_ C** qui retourne le caractère à la position du curseur.

* Ajout des séquences de contrôle ANSI suivantes:
    * **ESC[ s**  pour sauvegarder la position actuelle du curseur.
    * **ESC[ u**  pour restaurer la position du curseur sauvegardée avec **ESC[ s**.

### 2023-07-29

* Ajout des séquences de contrôle ANSI suivantes:
    * ESC[ n A  déplace le curseur de *n* lignes vers le haut.
    * ESC[ n B  déplace le curseur de *n* lignes vers le bas.
    * ESC[ n C  déplace le curseur de *n* colonnes vers la droite.
    * ESC[ n D  déplace le curseur de *n' colonnes veres la gauche. 

Pour toutes ces commandes la valeur par défaut de *n' est **1**. Si le curseur est déjà à la limite la commande est ignorée.    

### 2023-07-22

* Révision 6 

* Modifié [tv_term.asm](tv_term.asm) pour que le caractère sous le curseur soit préservé.

* Modification à la routine *process_csi* du fichier [tv_term.asm](tv_term.asm). Le problème est le suivant, à l'interne les valeurs de position du curseur son comptée à partir de zéro alors que la commande **LOCATE** de **POMME BASIC** compte à partir de **1** comme les commandes ANSI. Il faut donc décrémenter la valeur des paramètres avant de les appliquer. Je n'avais pas tenu compte de ça dans la première écriture de la routine.

### 2023-07-21 

* Ajout des séquences de contrôle suivantes:
    * **ESC [ Pn G**  pour positionné le curseur sur la colonne **Pn** {1..62} 
    * **ESC [ Pn d**  pour positionner le curseur sur la ligne **Pn** {1..25}
    * **ESC [ Pn ; Pm H** pour positionner le curseur à la ligne **Pn** et la colonne **Pm**.

### 2023-07-17 

* L'intégration du **STM8_terminal** avec l'ordinateur **POMME-I** a nécessité des modifications aux 2 projets. Durant certaines opérations du terminal ce dernier perdait des caractères envoyés par l'ordinateur. Le problème a été corrigé par l'ajout d'un contrôle de flux matériel appellé **DTR** pour *Data Terminal Ready*. l'ordinateur n'envoie des caractères au terminal que lorsque ce signal est à **0** volt.

* Corrigé bogue dans routine *if_shifted* du fichier [ps2.asm](ps2.asm).

* Le terminal n'était pas assez rapide pour capturer tous les caractères reçus du UART. 
    * vitesse du UART réduite à 38400BAUD 
    * Ajout d'une sortie **DTR** sur la broche **D6** 
    * Augmentation de la file du UART à 64 charactères.
    * Augmentation de la file des scan codes à 16 octets.
    * mise à jour révision vers V1.0R2 
    
### 2023-07-10

* Nouvelle tentative d'urtiliser le périphérique SPI dans tvout.asm
    * Succès, même que le nombre de caractères affichable par ligne est passé à 64.
    * Les caractères s'affichent plus nettement, intensité plus régulière.

### 2023-07-05

* Modification de *uart_init* pour lire les switches SW4 et SW5 pour déterminer le BAUD requis.

* Modification de la routine *ntsc_init* pour copier la table *font_6x8* dans la RAM et vérifier l'état de SW3 pour l'écho local.

* Modification au circuit du terminal par l'ajout de commutateurs externes pour les options.

    * **SW3** sélection de l'écho local. 
        **0** pas d'écho locale 
        **1** échoe locale 

    * **SW5** et **SW5** sélection du BAUD rate du UART.

    SW4|SW5|BAUD 
    -|-|-
    0|0| 9600
    0|1| 19200
    1|0| 38400
    1|1| 115200

* Continuation du travail sur [ps2.asm](ps2.asm). 
    * installation de la police de caractères [font_6x8](font.asm) en mémoire RAM. Ceci permet de sauver 2µsec par scan line dans l'interruption d'affichage vidéo **ntsc_video_interrupt**.

    * Ajout du traitement pour les altérations de caractères du aux touches **CTRL** et **ALT**. Les touches de gauche et de droite sont traitées de la même façon.

    * Ajout de la commande **CTLR+E** pour commuter (toggle) l'écho local sur stm8_terminal. 

* mise à jour du [readme.md](readme.md).

### 2023-07-04

* Avancement du travail sur [ps2.asm](ps2.asm), traite les touches **Ver. maj.** et  **Maj.** correctement. Reste à implémentater le traitement des touches **CTRL** et **ALT**. 

* Travail sur [ps2.asm](ps2.asm).

### 2023-07-03 

* Début du travail sur [ps2.asm](ps2.asm).

* Corrigé bogue dans *tv_cursor_right*. 

* Corrigé bogue dans *tv_disable_cursor*. 

*  Travail sur [tvout.asm](tvout.asm), j'ai trouvé une méthode pour permettre d'afficher 40 caractères par ligne. Le tampon vidéo contient l'adresse du caractère dans la table de la police, plutôt que le caractère lui-même. De cette façon cette adresse n'a pas besoin d'être calculé au moment de l'affichage. On sauve ainsi plusieurs cycles machines par caractère. De plus l'espace entre chaque caractère est plus étroit ce qui améliore l'apparence.

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

