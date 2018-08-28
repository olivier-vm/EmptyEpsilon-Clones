--[[ Transark
--]]

transark = FactionInfo():setName("Transark")
transark:setGMColor(0, 0, 255)
transark:setDescription([[La conduite ou le pilotage de n'importe quel véhicule à moteur (de l'explobuggy au bike en passant par le cargo spatial) passe par l'obtention d'un permis Transark.

Les membres de Transark sont ceux qui transportent les gens et les marchandises dans toutes les arches.]])

--[[ Utanscale
--]]

utanscale = FactionInfo():setName("Utanscale")
utanscale:setGMColor(255, 255, 0)
utanscale:setDescription([[Les Scalers veillent au maintien d'une économie saine et dirigée vers le bien commun.

C'est parmi eux qu'on retrouve tous les commerçants, quelle que soit leur activité, mais aussi ceux qui encadrent l'économie et rendent possibles les projets locaux.]])

--[[ Technocorp
--]]

technocorp = FactionInfo():setName("Technocorp")
technocorp:setGMColor(255, 102, 0)
technocorp:setDescription([[Tout ce qui se construit, s'entretient et se répare passe par les mains habiles et les esprits ingénieux des Technos.

Du bricolage de fortune à la haute technologie, c'est un travail varié qui vous amènera également à côtoyer de nombreuses personnes et patries.

Infrastructure, gros matériel mais aussi électronique de pointe, les Technos sont au cœur de toute production.]])


--[[ Trigone
--]]

trigone = FactionInfo():setName("Trigone")
trigone:setGMColor(0, 255, 255)
trigone:setDescription([[Si vous êtes prêt(e)s à aider directement les individus en leur donnant la sécurité et l'assistance nécessaire à leur bien-être, le Trigone est fait pour vous.

Il se compose de trois entités opérationnelles.

L'Armée, L'Ordre et les Secours.]])

--[[ Polaris
--]]

polaris = FactionInfo():setName("Polaris")
polaris:setGMColor(0, 255, 0)
polaris:setDescription([[Polaris est la centralisation, à la Source, de toute recherche et développement des technologies dites "hyper" (celles laissées par les premiers hommes qui étaient plus avancés que nous en la matière).

Au-delà de ça, Polaris est aussi la plateforme inter-arche où les esprits les plus affûtés et créatifs se rassemblent afin de tenter de trouver une solution aux nombreux problèmes qui bloquent l'évolution de notre société.

Ce qui s'y fait et s'y passe demeure classifié mais il n'est pas rare que certaines de leurs publications permettent de faire des progrès considérables en certaines matières (c'est grâce à eux notament que le procédé RLS a pu voir le jour afin de garantir des vitesses impressionantes lorsqu'il s'agit de voyager au sein d'une même arche).]])

--[[ Les insurgés
--]]

insurge = FactionInfo():setName("Insurgés")
insurge:setGMColor(255, 0, 0)
insurge:setEnemy(transark)
insurge:setEnemy(technocorp)
insurge:setEnemy(utanscale)
insurge:setEnemy(trigone)
insurge:setEnemy(polaris)
insurge:setDescription([[Ce terme regroupe en fait bon nombre d'individus ainsi que leurs différentes pratiques.

Qu'on les appelle localement pirates, pillards, charognards, malfrats ou autre, le fond reste toujours le même.

Ils ont décidé de vivre aux dépens de la communauté en lui prenant, souvent par la force ou par la ruse, ce dont ils ont besoin.

Hormis les dangers liés à la faune locale, ce sont eux qui représentent le plus grand danger dans tout secteur peu peuplé.

Au contraire des Intouchables qui vivent en harmonie avec la société, les insurgés ont fait le choix de lui nuire.]])

--[[ La menace
--]]

menace = FactionInfo():setName("La Menace")
menace:setGMColor(255, 0, 0)
menace:setEnemy(transark)
menace:setEnemy(technocorp)
menace:setEnemy(utanscale)
menace:setEnemy(trigone)
menace:setEnemy(polaris)
menace:setDescription([[Groupe d'insurgés identifié au sein de Khayyam. Leurs méfaits sont fort médiatisés.]])

--[[ Neutre
--]]

neutre = FactionInfo():setName("Neutre")
neutre:setGMColor(128, 128, 128)
neutre:setDescription([[Neutre]])