--[[
	Everything in the science database files is just readable data for the science officer.
	This data does not affect the game in any other way and just contributes to the lore.
--]]
space_objects = ScienceDatabase():setName('Cosmos')
item = space_objects:addEntry('Asteroide')
item:setLongDescription([[Les asteroides sont assimilables a des planetes mineures, generallement d'un diametre depassant rarement les quelques kilometres. Les variantes plus grosses sont parfois appelees planetoides]])

item = space_objects:addEntry('Micro-nebuleuse')
item:setLongDescription([[On entend par nebuleuse toute region du milieu interstellaire particulierement riche soit en gaz (le plus souvent de l'hydrogene), soit en poussiere interstellaire, soit des deux. Les nebuleuses peuvent former des systemes d'etoiles en s'effondrant gravitationnellement.

La taille des nebuleuses est gigantesque. Un nuage s'etend sur des espaces joignant plusieurs etoiles.

Il arrive, en navigant, de tomber sur des phenomene ponctuels reprenant les caracteristiques d'une nebuleuse, sur des tailles a l'echelle des vaisseaux. Des tailles de plusieurs dizaine d'unites de distance de voyage spatiale. On appelle couremment ces phenomenes des micro-nebuleuses.

A cause de la nature gazeuse et des particules contenues dans ces micronebuleuses, la plupart des technologies de scan et de radar utilisees en astronavigation ne peuvent penetrer ces nuages. Les officiers scientifiques de l'equipage doivent alors se fier aux sondes et a leurs observations visuelles.]])

item = space_objects:addEntry('Micro singularite')
item:setLongDescription([[Abusivement communement appelees mini trou noir. Il s'agit de zone de l'espace ayant un comportement ressemblant a un trou noir mais sur une etendue bien plus reduite, qui n'affecte que son environnement proche. Les forces gravitationnelles a leurs abords sont gigantesques. Ces micro-singularites ne s'etendent pas, ne grossissent pas, et leur masse ne semble pas augmenter malgre ce qu'elles absorbent (d'apres des mesures effectuees par des unites specialisees de Mobius). Elles restent permanente (semble-t-il).

Il pourrait s'agir de reliquat ou d'effet de bord de technologies oubliees des "Premiers". Des restes remanents de guerres spatiales du passe. Comme des sortes de mines gravitationnelles.

D'autre theories parlent d'un lien direct avec LA singularite qui est apparue aux abords de Khayyam. Il s'agirait d'une manifestation indirecte de cette singularite, qui s'etend donc bien au dela de sa position.

Les micro-singularites n'apparaissent que sur les detecteurs radars, elles n'ont pas d'apparence visuelle, puisqu'elles absorbent tout ce qui passe a leur portee (on ne voit que du noir... dans le noir vide de l'espace).]])


--item = space_objects:addEntry('Wormhole')
--item:setLongDescription([[A wormhole, also known as an Einstein-Rosen bridge, is a phenomena that connects two points of spacetime. WARP drives operate in a similar fashion, but instead of being created at will, a wormhole occupies a specific location in space. Objects that enter a wormhole instantaneously emerge from the other end, which might be anywhere from a few feet to thousands of light years away.
--
--Wormholes are rare, and most can move objects in only one direction. Traversable wormholes, which are stable and allow for movement in both directions, are even rarer. All wormholes generate tremendous sensor activity, which an astute science officer can detect even through disruptions such as nebulae.]])

----------

weapons = ScienceDatabase():setName('Armement')
item = weapons:addEntry('Missile a guidage')
item:addKeyValue('Portee', '5.4u')
item:addKeyValue('Degats', '35')
item:setLongDescription([[Il s'agit d'un missile a asservissement de trajectoire. Il est le cheval de bataille dans l'arsenal de combat. Sa taille lui permet de se loger aussi bien dans des fregates que de plus lourds vaisseaux. Il est souvent utilise dans plus d'un tube lanceur.

L'autoguidage (apres ciblage d'un ennemi) permet au missile de se deplacer de facon totalement automatique, sans necessiter d'operateur ("tire et oublie"). Le composant du missile servant a detecter la cible est l'autodirecteur ("tete chercheuse" dans le langage commun).

Il est possible aussi de travailler en mode de "teleguidage indirect", dans lequel l'artilleur donne une direction fixe au missile, et modifie sa trajectoire pendant le tir.]])

item = weapons:addEntry('Nano')
item:addKeyValue('Portee', '5.4u')
item:addKeyValue('Rayon explosion', '1u')
item:addKeyValue('Degats au centre', '160')
item:addKeyValue('Degats aux bords', '30')
item:setLongDescription([[Le terme officiel est MG-ELNP, un Missile Guide a Expulsion Localisee de Nano Particules.

Ce type d'arme tres dangereuse n'est utilisee que dans les situations imperieuses. Comme le missile a guidage classique, le "nano" (MG-ELNP) peut cibler et suivre un ennemi, mais il tourne et et se deplace plus lentement.

Son explosion libere un nuage de nanos qui penetre dans le vaisseau et "ronge" literallement instantanement la structure de la coque, provoquant une implosion immediate sur les petits vaisseaux, tandis que les plus gros subissent de tres gros dommages.

Si plusieurs vaisseaux se trouvent dans la portee de l'explosion, ils peuvent etre tous atteints par le nuage de nanos.

De nombreux commandants s'opposent a l'utilisation des "nanos", a cause des risques encourus par des degats colateraux. Lors des combats entremeles, il est tres difficile d'estimer si les nuages nanos ne vont pas provoquer des degats sur ses propres forces armees.]])

item = weapons:addEntry('Mine')
item:addKeyValue('Distance de largage', '1.2u')
item:addKeyValue('Declenchement a', '0.6u')
item:addKeyValue('Rayon explosion', '1u')
item:addKeyValue('Degats au centre', '160')
item:addKeyValue('Degats aux bords', '30')
item:setLongDescription([[Les mines sont souvent placees en perimetres de defenses autour d'un spatiodock. On trouve parfois aussi de vieux champs de mines perdu dans le syteme planetaire, datant d'anciennes guerres ou batailles.

Les insurges font souvent usage de mines pour pieger les transporteurs de marchandises afin de les obliger a changer de trajectoire, et pouvoir ainsi les capturer plus facilement.

Certains capitaines utilisent les mines comme arme offensive, mais leur detonation a retardement et rayon d'eplosion rend ces manoeuvres risquees.]])

item = weapons:addEntry('Axo-IEM')
item:addKeyValue('Portee', '5.4u')
item:addKeyValue('Rayon explosion', '1u')
item:addKeyValue('Degats au centre', '160')
item:addKeyValue('Degats aux bords', '30')
item:setLongDescription([[Missile Axonotmesis a Impulsion Electro Magnetique.

C'est une variante des armes axo a grande echelle, qui affecte en partie le personnel de bord, et qui genere en plus une deflagration electromagnetique qui affecte les equipements electroniques d'un navire.

Cela affecte donc les boucliers sans atteindre la coque du navire.

La taille de ces missiles etant fort reduite, il est possible d'en stocker beaucoup plus a bord d'un vaisseau.

De nombreux commandants et amiraux de guerre peferent utiliser cette arme (a la place des dangereuses nanos), qui lorsque les boucliers de la cible sont desactives, en profite pour tirer des salves de lasers bien ciblees pour achever le vaisseau.]])

item = weapons:addEntry('Rafale')
item:addKeyValue('Portee', '5.4u')
item:addKeyValue('Degats', '7 par missile, 35 au total')
item:addKeyValue('Nombre de tirs', '5')
item:setLongDescription([[Il s'agit d'un torpillage a grande vitesse en rafale de plusieurs obus. Le tir s'effectue en ligne droite, sans correction de trajectoire possible.

Ce type d'armement se retrouvera generallement sur les simples vaisseaux car ne necessite pas de systeme de guidage assiste.

Chaque tir correspond a l'ejection de 5 obus cinetiques. Les chances de toucher une cible sont d'autant plus grande que la precision du tir est correctement ajustee. Il s'agit d'un travail de concert entre le pilote et l'artilleur.]])

----------

planetarium = ScienceDatabase():setName('Planetarium')
item = planetarium:addEntry('Bhatthi')
item:addKeyValue('Population', '125.000 habitants')
item:setLongDescription([[C'est la planete la plus proche de Khayyam. Transark a organise deux lignes de transport physique. C'est dire si elles sont proches et en relation directe.

Bhatthi n'a pas grand-chose de special si ce n'est ses habitants eux-memes. Ils ont une propension a la fete si bien que certains secteurs ont decrete que la nuit s'etendait jusqu'a 3 heures apres le lever du soleil et commencait 1 heure plus tot que son coucher.

Hormis ce detail, Bhatthi possede autant d'usines que Khayyam et reste un des points nevralgiques de notre expansion dans l'arche.

C'est la qu'on procede aux recherches sur les hyper-technologies car Mobius s'y est installe et Polaris y a son antenne.]])

item = planetarium:addEntry('Choor')
item:addKeyValue('Population', '125.000 habitants')
item:setLongDescription([[Choor est la seule planete ou l'on trouve a l'etat naturel les proteines necessaires a notre nutrition. Meme si les archotypes creent l'essentiel de notre nourriture, Choor exporte ces proteines, ce qui permet d'avoir, pour certains privilegies, des repas plus goûteux. Encore faut-il qu'ils se procurent aussi les produits frais.

C'est sur Choor qu'on retrouve le plus d'Intouchables, la facilite qu'ils ont de pouvoir se nourrir n'y est pas pour rien.

Choor est la planete la plus proche de Soleil-16, notre etoile, et sa vegetation y est tres luxuriante. Vu le pourcentage d'eau sur cette planete, on la surnomme parfois la Serre ou encore le Sauna, en ete.]])

item = planetarium:addEntry('Keisi-C')
item:addKeyValue('Population', '315.000 habitants')
item:setLongDescription([[Keisi-C ou l'entrepot est situee strategiquement sur une orbite permettant d'acceder assez facilement aux autres planetes (c'est relatif). C'est sur Keisi-C que sont stockees les marchandises en transit. Cette planete est aussi le grenier de Khayyam car c'est de la que sont creees les reserves de nourriture via l'un des principaux archogenerateurs de l'arche.

Transkark s'y est etablie, et y entretient sa flotte de vaisseaux.]])

item = planetarium:addEntry('Khanija')
item:addKeyValue('Population', '75.000 habitants')
item:setLongDescription([[C'est un satellite de Bhatthi. On ne peut donc pas vraiment parler de planete mais comme elle est terraformee comme les autres, on la place dans le lot. Elle reste cependant plus grande que Maatrah.

Khanija est surtout connue pour les especes florales assez atypiques qu'elle recele et dont on extrait bon nombre des substances utilisees dans les Bulles.]])

item = planetarium:addEntry('Khatara')
item:addKeyValue('Population', 'aucune')
item:setLongDescription([[La dangereuse, comme on l'appelle. Non pas que la vie sur place y serait risquee, non c'est plus le chemin pour y arriver qui l'est. Khatara est entouree de barrieres d'asteroides extremement dangereuses et y penetrer demande enormement de precautions. La valeur des vaisseaux etant des plus importantes, s'y rendre de facon frequente est donc hors de question.

L'instabilite des barrieres fait qu'il est frequent de voir des asteroides s'ecraser sur la proche Maatrah. Lorsqu'une fois tous les 3 ans leurs revolutions se rapprochent. Heureusement, ils sont assez petits et la plupart se desagregent avant de toucher sol.

Les deux missions envoyees precedemment furent un fiasco et ne revinrent jamais. Aussi, Transark et l'Arcade ont decide de postposer les nouvelles tentatives a plus tard.]])

item = planetarium:addEntry('Khayyam')
item:addKeyValue('Population', '1.300.000 habitants')
item:setLongDescription([[Khayyam est la planete-mere. Elle est donc la seule a avoir des archos en permatech. Ces derniers, a l'epreuve du temps, servent encore et toujours, nuit et jour, car nous sommes toujours dans la phase ascendante de la reprise de l'arche. L'archogenerateur produit essentiellement des machines finies car nos usines et manufactures restent encore assez peu nombreuses par rapport aux besoins que nous avons.

Khayyam ressemble a ce que devait etre la Terre du temps des Premiers car sa taille et sa masse sont assez similaires.

Comme toute planete-mere, c'est la que l'Arcade et les sieges de la plupart des patries sont installes.]])

item = planetarium:addEntry('Maatrah')
item:addKeyValue('Population', '53.000 habitants')
item:setLongDescription([[Maatrah a un satellite mort en orbite autour d'elle. Il n'a jamais ete terraforme. Son nom officiel est Kephar-TX-1 mais tout le monde le nomme Kephar.

Maatrah est la plus petite des planetes de Khayyam. Son noyau recele enormement de metaux precieux et bon nombre de mines y furent deployees avant l'abandon. On raconte que la croute terrestre de Maatrah est devenue un gruyere a force d'extraire les richesses de son sol.]])

item = planetarium:addEntry('Svarga')
item:addKeyValue('Population', 'aucune')
item:setLongDescription([[Svarga est la planete la plus eloignee du systeme. Les experts de Mobius ont rapporte que son bouclier magnetique semble maintenant trop affaibli pour y vivre correctement. La vie qui s'y trouve est essentiellement de type lichen et insectes. Auparavant, au 24eme siecle, Svarga etait une planete comme une autre, on la surnommait meme le paradis.

Une mission a ete depechee recemment pour etudier l'evolution de la planete car une des hypotheses est que la singularite aurait ete a l'origine de ces changements sur Svarga.]])

item = planetarium:addEntry('Videsh')
item:addKeyValue('Population', '700 habitants')
item:setLongDescription([[Videsh est une planete ressources. C'est-a-dire qu'il n'y fait pas bon vivre et que son principal attrait vient du fait qu'elle contient bon nombre de matieres primaires utiles. Ainsi on y retrouve des gaz derives et autres sources d'energie. Il n'existe qu'un secteur sur Videsh et les gens qui y resident ne gerent essentiellement que l'envoi des ressources hors de leur planete.

Media 16 y a organise il y a quelques annees des emissions et jeux de survie, mais cela n'a pas eu le succes escompte suite a la contamination d'un participant par des nanos.]])
