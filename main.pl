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
	
% Gebietsverwaltung

% Hotelverwaltung

% Kundenverwaltung

% Buchungsverwaltung
