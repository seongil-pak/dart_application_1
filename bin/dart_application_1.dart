import 'dart:io';

// 상품을 정의하는 Product 클래스
class Product {
  String name;  // 상품 이름
  int price;    // 상품 1개당 가격

  Product(this.name, this.price);
}

// 쇼핑몰을 정의하는 ShoppingMall 클래스
class ShoppingMall {
  List<Product> products = [
    // 판매하는 상품 목록
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];
  
  int totalCartPrice = 0;  // 장바구니에 담은 상품들의 총 가격

  // 판매하는 상품 목록을 출력하는 메서드
  void showProducts() {
    print('판매 상품 목록:');
    for (var product in products) {
      // 각 상품의 이름과 가격을 출력
      print('${product.name} / ${product.price}원');
    }
  }

  // 상품을 장바구니에 담는 메서드
  void addToCart() {
    stdout.write('장바구니에 담을 상품 이름을 입력하세요: ');
    String? productName = stdin.readLineSync();  // 상품 이름 입력 받기
    stdout.write('상품 개수를 입력하세요: ');
    String? quantityInput = stdin.readLineSync();  // 상품 개수 입력 받기

    // 입력값이 null일 경우 유효하지 않은 입력으로 처리
    if (productName == null || quantityInput == null) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    int? quantity;
    try {
      // 문자열로 입력된 상품 개수를 int로 변환
      quantity = int.parse(quantityInput);
    } catch (e) {
      // 변환이 실패하면 유효하지 않은 입력으로 처리
      print('입력값이 올바르지 않아요!');
      return;
    }

    // 상품 개수가 0 이하일 때 오류 메시지 출력
    if (quantity <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요!');
      return;
    }

    // 상품 목록에서 입력한 상품 이름과 일치하는 상품 찾기
    var foundProducts = products.where((product) => product.name == productName);
    Product? selectedProduct = foundProducts.isNotEmpty ? foundProducts.first : null;

    // 일치하는 상품이 없을 경우 오류 메시지 출력
    if (selectedProduct == null) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    // 총 가격에 선택한 상품의 가격 * 개수를 더해주기
    totalCartPrice += selectedProduct.price * quantity;
    print('장바구니에 상품이 담겼어요!');
  }

  // 장바구니에 담긴 상품들의 총 가격을 출력하는 메서드
  void showTotalPrice() {
    print('장바구니에 ${totalCartPrice}원 어치를 담으셨네요!');
  }

  // 프로그램을 종료할 때 메시지를 출력하는 메서드
  void exitProgram() {
    print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
  }
}

// 메인 함수: 프로그램의 진입점
void main() {
  ShoppingMall mall = ShoppingMall();  // ShoppingMall 인스턴스 생성
  bool running = true;  // 프로그램 실행 상태를 나타내는 변수

  // 사용자가 4를 입력할 때까지 프로그램 계속 실행
  while (running) {
    print('\n--- 쇼핑몰 프로그램 ---');
    print('1. 판매 상품 목록 보기');
    print('2. 상품 장바구니에 담기');
    print('3. 장바구니 총 가격 보기');
    print('4. 프로그램 종료');
    stdout.write('번호를 선택하세요: ');

    String? input = stdin.readLineSync();  // 사용자 입력 받기

    switch (input) {
      case '1':
        // 1을 입력하면 판매 상품 목록을 출력
        mall.showProducts();
        break;
      case '2':
        // 2를 입력하면 상품을 장바구니에 담기
        mall.addToCart();
        break;
      case '3':
        // 3을 입력하면 장바구니 총 가격을 출력
        mall.showTotalPrice();
        break;
      case '4':
        // 4를 입력하면 프로그램 종료
        mall.exitProgram();
        running = false;
        break;
      default:
        // 1, 2, 3, 4 외의 입력값에 대한 오류 메시지 출력
        print('지원하지 않는 기능입니다! 다시 시도해 주세요.');
    }
  }
}