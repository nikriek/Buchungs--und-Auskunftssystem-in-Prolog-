/*
	Description: Auskunfts- und Reisebuchungssystem
	Contributors:
	License:
*/
% Datenbank
% kunde(KNr, Name, Strasse, PLZ, Ort).
% hotel(HNr, Name, Sterne, Gebiet).
% preis(HNr, Saison, Wochen, Kosten).
% saison(Gebiet, Flughafen, Monat, Saison).
% buchen(KNr, HNr, Abflug, Personen, Flughafen, Wochen).

% Benutzungsschnittstelle 
start:- 
	initialisierung, menue, terminierung.

initialisierung:- 
	titel, retractall(wahl(_)), asserta(wahl(gebiet(_))), asserta(wahl(hotel(_))), asserta(wahl(kunde(_))), writeln('Lade Datenbank...'), tab(2), consult(frkunden), tab(2), consult(frbuchen), tab(2), consult(frhotel), nl.

titel:-
	writeln('----- Buchungs- und Auskunftssystem ------'), writeln('----- Froh-Reisen GmbH, Darmstadt ------'), nl.

menue:-
	nl, writeln('Hauptmenü: '), nl, writeln(' 1 - Urlaubsgebiete'), writeln(' 2 - Hotels'), writeln(' 3 - Kunden'), writeln(' 4 - Buchen'), writeln(' 5 - neuer Kunde'), writeln(' 0 - Beenden'), nl, write(' Ihre Wahl: '), get_single_char(Ch), wahl_ausfuehren(Ch),
	Ch \== 0'0, !,
	menue.
	menue.

terminierung:- titel,
	writeln('Speichere Datenbank...'),
	write(' Kunden...'), rename_file('frkunden.pl', 'frkunden.bak'), tell('frkunden.pl'), listing(kunde), told, writeln(' ok!'),
	write(' Buchungen...'), rename_file('frbuchen.pl', 'frbuchen.bak'), tell('frbuchen.pl'), listing(buchung), told, writeln(' ok!'),
	retractall(wahl(_)).


wahl_ausfuehren(0'1):-
	writeln(' Urlaubsgebiete'), nl, gebiete_zeigen,
	gebiet_waehlen.
	
wahl_ausfuehren(0'2):-
	writeln(' Hotels'), nl, linksbuendig('Nummer', 9), linksbuendig('Name', 15), linksbuendig('Kategorie', 10), linksbuendig('Gebiet', 10), nl, linie_zeichnen('-', 40), nl, hotels_zeigen,
	hotel_waehlen, weiter.
	
wahl_ausfuehren(0'3):- 
	writeln(' Kunden'), nl, write('Name oder Nummer: '), lese_string(Kunde), bearbeite_kunde(Kunde), weiter.

wahl_ausfuehren(0'4):- 
	writeln(' Buchen'), nl, hole_kunde(Kunde), hole_hotel(Hotel), buchen(Hotel, Kunde).

wahl_ausfuehren(0'5):- 
	writeln(' neuer Kunde'), nl, retractall(wahl(_)), asserta(wahl(gebiet(_))), asserta(wahl(hotel(_))), asserta(wahl(kunde(_))).

wahl_ausfuehren(_).

% Gebietsverwaltung

gebiete_zeigen:-
	findall(Gebiet, hotel(_, _, _, Gebiet), Liste1), 
	sort(Liste1, Liste2),
	gebiete_zeigen(Liste2),
	
gebiete_zeigen([K|R]):-
	tab(2), writeln(K), 
	gebiete_zeigen(R).
	gebiete_zeigen([]).
	
% Hotelverwaltung

% Kundenverwaltung

% Buchungsverwaltung
