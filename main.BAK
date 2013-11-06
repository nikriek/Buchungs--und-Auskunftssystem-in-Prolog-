% Autor: Georg Zänker, Niklas Rieckenbrauck, Jonas Umland
% Datum: 27.10.2013

% Benutzungsschnittstelle
start:-
        initialisierung, menue, terminierung.

initialisierung:-
        titel, retractall(wahl(_)), asserta(wahl(gebiet(_))), asserta(wahl(hotel(_))), asserta(wahl(kunde(_))), writeln('Lade Datenbank...'), tab(2), consult('Z:/prolog-project/frkunden.pl'), tab(2), consult('Z:/prolog-project/frbuchen.pl'), tab(2), consult('Z:/prolog-project/frhotel.pl'), nl.

titel:-
        writeln('----- Buchungs- und Auskunftssystem ------'), writeln('----- Froh-Reisen GmbH, Darmstadt ------'), nl.

menue:-
        nl,
        writeln('Hauptmenu¨: '), nl,
        writeln(' 1 - Urlaubsgebiete'),
        writeln(' 2 - Hotels'),
        writeln(' 3 - Kunden'),
        writeln(' 4 - Buchen'),
        writeln(' 5 - neuer Kunde'),
        writeln(' 0 - Beenden'), nl,
        write(' Ihre Wahl: '),
        get_single_char(Ch),
        wahl_ausfuehren(Ch),
        Ch \== 0'0, !,
        menue.
menue.

terminierung:- titel,
        writeln('Speichere Datenbank...'),
        write(' Kunden...'), rename_file('Z:/prolog-project/frkunden.pl', 'frkunden.bak'), tell('Z:/prolog-project/frkunden.pl'), listing(kunde), told, writeln(' ok!'),
        write(' Buchungen...'), rename_file('Z:/prolog-project/frbuchen.pl', 'frbuchen.bak'), tell('Z:/prolog-project/frbuchen.pl'), listing(buchung), told, writeln(' ok!'),
        retractall(wahl(_)).

% --- Menüverwaltung -----------------------------------------------------------

wahl_ausfuehren(0'1):-
        writeln(' Urlaubsgebiete'), nl,
        gebiete_zeigen,
        gebiet_waehlen.

wahl_ausfuehren(0'2):-
        writeln(' Hotels'), nl,
        linksbuendig('Nummer', 10),
        linksbuendig('Name', 25),
        linksbuendig('Kategorie', 37),
        linksbuendig('Gebiet', 10), nl,
        linie_zeichnen('-', 43), nl,
        hotels_zeigen,
        hotel_waehlen,
        weiter.

wahl_ausfuehren(0'3):-
        writeln(' Kunden'), nl,
        write('Name oder Nummer: '),
        read(Kunde),
        bearbeite_kunde(Kunde),
        weiter.

wahl_ausfuehren(0'4):-
        writeln(' Buchen'), nl,
        hole_kunde(Kunde),
        hole_hotel(Hotel),
        buchen(Hotel, Kunde).

wahl_ausfuehren(0'5):-
        writeln(' neuer Kunde'), nl,
        retractall(wahl(_)),
        asserta(wahl(gebiet(_))),
        asserta(wahl(hotel(_))),
        asserta(wahl(kunde(_))).

wahl_ausfuehren(_).

% --- Gebietsverwaltung --------------------------------------------------------

gebiete_zeigen:-
        findall(Gebiet, hotel(_, _, _, Gebiet), Liste1),
        sort(Liste1, Liste2),
        gebiete_zeigen(Liste2).

gebiete_zeigen([K|R]):-
        tab(2), writeln(K),
        gebiete_zeigen(R).
        gebiete_zeigen([]).

gebiet_waehlen:-
        nl, write('Gewünschtes Gebiet: '),
        read(Gebiet), nl, write(Gebiet), nl, bearbeite_gebiet(Gebiet).


%kein Gebiet gewaehlt
bearbeite_gebiet('').

%vorhandenes Gebiet
bearbeite_gebiet(Gebiet):-
        hotel(_, _, _, Gebiet),
        retract(wahl(gebiet(_))),
        asserta(wahl(gebiet(Gebiet))).

%nicht vorhandenes Gebiet
bearbeite_gebiet(Gebiet):-
                not(hotel(_,_,_,Gebiet)),
                writeln('Das gewünschte Gebiet ist nicht vorhanden.').

% --- Hotelverwaltung ----------------------------------------------------------

hotels_zeigen:-
        findall(hotel(Nummer, Name, Kategorie, Gebiet), hotel(Nummer, Name, Kategorie, Gebiet), Liste1),
        sort(Liste1, Liste2),
        hotels_zeigen(Liste2).
hotels_zeigen([hotel(Nummer, Name, Kategorie, Gebiet)|R]):-
        linksbuendig(Nummer, 10),
        linksbuendig(Name, 25),
        linksbuendig(Kategorie, 37),
        linksbuendig(Gebiet, 10), nl,
        hotels_zeigen(R).
hotels_zeigen([]).

hotel_waehlen:-
        nl, write('gewuenschtes Hotel: '), read(Hotel), nl, bearbeite_hotel(Hotel).


%-- kein Hotel gewaehlt
bearbeite_hotel(''):- !.
%-- Hotelname
bearbeite_hotel(Hotel):-
        hotel(HotelNr, Hotel, _, _),
        retract(wahl(hotel(_))),
        asserta(wahl(hotel(HotelNr))),
        zeige_hotel(HotelNr), !.
%-- Hotelnummer
bearbeite_hotel(HotelNr):-
        hotel(HotelNr, _, _, _),
        retract(wahl(hotel(_))),
        asserta(wahl(hotel(HotelNr))),
        zeige_hotel(HotelNr), !.
%nicht vorhandenes Hotel
bearbeite_gebiet(Hotel):-
        not(hotel(_,Hotel,_,_)),
        writeln('Das gewünschte Hotel ist nicht vorhanden.').

zeige_hotel(HotelNr):-
        write('Gewählt: '),
        hotels_zeigen([hotel(HotelNr, Hotel, _, _)]).

% --- Kundenverwaltung -------------------------------

bearbeite_kunde(Kunde):-
   atom(Kunde),
   writeln('Adresse des neuen Kunden: '), nl, write('Strasse und Nr.: '), read(Strasse), write('Postleitzahl : '), read(PLZ), write('Ort : '), read(Ort), findall(KNr, kunde(KNr,_,_,_,_), Liste1),
   sort(Liste1, Liste2),
   last(KNr1, Liste2),
   KundenNr is KNr1 + 1, speicher_kunde(kunde(KundenNr,Kunde,Strasse,PLZ,Ort)),
   !.

speicher_kunde(kunde(KundenNr,Kunde,Strasse,PLZ,Ort)):- nl, write('Adresse korrekt (ja/nein): '), lese_string(Antwort),
   Antwort = 'ja',
   assert(kunde(KundenNr, Kunde, Strasse, PLZ, Ort)), retract(wahl(kunde(_))), asserta(wahl(kunde(KundenNr))).
speicher_kunde(_).

% --- Buchungsverwaltung ------------------------------

buchen(Hotel, Kunde):-
   nl, writeln('Abflug'),
   write('am: '), lese_datum(Tag, Monat, Jahr), write('ab: '), lese_string(Flughafen), bestimme_saison(Hotel,Flughafen,Monat,Saison), nl, write('Personen: '), lese_zahl(Personen), write('Wochen : '), lese_zahl(Wochen), bestimme_preis(Hotel,Personen,Wochen,Saison,Preis),nl, write('Gesamtpreis: '), write(Preis), writeln(' DM'), write('Buchen (ja/nein): '), lese_string(Buchen), Buchen = 'ja',
   asserta(buchung(Kunde, Hotel, Personen,
   datum(Tag, Monat, Jahr), Wochen, Flughafen)), writeln('Gebucht.').
buchen(_, _).

bestimme_saison(Hotel, Flughafen, Monat, Saison):-
   hotel(Hotel, _, _, Gebiet),
   saison(Gebiet, Flughafen, Monat, Saison), !.
bestimme_saison(Hotel, _Flughafen, Monat, Saison):- hotel(Hotel, _, _, Gebiet),
   findall(FHafen,
   saison(Gebiet,FHafen,Monat,Saison),FHaefen), (FHaefen = [] ->
   write('Abflug nicht möglich. Keine Saison in '), writeln(Gebiet);
   write('Abflug möglich ab: '), writeln(FHaefen)),
  fail.

bestimme_preis(Hotel, Personen, Wochen, Saison, Preis):-
   preise(Hotel, Saison, Wochen, Kosten),
   Preis is Personen * Kosten, !.

% --- Formatierungsbefehle ---------------------------


%lese_datum(Tag, Monat, Jahr):-

%lese_zahl(Zahl):-

linksbuendig(Ausgabe, Breite):-
   format('~w~t~*|', [Ausgabe, Breite]).
   
linie_zeichnen(Zeichen, Breite):-
   name(Zeichen, [Ascii]),
   format('~*t~*|', [Ascii, Breite]).
   
%weiter:-


