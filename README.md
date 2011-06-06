SVT Get
============
"Ladda ner från SVT Play" in Swedish, SVT Get is a free software tool to make local cache files of SVT Play web streams, available from http://SVTPlay.se

Vad gör SVT Get?
===================
Eftersom SVT Get är fri mjukvara kan du granska källkoden direkt. För närvarande fungerar det genom att använda sig av andra fria mjukvaror, såsom bash, curl och rtmpdump, för att ladda hem och tolka hemsidan SVTPlay.se.

Hos SVT Play så finns all information man behöver för att ladda hem deras videoklipp. Det känns ganska självklart egentligen, men många tror att "streaming" är något annat än "nedladdning" - men oavsett vad du gör så får du hem informationen till din dator. Kan du se det kan du kopiera det - alltså kan vi spara ner informationen på din dator. Att det sedan blir en perfekt digital kopia är bara en bonus av kopimi. 

Hur laddar jag ner från SVT Play?
==================================
I mjukvarans nuvarande stadie behöver du köra ett POSIX-kompatibelt operativsystem där man kan installera de fria mjukvarorna bash, curl och rtmpdump. Absolut mest rekommenderat är Ubuntu Linux, ett gratis och fritt operativsystem som installeras på en timme eller så. Ett annat tips är att be någon datornörd i din närhet att hjälpa till.

När du använder Linuxmiljön behöver du bara ladda hem scriptet och starta det med en adress till SVT Play:
	$ wget "https://github.com/mmn/svtget/raw/master/bash/svtget.sh"
	$ bash svtget.sh http://svtplay.se/v/2440756/k_special/presspauseplay
	# Bitrate Filename 
	1. 1400 kbps GEOSEMOBIL_0603-KSPECIAL-PLAY-mp4-d-v1.mp4
	2. 320 kbps GEOSEMOBIL_0603-KSPECIAL-PLAY-mp4-b-v1
	3. 850 kbps GEOSEMOBIL_0603-KSPECIAL-PLAY-mp4-c-v1.mp4

	Which file do you want? [#] 3

Här anger man sedan vilken kvalitet man ska ladda hem i. De kvaliteter som erbjuds är samma som erbjuds på hemsidan, där 2400 kbps (som ej syns i detta fall) är HD 720P, medan 850 kbps är den lite behändigare 640x360-varianten. Filen sparas sedan i den mapp du befinner dig i (vanligtvis ~/)

Vad är syftet?
================
Dels politiskt. Tycker man om fri kultur och mjukvara bör man gå med i Piratpartiet och kämpa för rätten att använda, modifiera och distribuera. Alternativt aktivera sig inom ett annat parti och arbeta för samma mål. Det är informationsamhällets framtid det handlar om - och ett blivande kunskapssamhälle.

Fast egentligen är syftet mest av praktiskt art. Idén poppade upp när jag inte hade en tv för att titta på dokumentären Press Pause Play, som alltså visades på SVT. Som tur är så har dock SVT framåtanda i dagens tekniska samhälle och tillgängliggjorde filmen på sin hemsida, som strömbar video. Problemet är att strömbar video - trots att det är som vilken videofil som helst - ofta är krångligare att ladda ner - och detta kände jag var nödvändigt eftersom platsen jag ville se filmen på saknade en stabil internetuppkoppling. Och filmen fanns inte ens på The Pirate Bay.

Syftet med scriptet är alltså kort och gott att underlätta en lokal cache för besökare på SVT Play. Video som är lagligt tillgänglig i "strömmande format" kan arkiveras på den enskilda individens dator av bekvämlighetsskäl. Rent juridiskt är detta ett klockrent fall av privatkopiering och därmed helt lovligt trots dagens i övrigt knäppa upphovsrättslagstiftning:

> Privatkopiering är en populär term för den kopiering som är tillåten att företa på annars upphovsrättsligt skyddade verk. Förutsättningarna för att få privatkopiera anges i 12§ upphovsrättslagen. Exempel på privatkopiering kan vara att göra en kopia av en CD-skiva att använda i bilen, att lägga över musikfiler på sin MP3-spelare eller dator. Man har inte rätt att vidare distribuera privatkopierat material mer än i en mycket begränsad omfattning (exempelvis till en enstaka vän).


Vem utvecklar SVT Get?
========================
Det ursprungliga bash-scriptet skrevs av Mikael "MMN-o" Nordfeldth, vars diverse skriverier ni kan följa på blog.mmn-o.se. Utvecklingen därefter kan följas från diverse forkade projekt, förhoppningsvis centrerat kring projektet på GitHub (här).
Den fria mjukvaran SVTGet är skyddad av upphovsrättslagen enligt GPLv3. Samtlig text tillhörande projektet, hemsidan och sådant är licensierat Creative Commons Erkännande-DelaLika. Det är med dessa principer upphovsrätt bör fungera automatiskt, men tyvärr inte gör. Förhoppningen för framtiden är väl att SVT ska satsa mer på Creative Commons, för då har de rättigheterna att sprida vidare filmer och samhället behöver inte riskera att förlora sin kulturhistoria.