clear
clc

/*********************************************************************
**********          Atividade 1 - Cálculo Numérico          **********
**********                                                  **********
**********                     Bruno Salles                 **********
**********                     Thiemy Tamura                **********
**********                     Mariana Lemos                **********
*********************************************************************/

function [produto,T] = polinomio_newton(x,y)
    n = length(x)-1; //n=tamanho de x
    T = zeros(n+1,n+1); //T=tamanho
    T(1:n+1,1)=y';
    for j=2:n+1
        for i=1:n+2-j
            T(i,j)=(T(i+1,j-1)-T(i,j-1))/(x(j+i-1)-x(i));
        end
    end

    a = T(1,:)
    produto = a(n+1);

    for j=1:i-1
        produto = [produto a(j)]-[0 produto*x(j)]
    end
endfunction

//*H/h* *dados tabelados*/
x(1)=6.0;
x(2)=6.5;
x(3)=7.0;
x(4)=7.5;
x(5)=8.0;
x(6)=8.5;
x(7)=9.0;

/*R* *dados tabelados*/
y(1)=0.6728;
y(2)=0.6476;
y(3)=0.6214;
y(4)=0.5940;
y(5)=0.5653;
y(6)=0.5350;
y(7)=0.5029;

[produto,T] = polinomio_newton(x,y) 
disp(produto)
disp(T)

/*Dados do problema*/
Q=30; //*em litros/min
h=6; //*em metros
H=46; //*em metros
r=7.67;

R = T(1)+(r-x(1))*T(1,2)+(r-x(1))*(r-x(2))*T(1,3)+(r-x(1))*(r-x(2))*(r-x(3))*T(1,4)+(r-x(1))*(r-x(2))*(r-x(3))*(r-x(4))*T(1,5)
+(r-x(1))*(r-x(2))*(r-x(3))*(r-x(4))*(r-x(5))*T(1,6)+(r-x(1))*(r-x(2))*(r-x(3))*(r-x(4))*(r-x(5))*(r-x(6))*T(1,7);

/*Cálculo da vazão de recalque*/
q=Q*(h/H)*R //*vaz̃ao de recalque em litros/min
printf("A vazao de recalque eh %d L/min",q)
disp(q)

/*Cálculo da capacidade do estábulo*/
Temp_Diario=1440; // 60min*24h
q_por_dia = q*Temp_Diario;

//*Capacidade, sendo que o consumo diário de cada vaca leiteira é de 120 litros
C=q_por_dia/120;

printf("A capacidade do estabulo eh %d L/min.vol",C)
disp(C)
