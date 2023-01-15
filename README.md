# SACCO_Lab2 – « Let’s count stuff »
## A. Introduction

L’objectif de ce TP était d’implémenter un compteur que l’on verrait s’incrémenter grâce aux afficheurs 7 segments. Dans un premier temps, on verra comment a été structurée l’architecture du système ainsi que le code C associé, dans le cadre d’un compteur décimal n’utilisant qu’un unique afficheur 7 segments.  Ensuite, on verra comment la structure a été adaptée pour réaliser cette fois-ci un compteur utilisant 3 afficheurs 7 segments, ainsi que le code C associé. Ce dernier permettra également d'illustrer le fonctionnement d'un timer.

## B. Compteur 1 Digit 
### 1. System Architecture
#### 1.1 Design QSYS

Pour ce compteur d’une unité, j’ai choisi de structurer mon architecture comme suivant :

![LAB2_SCHEMA_Timer](https://user-images.githubusercontent.com/104905653/212535752-140cd2fe-5ca3-48a9-b1dc-3a30fb0cad03.png)

J'utilise donc les blocs IPs suivants:
 * NIOS2
 * JTAG-UART
 * RAM: Je n’ai pas eu à modifier sa valeur
 * 1 PIO de largeur 4 bits

J’ai par la suite ouvert Platform Designer pour relier l’ensemble, en ajoutant également une horloge pour cadencer le système. Après avoir assigner les adresses de base, j’obtiens le schéma suivant :

![QSYS_1digit](https://user-images.githubusercontent.com/104905653/212292982-54f5b51f-dc4f-495f-b0de-4c5ff556a9ad.PNG)

J’ai ensuite sauvegardé et générer mon HDL. Sous Quartus, il a maintenant fallu créer le composant permettant de convertir les chiffres binaires en chiffres affichables sur l’afficheur 7 segments. Pour cela, j’ai simplement regardé dans le Guide Utilisateur comment les LEDs de l’afficheur était organisée, de sorte que lorsque j’ai un certain chiffre en entrée, mon composant allume les leds nécessaire pour afficher ce chiffre. Ce composant reçoit donc en entrée un chiffre codé sur 4 bits et renvoie, vers l’afficheur, un mot de 8 bits. Il était toutefois possible de ne renvoyer qu’un mot de 7bits, car le dernier bit correspond à la virgule, que l’on n’utilise jamais pour cet exercice.

En me référant encore une fois au Guide Utilisateur, j’ai ensuite pu effectuer mon Pin Assignement, comme décrit ci-dessous :

![Pin_planner_lab2_1digit](https://user-images.githubusercontent.com/104905653/212293296-91152353-7929-49e1-953f-6f0e348f9e8e.png)

Une fois cela fait, je peux passer à la programmation de mon FPGA et à l’écriture du code C.

### 1.2 Programmation C
Je crée tout d’abord un répertoire software, ainsi que 2 sous-répertoires, app/ et bsp/  afin d’améliorer la clarté du projet. En utilisant les commandes vues en cours, je génère donc le BSP et je passe à l’écriture du code C. Comme il ne s’agit ici que d’un compteur sur une unité, c’est assez simple. Je n’ai qu’une boucle for, qui, à chaque itération, affecte sur la sortie de mon NIOS2, la valeur du compteur. Cette valeur arrive ensuite sur l’entrée de mon fichier bin-to-7seg, qui la convertit ensuite de sorte que la valeur du compteur puisse être affiché sur l’afficheur 7 segments. A chaque affectation, la vitesse de mon compteur est calibrée via l’appel de la fonction usleep()

###2. Progress & Results
Voici une démonstration ci-dessous :

## C. Compteur 3 digits
### 1. System Architecture
### 1.1 Design QSYS

La structure finale du système est représentée par le schéma ci-contre:

![LAB2_SCHEMA_Timer](https://user-images.githubusercontent.com/104905653/212535696-5cf86cf2-5af1-4721-89ca-e9d7e43ffcbd.png)

J'ai choisi ici d'utiliser une seule PIO de largeur 12 bits, et non pas 3 PIO de largeur 4 bits. La sortie de mon NIOS2 est donc directement affectée à 3 signaux de largeur 4 bits: un pour le chiffre des unités, un pour le chiffre des dizaines et un pour le chiffre des centaines. Ensuite, chacun des 3 signaux arrive en entrée sur mon composant bin_to_7seg. 
De plus, il y a désormais un timer, afin d'incrémenter mon timer toutes les secondes. J'obtiens finalement l'architecture suivante:

![QSYS_Timer](https://user-images.githubusercontent.com/104905653/212536190-94ba0d77-e70f-4fdc-9ba4-9d29c70ad16d.PNG)

Afin de savoir quelle LEDs de l'afficheur 7 segment doivent s'allumer, je me suis référer au Guide Utilisateur, ce qui m'a permis d'obtenir le Pin Planner suivant:

![PINPLANNER](https://user-images.githubusercontent.com/104905653/212535991-7fffdb73-9fd7-4f4e-8154-3325fb64ec03.PNG)

### 1.2 Programmation C

Après avoir généré mon BSP, je passe à l'écriture de mon code C. Avant d'utiliser mon Timer, j'avais réalisé le compteur 3 bits à l'aide de 3 boucles for imbriquées. Cependant, avec le compteur, cela n'est plus possible. A la place, j'ai raisonné de la manière suivante:
* Lorsque les 4 premiers bits de mon signal, i.e. le chiffres des unités, valent 1010, soit 10 en décimale, cela signifie que les 4 bits correspondant au dizaine doivent s'incrémenter et valoir 0001. Pour faire cela, il suffit d'ajouter 6 à mon signal, de sorte que l'on ait 10+6 = 16, soit, en binaire, 0000 1010 + 0110 = 0001 0000.
* De même, lorsque mon compteur vaut 0000 1010 0000 = 160 en décimale, il faut incrémenter de 1 le chiffre des centaines. Cette fois-ci, on ajoute 96 à notre signal, de sorte que l'on ait 160 + 96 = 256, donc 0000 1010 0000 + 0000 0110 0000 = 0001 0000 0000.

Le fonctionnement décrit-ci dessus est situé dans ma routine d'interruption timer_irq(), qui s'executera toutes les secondes. Pour cela, il suffit d'initialiser mon timer via la ligne suivante:
` alt_irq_register(TIMER_0_IRQ,NULL,timer_irq); `

## 2. Progress & Results

Le fonctionnement est illustré par la vidéo ci-dessous:

https://user-images.githubusercontent.com/104905653/212538150-ea0c1cfc-68b8-4120-bd71-dc9498d38845.mp4

## Conclusion

Ce TP avait pour objectif final de créer un compteur de 3 chiffres s'incrémentant toutes les secondes grâce à un timer et d'afficher sa valeur sur l'afficheur 7 segments. Cet objectif a donc été atteint. Durant ce TP, j'ai pu continuer de prendre en main Platform Designer avec cette fois-ci un réel aspect co-design, grâce à la présence d'un composant bin_to_7seg. J'ai également pu travailler sur la manipulation de bits grâce à mon système de comptage consistant à ajouter certaines valeurs à mon compteur. Enfin, cela a également été l'occasion d'utiliser des interruptions, cette fois-ci sous la forme de timer.
