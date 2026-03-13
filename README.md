## TP Packer 

#### 1.1 - Qu'est-ce que Packer ?

HashiCorp Packer est un outil qui automatise la création d’artefacts (images machines) prêtes à être utilisées : images de VM, AMI AWS, images Docker, etc. 

Il appartient à la famille des outils d'IAAS / automatisation DevOps. Concrètement, il résout le problème de la création manuelle, lente et non reproductible de serveurs en permettant de décrire une image une fois dans un fichier de configuration, puis de générer la même image, de façon identique, pour plusieurs plateformes.

#### 1.2 - Le concept d'image immuable

Une image immuable est une image de VM ou de conteneur qui n’est jamais modifiée après sa création : si un changement est nécessaire, on génère une nouvelle image plutôt que de modifier celle en production. Cette approche est considérée comme une bonne pratique car elle évite des accidents en garantissant la cohérence entre environnements et en facilitant les déploiements reproductibles. Par exemple, un incident de production aurait pu être évité si un administrateur n’avait pas modifié manuellement un serveur en prod, créant un comportement différent de la préproduction : avec une image immuable, la modification aurait nécessité une nouvelle image testée avant déploiement.

#### 1.3 - Cas d'usage de Packer

| Scénario | Packer ? | Justification |
|---------|----------|---------------|
| Standardiser une image de base pour toute une équipe de développeurs | **O** | Packer crée des images reproductibles et standardisées pour tous les environnements. |
| Démarrer rapidement une VM de test et l’arrêter après utilisation | **N** | Cela relève de l’orchestration ou du cloud provisioning, pas de la création d’images. |
| Générer une AMI AWS prête à l’emploi pour un déploiement cloud | **O** | Packer est conçu pour construire automatiquement des AMI et autres images cloud. |
| Configurer dynamiquement une VM en cours d’exécution | **N** | Packer configure uniquement lors de la création de l’image, pas après le déploiement. D'où le principe d'image immuable. |
| Reproduire identiquement un environnement de CI/CD sur plusieurs machines | **O** | Une image immuable garantit que chaque machine CI/CD démarre avec la même configuration. |

---

