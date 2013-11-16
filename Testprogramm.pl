% Autor:
% Datum: 06.11.2013

vater(steffen, paul).
vater(fritz, karin).
vater(steffen, lisa).
vater(paul, maria).

test_waehlen:-
        nl, write('Gewünschtes Gebiet: '),
        leseTest_string(Gebiet), nl, write(Gebiet), nl, fail.
        
leseTest_string(String):-
   readln([String|_], _, _, " .,0123456789", uppercase), !.
leseTest_string('').