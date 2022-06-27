clear
clc

/*********************************************************************
**********          Atividade 1 - Cálculo Numérico          **********
**********                                                  **********
**********                     Bruno Salles                 **********
**********                     Thiemy Tamura                **********
**********                     Mariana Lemos                **********
*********************************************************************/

function y = fg(y0,x)
    global xj yj y zj fj c z

    numerador = 0;
    denominador = 0;

    C = length(fj)

    for k = 1:C
        denominadorAuxiliar = (x - xj(k))^2 + (y0 - yj(k))^2 + (z - zj(k))^2;

        if(denominadorAuxiliar ~= 0)then
            numerador = numerador + fj(k)/denominadorAuxiliar;
            denominador = denominador + 1.0/denominadorAuxiliar;
        else
            y = y0;
            return;
        end
    end

    y = numerador/denominador - c
endfunction

function dy = derg(y0,x)
    global xj yj zj fj c z derivadanumerador derivadadenominador anumerador bdenominador cdenominador

    numerador = 0;
    denominador = 0;
    derivadanumerador = 0;
    derivadadenominador = 0;
    anumerador = 0; bdenominador = 0; cdenominador = 0;

    C = length(fj)

    for k = 1:C
        denominadorAuxiliar = (x - xj(k))^2 + (y0 - yj(k))^2 + (z - zj(k))^2;

        if(denominadorAuxiliar ~= 0)then
            anumerador = anumerador + fj(k)/denominadorAuxiliar;
            bdenominador = bdenominador + 1/denominadorAuxiliar;
            cdenominador = cdenominador + (1/(denominadorAuxiliar^2));

            derivadanumerador = derivadanumerador - 2*fj(k)*(y0-yj(k))/(denominadorAuxiliar^2);
            derivadadenominador = derivadadenominador -2*(y0-yj(k))/(denominadorAuxiliar^2);

            denominadorAuxiliar = denominadorAuxiliar + (x - xj(k))^2 + (y0 - yj(k))^2 + (z - zj(k))^2;
        else
            dy = 0
        end
    end
    dy = ((derivadanumerador*bdenominador) - (derivadadenominador*anumerador))/(cdenominador)
    return;
endfunction

function [sol,flag] = newton(chute, ponto)
    global maxiter eps
    global xj yj zj fj c z

    /**inicializa o flag**/    
    flag = 0;

    for k = 1: maxiter
        if(derg(chute, ponto) == 0)then
            return;
        end

        sol = chute - fg(chute,ponto)/derg(chute,ponto)
        erro_rel = abs((sol-chute)/sol);

        if(erro_rel<eps) then
            flag = 1;
            return;
        end
        chute = sol;
    end
endfunction

/*Inserção*/

global maxiter eps
global xj yj zj fj c z

maxiter = 100
eps = 1e-4

/**Dados de entrada para o traçado das curvas de isoconcentração**/
c = input("Concentração: ")
z = input("Cota: ")

/**Dados medidos**/
xj = [0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.5; 0.5; 1.0; 1.0];
yj = [0.0; 0.0; 0.0; 1.0; 1.0; 1.0; 0.0; 1.5; 2.0; 1.5];
zj = [0.0; 1.0; 2.0; 0.0; 0.5; 1.5; 0.8; 0.8; 1.0; 1.5];
fj = [5; 35; 25; 10; 5; 45; 0; 20; 50; 40];

/*limites do intervalo x*/
a1 = -3; a2 = 3;
/*limites do intervalo y*/
b1 = -3; b2 = 3;
/*número de intervalos em x e y*/
n = 60; m = 60;

/*Pontos da malha x*/
for j=1: n+1
    xi(j)=a1 + (j-1)*(a2-a1)/n; 
end
/*Pontos da malha y*/
for j = 1: m+1
    yi(j) = b1 + (j -1)*(b2-b1)/m;
end

//Função do Método de Newton-Raphson**/

for i =1: length(xi)
    for j =1: length(yi)
        [sol,flag] = newton(yi(j),xi(i));

        if(abs(sol)<=3 && flag == 1)
            Y(j,i) = sol;
        else
            Y(j,i) = 4;
        end       
    end
end

/*Construir o gráfico*/

/*Criação da matriz X para plotagem do gráfico*/
for i = 1:length(xi)
    for j = 1:length(yi)
        X(i,j) = xi(i)
    end
end

/*Criação da matriz Y para plotagem do gráfico*/
for j = 1:length(xi)
    for i = 1:length(yi)
        if Y(i,j) ~= 4
            plot(X(i,j),Y(i,j),".");
        end 

    end
end
scf();
plot(c,z);
