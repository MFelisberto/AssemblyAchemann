import java.util.Scanner;

public class App {

    public static int ackermann(int m, int n) { // Função Ackermann-Péter A(m, n)
        if (m == 0) { // se m=0, ira retornar o valor de n+1
            return n + 1;
        }
        if (m > 0 && n == 0) { // se m>0 e n=0, a função ira ser chamada novamente
            return ackermann(m - 1, 1); // passando agora os parametros m-1 e n=1
        }
        return ackermann(m - 1, ackermann(m, n - 1)); // se passar por estes dois ifs, entendesse que m>0 e n>0
    }

    public static void main(String[] args) throws Exception { // classe main

        Scanner in = new Scanner(System.in); // inicializando o scanner

        // prints para conversar com o usuario e mostrar os integrantes do grupo
        System.out.println("Programa Ackermann");
        System.out.println("Componentes: <Arthur, Marcelo e Mateus>");

        // inicializando as variavies m e n, que serao utilizadas
        int m = 0;
        int n = 0;
        while (m >= 0 && n >= 0) {// laço..

            System.out.println("Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução");

            // lê um int do teclado e armazena no m
            m = in.nextInt();
            if (m < 0) {// se o int lido for negativo ja finaliza o programa
                break;
            }

            // lê um int do teclado e armazena no n
            n = in.nextInt();
            if (n < 0) {// se o int lido for negativo ja finaliza o programa
                break;
            }

            System.out.printf("A(%d, %d) = %d\n", m, n, ackermann(m, n)); // printa os resultados apos a chamada da
                                                                          // função

        }

        // fim
        System.out.println("FIM DO PROGRAMA");
    }
}
