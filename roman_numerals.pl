roman(X,Result) :-
	roman(X,[1000,900,500,400,100,90,50,40,10,9,5,4,1],
		    ['M','CM','D','CD','C','XC','L','XL','X','IX','V','IV','I'],
		    Result).

roman(0,_,_,'').	

roman(Amount,[ValueHead|ValueTail],[SymbolHead|SymbolTail],Result) :-
	Amount >= ValueHead,
	NewAmount is Amount - ValueHead,
	roman(NewAmount,[ValueHead|ValueTail],[SymbolHead|SymbolTail],PartialResult),!,
	concat(SymbolHead,PartialResult,Result).
	
roman(Amount,[_ValueHead|ValueTail],[_SymbolHead|SymbolTail],Result) :-
	roman(Amount,ValueTail,SymbolTail,Result).

:- begin_tests(roman_numerals).

test(value_for_1) :-
	roman(1,'I').
	
test(value_for_2) :-
	roman(2,'II').

test(value_for_3) :-
	roman(3,'III').

test(value_for_4) :-
	roman(4,'IV').
	
test(value_for_5) :-
	roman(5,'V').
	
test(value_for_6) :-
	roman(6,'VI').
	
test(value_for_9) :-
	roman(9,'IX').
	
test(value_for_12) :-
	roman(12,'XII').
	
test(value_for_44) :-
	roman(44,'XLIV').
	
test(value_for_73) :-
	roman(73,'LXXIII').
	
test(value_for_97) :-
	roman(97,'XCVII').
	
test(value_for_134) :-
	roman(134,'CXXXIV').
	
test(value_for_487) :-
	roman(487,'CDLXXXVII').
	
test(value_for_632) :-
	roman(632,'DCXXXII').
	
test(value_for_987) :-
	roman(987,'CMLXXXVII').
	
test(value_for_1953) :-
	roman(1953,'MCMLIII').
		
:- end_tests(roman_numerals).