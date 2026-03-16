#include <stdio.h>

int main() {

    /*Lucro por unidade*/
    float lucro_cadeira = 50.0, lucro_mesa = 120.0, lucro_armario = 200.0; 

    /*Consumo por unidade*/
    float madeira_cadeira = 0.5, madeira_mesa = 1.2, madeira_armario = 2.0;
    float horas_cadeira = 0.3, horas_mesa = 3, horas_armario = 7;

    /*Quantidade ótima de cadeira, armario e mesa e lucro dessa producao*/
    int melhor_cadeira = 0, melhor_armario = 0, melhor_mesa = 0;
    float lucro_otimo = 0;

    /*Recursos*/
    float madeira_disponivel = 50, horas_disponiveis = 160, estoque_maximo=40;
    
    int c, m, a, total_moveis = 0;
    float madeira_usada = 0, horas_usadas = 0, lucro;

    
    for(c = 0; c <= estoque_maximo ; c++) {
        for(m = 0; m <= estoque_maximo ; m++) {
            for(a = 0; a <= estoque_maximo ; a++) {

                

                madeira_usada = c * madeira_cadeira + m * madeira_mesa + a * madeira_armario;

                horas_usadas = c * horas_cadeira + m * horas_mesa + a * horas_armario;

                total_moveis = c + m + a;
                
                lucro = c * lucro_cadeira + m * lucro_mesa + a * lucro_armario;

                if(madeira_usada <= madeira_disponivel && horas_usadas <= horas_disponiveis && total_moveis <= estoque_maximo) {
                    printf("C: %d M:%d A: %d - Lucro: %.2f\n", c, m, a, lucro);
                    
                    if (lucro > lucro_otimo) {
                        lucro_otimo = lucro;
                        melhor_cadeira = c;
                        melhor_mesa = m;
                        melhor_armario = a;
                    }
                }

            }
        }
    }
    
    printf("Melhor quantidade de cadeiras: %d\n", melhor_cadeira);
    printf("Melhor quantidade de mesas: %d\n", melhor_mesa);
    printf("Melhor quantidade de armario: %d\n", melhor_armario);
    printf("Lucro: %.2f\n", lucro_otimo);

    return 0;
}