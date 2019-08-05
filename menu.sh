#!/bin/bash
#TODAS AS FUNCIONALIDADES IMPLEMENTADAS

#PARA O FUNCIONAMENTO DO SCRIPT É NECESSÁRIO CRIAR 
#A LISTA COM O NOME adoSO.txt

x="sair"
#Lista todos os nomes do arquivo adoSO.txt
listarNomes(){
    echo "Nomes:"

    sed '/^$/d' adoSO.txt

    read -n 1 -s -p "Pressione qualquer tecla para continuar"


    echo "================================================"


}

procurarNome(){

    echo "Digite um nome para buscar:"
    #Nome digitado atribuído para var nome
    read nome 
    echo "Nome procurado: " $nome 
    #torna a var resultado vazia
    unset resultado
    #Tenta buscar o nome na lista
    resultado=`grep -i "$nome" adoSO.txt`
    #Se resultado vazio
    if [[ -z "$resultado" ]]
        #Informa que o nome não foi encontrado
        then 
        echo "Nome $resultado não encontrado"
        echo "Lista dos nomes"
        listarNomes
    #caso contrário lista os nomes encontrados
else 
    echo "Nome(s) encontrado(s):"
    echo $resultado
    read -n 1 -s -p "Pressione qualquer tecla para continuar"

fi
echo "================================================"


}


removerNome(){

    echo "Informe o nome para ser removido"
    read nome
    resultado=`grep -i "$nome" adoSO.txt`

    if [[ -z $resultado ]]
        then
        echo "Nome não encontrado"
        read -n 1 -s -p "Pressione qualquer tecla para continuar"
        menu
    else
        echo "Nome encontrado: " $resultado

        echo "Deseja remover" $resultado "?" "(1-sim 2-não)"
        read option

        case $option in 

            1)
        #No comando abaixo o valor do resultado será substituido por
        # "nada"
        if [  result=`sed -ie s/$resultado//g adoSO.txt`  ]
            then
            echo "Removido"
            unset option
            read -n 1 -s -p "Pressione qualquer tecla para continuar"
        fi
        ;;

        2)
echo "Voltando!"
unset option
sleep 1
;;

*)
echo "Opção inválida!"
unset option
read -n 1 -s -p "Pressione qualquer tecla para continuar"

;;
esac

echo "================================================"
fi
}

insereNome(){
    echo "Digite o nome que será inserido"
    read nome
    #echo para inserir na proxima linha, após ultimo conteúdo
    echo -e $nome >> adoSO.txt

    echo "Inserido"
    read -n 1 -s -p "Pressione qualquer tecla para continuar"

    echo "================================================"

}

corrigirNome(){
    echo "Digite o nome contido na listalista"
    read nome

    echo "Digite o nome que irá substituir:" $nome
    read substituto

    resultado=`grep -i "$nome" adoSO.txt`
    if [[ -z $resultado ]]
        then
        echo "Nome não encontrado"
        sleep 2 
        menu
    else    
        echo "Nome encontrado: " $resultado

        echo "Deseja substituir" $resultado "?" "por" $substituto "(1-sim 2-não)"
        read option

        case $option in 

            1)
#Abaixo comando utilizado para trocar uma palavra pela outra
if [  result=`sed -ie s/$resultado/$substituto/g adoSO.txt`  ]
    then
    echo "Substituído"
    unset resultado
    unset option
    read -n 1 -s -p "Pressione qualquer tecla para continuar"
fi 


;;

2)
echo "Voltando!"
unset option
sleep 1

;;

*)
echo "Opção inválida!"
unset option
read -n 1 -s -p "Pressione qualquer tecla para continuar"

;;
esac

fi


echo "================================================"


}

trazerListaOrdenada(){
#Comando que apenas lista de forma ordenada
sed '/^$/d' adoSO.txt | sort
read -n 1 -s -p "Pressione qualquer tecla para continuar"

}

ordernarListaNoArquivo(){
#para ordenar crio um arquivo recebendo a listar já ordenada
cat adoSO.txt | sort > o.txt
#após, sobrescrevo o arquivo original com o mesmo conteúdo
#porém ordenado
cat o.txt > adoSO.txt
#removo o arquivo auxiliar
rm o.txt
    #mostra a lista
    #remove linhas em branco
    sed -i '/^$/d' adoSO.txt
    echo "Lista ordenada"
    read -n 1 -s -p "Pressione qualquer tecla para continuar"
}

embaralharLista(){
    #mesmo caso do ordernarListaNoArquivo(), porém o sort 
    #com o parâmetro -R, embaralha a lista
    cat adoSO.txt | sort -R > o.txt
    cat o.txt > adoSO.txt
    rm o.txt
    #remove linhas em branco
    sed -i '/^$/d' adoSO.txt
    echo "Lista Embaralhada"
    read -n 1 -s -p "Pressione qualquer tecla para continuar"

}


menu ()
{
    while true $x != "sair"
    do
        clear
        echo "================================================"
        echo "Desenvolvido por:    WILLIAN MAQUES VIEIRA"
        echo "================================================"
        
        echo "1)Listar nomes"
        echo""
        echo "2)Procurar por nome"
        echo ""
        echo "3)Remover nome"
        echo ""
        echo "4)Insere nome"
        echo""
        echo "5)Corrigir nome "
        echo""
        echo "6)Trazer lista ordenada"
        echo""
        echo "7)Ordenar lista no arquivo"
        echo ""
        echo "8)Embaralhar lista no arquivo"
        echo ""
        echo "9)Sair"
        echo ""
        echo "================================================"

        echo "Digite a opção desejada:"
        read x
        echo "Opção informada ($x)"
        echo "================================================"

        case "$x" in


            1)
listarNomes
removerTodos
;;
2) 
procurarNome
;;
3)
removerNome
;;
4)
insereNome
;;
5)
corrigirNome
;;

6)

trazerListaOrdenada
;;

7)
ordernarListaNoArquivo
;;

8)
embaralharLista
;;
9)
#Contagem regressiva para sair
for i in {3..1}
do
    echo -en "saindo em $i\r"

    sleep 1

done
clear;
$x="sair"
#Utlizei o break para não fechar meu terminal, mas poderia ter usar o 
#exit
break
#exit
echo "================================================"
;;



*)
echo "Opção inválida!"
esac
done

}
menu
