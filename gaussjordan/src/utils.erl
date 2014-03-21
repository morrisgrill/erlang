-module(utils).
-export([contar/1, sumar/3, obtener/2, cambiar/3, pivote/3, invertir/1, multiplicar/3]).

contar([]) -> 0;
contar([_|T]) ->
	1 + contar(T).

pivote([],_,_) -> 0; %Empieza de 0 a N
pivote([L|_],_,0) when is_list(L) == false ->
	L;
pivote([L|T],Pi,Pk) when is_list(L) == false ->
	pivote(T,Pi,Pk-1);
pivote(M,Pi,Pk) ->
	pivote(obtener(M,Pi),Pi,Pk).

multiplicar(M,_,0) ->
	M;
multiplicar([],_,_) -> %empieza de 0 a N
	[];
multiplicar([H|T],0,Mul) ->
	[[X*Mul || X <- H]] ++ multiplicar(T,-1,0);
multiplicar([H|T],Pi,Mul) ->
	[H] ++ multiplicar(T,Pi-1,Mul).

sumar(Matriz,Pin,Pout) when is_integer(Pin) == true   -> %Empieza de 1 a N. Out es la fila que agregara la suma
	A = obtener(Matriz,Pin-1),
	B = obtener(Matriz,Pout-1),
	sumar(Matriz,sumar(A,B),Pout);
sumar([],_,_) ->
	[];
sumar([_|T],Lista,1) ->
	[Lista] ++ sumar(T,Lista,-1);
sumar([H|T],Lista,Pout)  ->
	[H] ++ sumar(T,Lista,Pout-1).
sumar([],[]) ->
	[];
sumar([H1|T1],[H2|T2])->
	[H1+H2]++sumar(T1,T2).

obtener([H|_],0) ->
	H;
obtener([_|T],Pi) ->
	obtener(T,Pi-1).

invertir(M) ->
	invertir(M,1,contar(M)).
invertir(M,TamA,TamA) ->
	M;
invertir(M,A,B) ->
	V=cambiar(M,A,B),
	invertir(V,A+1,B-1).

%% Cambiar funciona de 1 a N
cambiar(Matriz,Val1,Val2) when is_integer(Val1) == true ->
	Lista1 = obtener(Matriz,Val1-1),
	Lista2 = obtener(Matriz,Val2-1),
	MatrizT = cambiar(Matriz,Lista1,Val2),
	MatrizT2 = cambiar(MatrizT,Lista2,Val1),
	MatrizT2;
cambiar([_|T],L,1) ->
	[L|T];
cambiar([H|T],L,Pi) ->
	[H|cambiar(T,L,Pi-1)]. 
