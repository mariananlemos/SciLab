clear
clc

/*********************************************************************
**********          Atividade 1 - Cálculo Numérico          **********
**********                                                  **********
**********                     Bruno Salles                 **********
**********                     Mariana Lemos                **********
**********                     Thiemy Tamura                **********
*********************************************************************/

function [x]=sistema_linear(A,b,m,eps,x) //matriz estendida e eps critério de parada
    l=size(m,1);
    c=size(m,2);
    sistema_linear=[]; //entrada da matriz
    //Início
    A=[];
    b=[];
    Ax=b;
    x0=0.05; //chute inicial
    disp(x')

    //iteração
    //método Gauss-Seidel
    for i=1:1
        for j=1:c-1
            A(i,j)=m(i,j);
        end
        b(i,1)=m(i,c);
    end
    soma=0;
    converge=1;

    if(l+1==c)
        for i=1:1
            for j=1:c-1
                if(j==1)
                    soma=soma;
                else
                    soma=soma+abs(A(i,j));
                end
            end

            if(soma>A(i,i))
                disp("Método pode não convergir!");
                converge=0;
            end
            soma=0;
        end
    else
        converge=0;
        disp("Matriz incompatível!");
    end

    if(converge==1)
        x=zeros(l,1);
        y=x;
        disp(x);
        for i=1:size(A,1)
            soma=0;
            for j=1:size(A,2)
                if(i==j)

                else
                    soma=soma-x(j,1)*A(i,j);
                end
            end
            x(i,1)=(b(i,1)+soma)/A(i,i);
        end
        disp(x);
        cont = 0;
        sx=[]; smax=0;

        for k=1:size(x,1)
            sx(k,1)= abs( (x(k,1) - y(k,1)))/x(k,1);
        end
        smax=max(sx);
        while smax>eps
            cont=cont+1;
            y=x;
            for i=1:size(A,1)
                soma=0;
                for j=1:size(A,2)
                    if(i==j)

                    else
                        soma=soma+x(j,1)*A(i,j);
                    end
                end
                x(i,1)=(b(i,1)-soma)/A(i,i);
            end
            disp(x);
            for k=1:size(x,1)
                sx(k,1)= abs( (x(k,1) - y(k,1)))/x(k,1)
            end
            smax=max(sx);
        end
        disp("Iterações");
        disp(cont);
    end

endfunction


//Dimensiona em função da extração em contracorrente
function [a,y]=ajuste(x_exp,y_exp,n)
    x=zeros(length(x_exp),n+1); //dimensiona vetor b(x)
    for i = 1:n+1
        x(:,i)=x_exp.^(i-1) //pot. elemento a elemento
    end
    X=x'*x;
    b = x'*y_exp;
    a=inv(X)*b; y = x*a;
endfunction


//Dados do problema
F=100; //lb/h
S=10; // lb/h
//F+S=M 
M=110; //M é a mistura
i=[1:10]; //i=1 e varia de 1 a 10
A=[];
b=[];
x=A\b;
n=10;
x(i)=A; //lb de A/lb de B
y(i)=A+S; //lb de A/lb de solvente
//Composição da mistura M
F*x(i)+S*y(i); //= M*x(n)
F*x(A)+S*y(b); //= M*y(n)
//x(i)+x(A)=1;
y(i)=9*x(i);
x0=0.05;
Ax=b;


//Dimensiona matriz e vetor
dim=x_mdialog(['dimensão'],['linhas';'colunas'],[' ';' ']);
sz = [evstr(dim(1)),evstr(dim(2))];
default_matriz = string(zeros(sz(1),sz(2)))
default_vetor = string(zeros(sz(1),1))
label_linha = 'row '+string(1:sz(1));
label_col = 'col '+string(1:sz(2));
A = x_mdialog('Matriz A',label_linha,label_col,default_matriz)
A = evstr(A); //matriz A
b = x_mdialog('Vetor b',label_linha,' ',default_vetor)
b = evstr(b); //vetor b
x = A\b //divisão à esquerda
//x = inv(A)*b //Usando a matriz inversa


//Plota matriz A e vetor b com os devidos valores
linha=input('Linhas = ');
coluna=input('Colunas = ')
printf("Matriz A\n")
for i=1:linha
    for j=1:coluna
        printf("linha %d coluna %d\n",i,j)
        A(i,j)=input('');
    end
end
printf('Vetor b:\n')
for i=1:linha
    b(i)=input('');
end
x=A\b;
disp(x)
