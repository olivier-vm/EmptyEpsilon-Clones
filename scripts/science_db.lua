--[[
	Everything in the science database files is just readable data for the science officer.
	This data does not affect the game in any other way and just contributes to the lore.
--]]
space_objects = ScienceDatabase():setName('Cosmos')
item = space_objects:addEntry('Astéroïde')
item:setLongDescription([[Les astéroïdes sont assimilables à des planètes mineures, générallement d'un diamètre dépassant rarement les quelques kilomètres. Les variantes plus grosses sont parfois appelées planétoïdes]])

item = space_objects:addEntry('Micro-nébuleuse')
item:setLongDescription([[On entend par nébuleuse toute région du milieu interstellaire particulièrement riche soit en gaz (le plus souvent de l'hydrogène), soit en poussière interstellaire, soit des deux. Les nébuleuses peuvent former des systèmes d'étoiles en s'effondrant gravitationnellement.

La taille des nébuleuses est gigantesque. Un nuage s'étend sur des espaces joignant plusieurs étoiles.

Il arrive, en navigant, de tomber sur des phénomène ponctuels reprenant les caractéristiques d'une nébuleuse, sur des tailles à l'échelle des vaisseaux. Des tailles de plusieurs dizaine d'unités de distance de voyage spatiale. On appelle couremment ces phénomènes des micro-nébuleuses.

A cause de la nature gazeuse et des particules contenues dans ces micronébuleuses, la plupart des technologies de scan et de radar utilisées en astronavigation ne peuvent pénétrer ces nuages. Les officiers scientifiques de l'équipage doivent alors se fier aux sondes et à leurs observations visuelles.]])

item = space_objects:addEntry('Micro singularité')
item:setLongDescription([[Abusivement communément appelées mini trou noir. Il s'agit de zone de l'espace ayant un comportement ressemblant à un trou noir mais sur une étendue bien plus réduite, qui n'affecte que son environnement proche. Les forces gravitationnelles à leurs abords sont gigantesques. Ces micro-singularités ne s'étendent pas, ne grossissent pas, et leur masse ne semble pas augmenter malgré ce qu'elles absorbent (d'après des mesures effectuées par des unités spécialisées de Möbius). Elles restent permanente (semble-t-il).

Il pourrait s'agir de reliquat ou d'effet de bord de technologies oubliées des "Premiers". Des restes rémanents de guerres spatiales du passé. Comme des sortes de mines gravitationnelles.

D'autre théories parlent d'un lien direct avec LA singularité qui est apparue aux abords de Khayyam. Il s'agirait d'une manifestation indirecte de cette singularité, qui s'étend donc bien au delà de sa position.

Les micro-singularités n'apparaissent que sur les détecteurs radars, elles n'ont pas d'apparence visuelle, puisqu'elles absorbent tout ce qui passe à leur portée (on ne voit que du noir... dans le noir vide de l'espace).]])


--item = space_objects:addEntry('Wormhole')
--item:setLongDescription([[A wormhole, also known as an Einstein-Rosen bridge, is a phenomena that connects two points of spacetime. WARP drives operate in a similar fashion, but instead of being created at will, a wormhole occupies a specific location in space. Objects that enter a wormhole instantaneously emerge from the other end, which might be anywhere from a few feet to thousands of light years away. 
--
--Wormholes are rare, and most can move objects in only one direction. Traversable wormholes, which are stable and allow for movement in both directions, are even rarer. All wormholes generate tremendous sensor activity, which an astute science officer can detect even through disruptions such as nebulae.]])

----------

weapons = ScienceDatabase():setName('Armement')
item = weapons:addEntry('Missile à guidage')
item:addKeyValue('Portée', '5.4u')
item:addKeyValue('Dégats', '35')
item:setLongDescription([[Il s'agit d'un missile à asservissement de trajectoire. Il est le cheval de bataille dans l'arsenal de combat. Sa taille lui permet de se loger aussi bien dans des frégates que de plus lourds vaisseaux. Il est souvent utilisé dans plus d'un tube lanceur.

L'autoguidage (après ciblage d'un ennemi) permet au missile de se déplacer de façon totalement automatique, sans nécessiter d'opérateur ("tire et oublie"). Le composant du missile servant à détecter la cible est l'autodirecteur ("tête chercheuse" dans le langage commun).

Il est possible aussi de travailler en mode de "téléguidage indirect", dans lequel l'artilleur donne une direction fixe au missile, et modifie sa trajectoire pendant le tir.]])

item = weapons:addEntry('Nano')
item:addKeyValue('Portée', '5.4u')
item:addKeyValue('Rayon explosion', '1u')
item:addKeyValue('Dégats au centre', '160')
item:addKeyValue('Dégats aux bords', '30')
item:setLongDescription([[Le terme officiel est MG-ELNP, un Missile Guidé à Expulsion Localisée de Nano Particules.

Ce type d'arme très dangereuse n'est utilisée que dans les situations impérieuses. Comme le missile à guidage classique, le "nano" (MG-ELNP) peut cibler et suivre un ennemi, mais il tourne et et se déplace plus lentement.

Son explosion libère un nuage de nanos qui pénètre dans le vaisseau et "ronge" litérallement instantanément la structure de la coque, provoquant une implosion immédiate sur les petits vaisseaux, tandis que les plus gros subissent de très gros dommages.

Si plusieurs vaisseaux se trouvent dans la portée de l'explosion, ils peuvent être tous atteints par le nuage de nanos.

De nombreux commandants s'opposent à l'utilisation des "nanos", à cause des risques encourus par des dégats colatéraux. Lors des combats entremêlés, il est très difficile d'estimer si les nuages nanos ne vont pas provoquer des dégats sur ses propres forces armées.]])

item = weapons:addEntry('Mine')
item:addKeyValue('Distance de largage', '1.2u')
item:addKeyValue('Déclenchement à', '0.6u')
item:addKeyValue('Rayon explosion', '1u')
item:addKeyValue('Dégats au centre', '160')
item:addKeyValue('Dégats aux bords', '30')
item:setLongDescription([[Les mines sont souvent placées en périmètres de défenses autour d'un spatiodock. On trouve parfois aussi de vieux champs de mines perdu dans le sytème planétaire, datant d'anciennes guerres ou batailles.

Les insurgés font souvent usage de mines pour piéger les transporteurs de marchandises afin de les obliger à changer de trajectoire, et pouvoir ainsi les capturer plus facilement.

Certains capitaines utilisent les mines comme arme offensive, mais leur détonation à retardement et rayon d'eplosion rend ces manoeuvres risquées.]])

item = weapons:addEntry('Axo-IEM')
item:addKeyValue('Portée', '5.4u')
item:addKeyValue('Rayon explosion', '1u')
item:addKeyValue('Dégats au centre', '160')
item:addKeyValue('Dégats aux bords', '30')
item:setLongDescription([[Missile Axonotmesis à Impulsion Electro Magnétique.

C'est une variante des armes axo à grande échelle, qui affecte en partie le personnel de bord, et qui génère en plus une déflagration électromagnétique qui affecte les équipements électroniques d'un navire.

Cela affecte donc les boucliers sans atteindre la coque du navire.

La taille de ces missiles étant fort réduite, il est possible d'en stocker beaucoup plus à bord d'un vaisseau.

De nombreux commandants et amiraux de guerre péfèrent utiliser cette arme (à la place des dangereuses nanos), qui lorsque les boucliers de la cible sont désactivés, en profite pour tirer des salves de lasers bien ciblées pour achever le vaisseau.]])

item = weapons:addEntry('Rafale')
item:addKeyValue('Portée', '5.4u')
item:addKeyValue('Dégats', '7 par missile, 35 au total')
item:addKeyValue('Nombre de tirs', '5')
item:setLongDescription([[Il s'agit d'un torpillage à grande vitesse en rafale de plusieurs obus. Le tir s'effectue en ligne droite, sans correction de trajectoire possible.

Ce type d'armement se retrouvera générallement sur les simples vaisseaux car ne nécessite pas de système de guidage assisté.

Chaque tir correspond à l'éjection de 5 obus cinétiques. Les chances de toucher une cible sont d'autant plus grande que la précision du tir est correctement ajustée. Il s'agit d'un travail de concert entre le pilote et l'artilleur.]])

----------

planetarium = ScienceDatabase():setName('Planetarium')
item = planetarium:addEntry('Bhatthi')
item:addKeyValue('Population', '125.000 habitants')
item:setLongDescription([[C'est la planète la plus proche de Khayyam. Transark a organisé deux lignes de transport physique. C'est dire si elles sont proches et en relation directe.

Bhatthi n'a pas grand-chose de spécial si ce n'est ses habitants eux-mêmes. Ils ont une propension à la fête si bien que certains secteurs ont décrété que la nuit s'étendait jusqu'à 3 heures après le lever du soleil et commençait 1 heure plus tôt que son coucher.

Hormis ce détail, Bhatthi possède autant d'usines que Khayyam et reste un des points névralgiques de notre expansion dans l'arche.

C'est là qu'on procède aux recherches sur les hyper-technologies car Möbius s'y est installé et Polaris y a son antenne.]])

item = planetarium:addEntry('Choor')
item:addKeyValue('Population', '125.000 habitants')
item:setLongDescription([[Choor est la seule planète où l'on trouve à l'état naturel les protéines nécessaires à notre nutrition. Même si les archotypes créent l'essentiel de notre nourriture, Choor exporte ces protéines, ce qui permet d'avoir, pour certains privilégiés, des repas plus goûteux. Encore faut-il qu'ils se procurent aussi les produits frais.

C'est sur Choor qu'on retrouve le plus d'Intouchables, la facilité qu'ils ont de pouvoir se nourrir n'y est pas pour rien.

Choor est la planète la plus proche de Soleil-16, notre étoile, et sa végétation y est très luxuriante. Vu le pourcentage d'eau sur cette planète, on la surnomme parfois la Serre ou encore le Sauna, en été.]])

item = planetarium:addEntry('Keisi-C')
item:addKeyValue('Population', '315.000 habitants')
item:setLongDescription([[Keisi-C ou l'entrepôt est située stratégiquement sur une orbite permettant d'accéder assez facilement aux autres planètes (c'est relatif). C'est sur Keisi-C que sont stockées les marchandises en transit. Cette planète est aussi le grenier de Khayyam car c'est de là que sont créées les réserves de nourriture via l'un des principaux archogénérateurs de l'arche.

Transkark s'y est établie, et y entretient sa flotte de vaisseaux.]])

item = planetarium:addEntry('Khanija')
item:addKeyValue('Population', '75.000 habitants')
item:setLongDescription([[C'est un satellite de Bhatthi. On ne peut donc pas vraiment parler de planète mais comme elle est terraformée comme les autres, on la place dans le lot. Elle reste cependant plus grande que Maatrah.

Khanija est surtout connue pour les espèces florales assez atypiques qu'elle recèle et dont on extrait bon nombre des substances utilisées dans les Bulles.]])

item = planetarium:addEntry('Khatara')
item:addKeyValue('Population', 'aucune')
item:setLongDescription([[La dangereuse, comme on l'appelle. Non pas que la vie sur place y serait risquée, non c'est plus le chemin pour y arriver qui l'est. Khatara est entourée de barrières d'astéroïdes extrêmement dangereuses et y pénétrer demande énormément de précautions. La valeur des vaisseaux étant des plus importantes, s'y rendre de façon fréquente est donc hors de question.

L'instabilité des barrières fait qu'il est fréquent de voir des astéroïdes s'écraser sur la proche Maatrah. Lorsqu'une fois tous les 3 ans leurs révolutions se rapprochent. Heureusement, ils sont assez petits et la plupart se désagrègent avant de toucher sol.

Les deux missions envoyées précédemment furent un fiasco et ne revinrent jamais. Aussi, Transark et l'Arcade ont décidé de postposer les nouvelles tentatives à plus tard.]])

item = planetarium:addEntry('Khayyam')
item:addKeyValue('Population', '1.300.000 habitants')
item:setLongDescription([[Khayyam est la planète-mère. Elle est donc la seule à avoir des archos en permatech. Ces derniers, à l'épreuve du temps, servent encore et toujours, nuit et jour, car nous sommes toujours dans la phase ascendante de la reprise de l'arche. L'archogénérateur produit essentiellement des machines finies car nos usines et manufactures restent encore assez peu nombreuses par rapport aux besoins que nous avons.

Khayyam ressemble à ce que devait être la Terre du temps des Premiers car sa taille et sa masse sont assez similaires.

Comme toute planète-mère, c'est là que l'Arcade et les sièges de la plupart des patries sont installés.]])

item = planetarium:addEntry('Maatrah')
item:addKeyValue('Population', '53.000 habitants')
item:setLongDescription([[Maatrah a un satellite mort en orbite autour d'elle. Il n'a jamais été terraformé. Son nom officiel est Képhar-TX-1 mais tout le monde le nomme Képhar.

Maatrah est la plus petite des planètes de Khayyam. Son noyau recèle énormément de métaux précieux et bon nombre de mines y furent déployées avant l'abandon. On raconte que la croute terrestre de Maatrah est devenue un gruyère à force d'extraire les richesses de son sol.]])

item = planetarium:addEntry('Svarga')
item:addKeyValue('Population', 'aucune')
item:setLongDescription([[Svarga est la planète la plus éloignée du système. Les experts de Möbius ont rapporté que son bouclier magnétique semble maintenant trop affaibli pour y vivre correctement. La vie qui s'y trouve est essentiellement de type lichen et insectes. Auparavant, au 24ème siècle, Svarga était une planète comme une autre, on la surnommait même le paradis.

Une mission a été dépêchée récemment pour étudier l'évolution de la planète car une des hypothèses est que la singularité aurait été à l'origine de ces changements sur Svarga.]])

item = planetarium:addEntry('Videsh')
item:addKeyValue('Population', '700 habitants')
item:setLongDescription([[Videsh est une planète ressources. C'est-à-dire qu'il n'y fait pas bon vivre et que son principal attrait vient du fait qu'elle contient bon nombre de matières primaires utiles. Ainsi on y retrouve des gaz dérivés et autres sources d'énergie. Il n'existe qu'un secteur sur Videsh et les gens qui y résident ne gèrent essentiellement que l'envoi des ressources hors de leur planète.

Media 16 y a organisé il y a quelques années des émissions et jeux de survie, mais cela n'a pas eu le succès escompté suite à la contamination d'un participant par des nanos.]])