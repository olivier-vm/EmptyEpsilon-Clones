--[[ Transark
--]]

transark = FactionInfo():setName("Transark")
transark:setGMColor(0, 0, 255)
transark:setDescription([[La conduite ou le pilotage de n'importe quel vehicule a moteur (de l'explobuggy au bike en passant par le cargo spatial) passe par l'obtention d'un permis Transark.

Les membres de Transark sont ceux qui transportent les gens et les marchandises dans toutes les arches.]])

--[[ Utanscale
--]]

utanscale = FactionInfo():setName("Utanscale")
utanscale:setGMColor(255, 255, 0)
utanscale:setDescription([[Les Scalers veillent au maintien d'une economie saine et dirigee vers le bien commun.

C'est parmi eux qu'on retrouve tous les commercants, quelle que soit leur activite, mais aussi ceux qui encadrent l'economie et rendent possibles les projets locaux.]])

--[[ Technocorp
--]]

technocorp = FactionInfo():setName("Technocorp")
technocorp:setGMColor(255, 102, 0)
technocorp:setDescription([[Tout ce qui se construit, s'entretient et se repare passe par les mains habiles et les esprits ingenieux des Technos.

Du bricolage de fortune a la haute technologie, c'est un travail varie qui vous amenera egalement a cotoyer de nombreuses personnes et patries.

Infrastructure, gros materiel mais aussi electronique de pointe, les Technos sont au cœur de toute production.]])


--[[ Trigone
--]]

trigone = FactionInfo():setName("Trigone")
trigone:setGMColor(0, 255, 255)
trigone:setDescription([[Si vous etes pret(e)s a aider directement les individus en leur donnant la securite et l'assistance necessaire a leur bien-etre, le Trigone est fait pour vous.

Il se compose de trois entites operationnelles.

L'Armee, L'Ordre et les Secours.]])

--[[ Polaris
--]]

polaris = FactionInfo():setName("Polaris")
polaris:setGMColor(0, 255, 0)
polaris:setDescription([[Polaris est la centralisation, a la Source, de toute recherche et developpement des technologies dites "hyper" (celles laissees par les premiers hommes qui etaient plus avances que nous en la matiere).

Au-dela de ca, Polaris est aussi la plateforme inter-arche ou les esprits les plus affûtes et creatifs se rassemblent afin de tenter de trouver une solution aux nombreux problemes qui bloquent l'evolution de notre societe.

Ce qui s'y fait et s'y passe demeure classifie mais il n'est pas rare que certaines de leurs publications permettent de faire des progres considerables en certaines matieres (c'est grâce a eux notament que le procede RLS a pu voir le jour afin de garantir des vitesses impressionantes lorsqu'il s'agit de voyager au sein d'une meme arche).]])

--[[ Les insurges
--]]

insurge = FactionInfo():setName("Insurges")
insurge:setGMColor(255, 0, 0)
insurge:setEnemy(transark)
insurge:setEnemy(technocorp)
insurge:setEnemy(utanscale)
insurge:setEnemy(trigone)
insurge:setEnemy(polaris)
insurge:setDescription([[Ce terme regroupe en fait bon nombre d'individus ainsi que leurs differentes pratiques.

Qu'on les appelle localement pirates, pillards, charognards, malfrats ou autre, le fond reste toujours le meme.

Ils ont decide de vivre aux depens de la communaute en lui prenant, souvent par la force ou par la ruse, ce dont ils ont besoin.

Hormis les dangers lies a la faune locale, ce sont eux qui representent le plus grand danger dans tout secteur peu peuple.

Au contraire des Intouchables qui vivent en harmonie avec la societe, les insurges ont fait le choix de lui nuire.]])

--[[ La menace
--]]

menace = FactionInfo():setName("La Menace")
menace:setGMColor(255, 0, 0)
menace:setEnemy(transark)
menace:setEnemy(technocorp)
menace:setEnemy(utanscale)
menace:setEnemy(trigone)
menace:setEnemy(polaris)
menace:setDescription([[Groupe d'insurges identifie au sein de Khayyam. Leurs mefaits sont fort mediatises.]])

--[[ Neutre
--]]

neutre = FactionInfo():setName("Neutre")
neutre:setGMColor(128, 128, 128)
neutre:setDescription([[Neutre]])
