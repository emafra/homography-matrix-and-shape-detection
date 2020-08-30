%%
% 
%  Relat�rio 2 - Vis�o Computacional.
%  Aluno: Eduardo Mafra Pereira.
%  Orientador: Leonardo Mejia Ricon.
%
%
%
%  Contextualiza��o:
%   O objetivo do projeto � desenvolver um algortimo que conte quantas
% letras de mesma cor s�o encontradas encontradas na imagem
% UFSC_homography.jpg. Sendo assim, o algoritmo desenvolvido atende este
% objetivo. 
%   Seu funcionamento se apresenta da seguinte maneira:
%   Primeiramente � realizada a homografia da imagem gerando uma nova, na
% sequ�ncia a matriz � transformada para a escala de cinza e finalmente a
% imagem � transformada em uma imagem preto e branco. Ap�s a transforma��o
% a matriz preto e branco � percorrida e ignorando os ru�dos e os apagando.
% Ao encontrar o primeiro pixel de uma letra  uma fun��o recursiva � 
% chamada e esta percorre a letra at� transformado seus pixels em zero e ao
% final contabiliza uma letra. Ap�s perrocer toda a matriz o a quantidade
% de letras � atribuida a uma vari�vel.
% 
% 
clc
Im1= imread('UFSC_Homography.jpg'); % Imagem Original.
figure(1),imshow(Im1);
title('Imagem original');
% Captura 4 pontos da imagem para gerar a matriz de homografia.
[i y] = ginput(4);
x1=fix(i);
y1=fix(y);
x2=[1;500;500;1];
y2=[1;1;500;500];
T=maketform('projective',[x1 y1],[x2 y2]);
T.tdata.T
% Realiza a homografia da imagem.
[Im2,xdata,ydata]=imtransform(Im1,T);
% Apresenta a imagem ap�s a homografia.
figure(2),imshow(Im2);
title('Imagem ap�s a homografia');
% Matrizes RGB
Im2r = Im2(:,:,1);
Im2g = Im2(:,:,2);
Im2b = Im2(:,:,3);
% Media ponderada das matrizes RGB para transforma��o em escala de cinza
gray = 0.299*Im2r + 0.587*Im2g + 0.144*Im2b;
% Figura em cinza
figure(3), imshow(gray);% Captura a letra a ser contabilizada
title('Imagem em escala de cinza');
[x y] = ginput(1);
x = fix(x);
y = fix(y);
% Define um faixa de valores para escala de cinza
percentual = 5;
% Transforma��o da escala de cinza para preto e branco
bw = gray <= (gray(y,x)+gray(y,x)*percentual/100) & gray >= (gray(y,x)-gray(y,x)*percentual/100);
global bw;
% Apresenta a imagem em preto e branco
figure(4),imshow(bw);
title('Imagem em preto e branco');
% Atribui o tamanho da matriz para vari�veis n e m
[n,m] = size(bw);
flag=0;
count=0;
% La�o para percorrer a imagem
for i = 1:1:n-1
    for j = 1:1:m-1
        % Seguintes condi��es para verificar os pontos 
         if bw(i,j) == 1
            % Verifica se � ou n�o ru�do.            
            for e=-1:1:1
                for r=-1:1:1
                    if bw(i+e,j+r)==1
                    flag=flag+1;
                    end
                end
            end
            % Se flag maior que 2 o pixel pertence a letra
            if flag > 2
                % Chama a fun��o recursiva que percorre a letra
                verifica(i,j);
                % Ap�s letra percorrida contador soma 1
                count=count+1;
            end
            % Considera os pixels 4 a 0 para eleminar ru�do
            bw(i,j)=0;
        end
    flag=0;    
    end
end
%Im3= imread('funcao_recursiva.jpg');
%figure (6), imshow (Im3);
%title('Fun��o Recursiva');
count;
            
        