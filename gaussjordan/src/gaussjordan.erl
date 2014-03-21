%
%   Autor: Mauricio Zarate Barrera
%	Fecha: 21 de marzo de 2014
%	Proyecto: Eliminacion por gauss-jordan
%
-module(gaussjordan).
-export([do/1]).
-import(utils,[contar/1, sumar/3, obtener/2, cambiar/3, pivote/3, invertir/1, multiplicar/3]).

%% Contar Filas y columnas
do(M) ->
	[H|_] = M,
	igual(M,contar(H)-1, contar(M)).

igual(M,Var,Var) -> hacer(M,0,0,Var);
igual(_,_,_) -> no_es_invertible.

hacer(M,Pcol,Pfil,Pfil) ->	 %Limite fila
	hacer(M,Pcol+1,1,Pfil);
hacer(M,Pcol,Pcol,Max) -> 	 %1
	Pfil=Pcol,
	V=multiplicar(M,Pcol,1/pivote(M,Pcol,Pcol)),
	hacer(V,Pcol,Pfil+1,Max);
hacer(M,Pcol,_,Pcol) ->		 %Limite columna
	io:format("~w~n",[M]),
	hacerInv(M,Pcol-1,Pcol-1); %Termina!
hacer(M,Pcol,Pfil,Max) when Pfil<Max -> %0
	Mul=multiplicar(M,Pcol,-pivote(M,Pfil,Pcol)),
	Sum=sumar(Mul,Pcol+1,Pfil+1),
	V=multiplicar(Sum,Pcol,-1/pivote(M,Pfil,Pcol)),
	hacer(V,Pcol,Pfil+1,Max).

hacerInv(M,0,_) ->
	M;
hacerInv(M,X,0) ->
	hacerInv(M,X-1,X-1);
hacerInv(M,X,Y) -> %X = Vertical    Y = Horizontal
	%Piv: 0.5 X: 1, Y: 2
	Mul=multiplicar(M,X,-pivote(M,Y-1,X)),
	Sum=sumar(Mul,X+1,Y),
	V=multiplicar(Sum,X,-1/pivote(M,Y-1,X)),
	io:format("(~w,~w,~w,Fila X:~w)~n",[X,Y,-pivote(M,X-1,Y),obtener(Sum,X-1)]),
	hacerInv(V,X,Y-1).
%gaussjordan:do([[2,3,1,1],[3,-2,-4,-3],[5,-1,-1,4]]).
%gaussjordan:do([[2,2,4,4,2,1,1],[4,2,3,4,5,1,3],[4,2,4,5,4,1,1],[3,2,4,5,6,1,1],[1,2,3,4,5,6,1],[2,1,2,1,2,1,1]]).
%gaussjordan:sumar([[2,3,1,1],[3,-2,-4,-3],[5,-1,-1,4]],2,1).
%gaussjordan:pivote([[2,3,1,1],[3,-2,-4,-3],[5,-1,-1,4]],0,0).