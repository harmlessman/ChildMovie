
double calculator(int userNum, {int months = 1, int dayUpdateNum = 10, int monthUpdateNum = 300, double pricePerUnit = 0.038}){
  final double dayUpdatePrice;
  final double monthUpdatePrice;

  dayUpdatePrice = dayUpdateNum * userNum > 50000 ?
  ((((dayUpdateNum * userNum)-50000) / 100000) * pricePerUnit)*30 : 0;

  monthUpdatePrice = monthUpdateNum * userNum > 50000 ?
  (((monthUpdateNum * userNum)-50000) / 100000) * pricePerUnit : 0;

  print('업데이트 유형 별 월 요금 (사용자 $userNum명 기준)');
  print('dayUpdatePrice = 약 ${dayUpdatePrice.toStringAsFixed(3)}\$');
  print('monthUpdatePrice = 약 ${monthUpdatePrice.toStringAsFixed(3)}\$');

  if (dayUpdatePrice>0 && monthUpdatePrice>0){
    print("비싼 배율 => 약 ${(monthUpdatePrice/dayUpdatePrice).toStringAsFixed(3)}배");
  }
  return monthUpdatePrice/dayUpdatePrice;
}

void main(){
  calculator(10000);
}