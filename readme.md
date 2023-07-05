# STM8 terminal 

Un terminal ASCII réalisé sur une carte NUCLEO-S207K8

*   Affichage 40 caractères par ligne, 25 lignes 
*   Clavier PS/2 
*   TVout NTSC. 
*   interface UART niveaux 0:5 volts 


![schématique](terminal_schematic.png)


Ce terminal a été créé pour le projet [POMME-I](https://github.com/Picatout/pomme-I).

Les 2 cartes NUCLEO-8S207K8 communique entre elle via le UART. Voir la schématique complète du projet [POMME-I](https://github.com/Picatout/pomme-I) sur le déppôt github de ce dernier. 


## Quand il faut compter les cycles machines.

Sortir 40 caractères par ligne avec un MCU fonctionnant à 20Mhz en utilisant le protocole NTSC n'a pa été évident. Il n'y avait tout simplement pas suffisamment de temps pour utiliser des compteurs avec boucle. Le temps d'affichage d'une ligne de balayage NTSC est de 52µsec. 1 cycle cpu à 20Mhz dure 50nsec on dispose donc d'un maximum de 1040 cycles pour afficher les 40 caractères ce qui donne 26 cycles cpu par caractère.

Après plusieurs expérimentation avec le périphérique SPI qui ne donnait pas de résultat satisfaisant j'ai abandonné le SPI. Pour y parvenir j'ai fait 2 choses. 

1. Le tampon video **video_buffer** ne contient pas les caractères à afficher mais l'adresse du caractère dans la table **font_6x8**. Ainsi il n'y a pas de cycle perdu pour faire le calcul de l'adresse du caractère pendant l'affichage. C'est la routine **tv_putc** qui fait le travail. 

1. Pour sortir les pixels vidéos il faut sérialiser les pixels représentant le caractère. Faire ça en sorftware prend 14 cycles cpu avec la macro  **_shift_out_char** du fichier [tvout.asm](tvout.asm).
La macro **_shift_out_scan_line** prend 20 cycles au total en incluant **_shift_out_char**. Si on fait le calcul pour 40 caractères ça fait 800 cycles soit 40µsec. Bien en déça des 52µsec allouée. Ça c'est selon les cycles machines fournis par le manufacturier du STM8 mais en pratique la durée mesurée à l'oscilloscope est de 51.2µsec. C'est serré! Tellement serré que je ne pouvait utiliser des boucles avec compteurs. Pour arriver à ce temps j'ai du dérouler la macro 40 fois. 




