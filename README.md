# SACCO_Lab2 – « Let’s count stuff »
## A. Introduction

L’objectif de ce TP était d’implémenter un compteur que l’on verrait s’incrémenter grâce aux afficheurs 7 segments. Dans un premier temps, on verra comment a été structurée l’architecture du système ainsi que le code C associé, dans le cadre d’un compteur décimal n’utilisant qu’un unique afficheur 7 segments.  Ensuite, on verra comment la structure a été adaptée pour réaliser cette fois-ci un compteur utilisant 3 afficheurs 7 segments, ainsi que le code C associé. On présentera tout d’abord le fonctionnement à l’aide de boucles imbriquées puis via l’utilisation de timer.

## B. Compteur 1 Digit 
### 1. System Architecture
#### 1.1 Design QSYS

Pour ce compteur d’une unité, j’ai choisi de structurer mon architecture comme suivant :
![LAB2_SCHEMA](https://user-images.githubusercontent.com/104905653/212286973-e9c97e0d-f328-4485-9cc4-e3ab166f0520.png)

J'utilise donc les blocs IPs suivants:
 * NIOS2
 * JTAG-UART
 * RAM: Je n’ai pas eu à modifier sa valeur
 * 1 PIO de largeur 4 bits

J’ai par la suite ouvert Platform Designer pour relier l’ensemble, en ajoutant également une horloge pour cadencer le système. Après avoir assigner les adresses de base, j’obtiens le schéma suivant :
[INSERER IMAGE QSYS]
J’ai ensuite sauvegardé et générer mon HDL. Sous Quartus, il a maintenant fallu créer le composant permettant de convertir les chiffres binaires en chiffres affichables sur l’afficheur 7 segments. Pour cela, j’ai simplement regardé dans le Guide Utilisateur comment les LEDs de l’afficheur était organisé, de sorte que lorsque j’ai un certain chiffre en entrée, mon composant allume les leds nécessaire pour afficher ce chiffre. Ce composant reçoit donc en entrée un chiffre codé sur 4 bits et renvoie, vers l’afficheur, un mot de 8 bits. Il était toutefois possible de ne renvoyer qu’un mot de 7bits, car le dernier bit correspond à la virgule, que l’on n’utilise jamais pour cet exercice.

En me référant encore une fois au Guide Utilisateur, j’ai ensuite pu effectuer mon Pin Assignement, comme décrit ci-dessous :

[INSERER IMAGE PIN ASSIGNEMENT]

Une fois cela fait, je peux passer à la programmation de mon FPGA et à l’écriture du code C.

### 1.2 Programmation C
Je crée tout d’abord un répertoire software, ainsi que 2 sous-répertoires, app/ et bsp/  afin d’améliorer la clarté du projet. En utilisant les commandes vues en cours, je génère donc le BSP et je passe à l’écriture du code C. Comme il ne s’agit ici que d’un compteur sur une unité, c’est assez simple. Je n’ai qu’une boucle for, qui, à chaque itération, affecte sur la sortie de mon NIOS2, la valeur du compteur. Cette valeur arrive ensuite sur l’entrée de mon fichier bin-to-7seg, qui la convertit ensuite de sorte que la valeur du compteur puisse être affiché sur l’afficheur 7 segments. A chaque affectation, la vitesse de mon compteur est calibrée via l’appel de la fonction usleep()
###2. Progress & Results
Voici une démonstration ci-dessous :

## C. Compteur 3 digits
### 1. System Architecture
### 1.1 Design QSYS
### 1.2 Programmation C
#### 1.2.1 Boucles imbriquées
#### 1.2.2 Utilisation d’un Timer





