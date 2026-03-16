#!/bin/bash

cd packer-debian/

# 1. Initialiser les plugins (lit le fichier .pkr.hcl et télécharge les plugins nécessaires)
packer init .

# 2. Valider la syntaxe du template
packer validate .

# 3. Lancer le build (15 à 25 minutes selon ta machine)
packer build .

# 4. Vérifier que la box a bien été générée
ls -lh *.box

# 5. Enregistrer la box dans Vagrant
vagrant box add aukfood/debian12 debian12-base.box
vagrant box list

# 6. Tester la box dans Vagrant
mkdir test-box && cd test-box
vagrant init aukfood/debian12
vagrant up
vagrant ssh

