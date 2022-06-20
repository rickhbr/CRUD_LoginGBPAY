void fessCalculate(List<double> result, valor, List<double> fees, List<String> listOfParcels) {
    for (int i = 0; i < fees.length; i++) {
        result.add(valor + valor * fees[i]);
      }
      for (int j = 0; j < fees.length; j++) {
        if (j == 0) {
          listOfParcels.add(
             '${j+1}x de R\$ ${result[j].toStringAsFixed(2).replaceAll('.', ',')}');
        } else if(j > 0){
          listOfParcels.add(
              '${j+1}x de R\$ ${(result[j]/(j+1)).toStringAsFixed(2).replaceAll('.', ',')}, total de R\$ ${result[j].toStringAsFixed(2).replaceAll('.', ',')}');
        }
      }
}