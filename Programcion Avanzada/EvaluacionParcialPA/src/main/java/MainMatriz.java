public class MainMatriz {

    public static void main(String[] args) {

        int [][] mat = {

            {2, 8, 21, 33},
            {53, 77, 101, 117},
            {419, 477, 503, 601}

        };

        // Numeros ShopieGermain

        for(var row: mat){

            NumerosPrimos numsSG = new ShopieGermain(row);
            Thread thShopieGermain = new Thread(numsSG,"Numeros SophieGermain");
            thShopieGermain.start();

        }

    }

}


