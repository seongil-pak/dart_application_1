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
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];
  
  int totalCartPrice = 0;  // 장바구니에 담은 상품들의 총 가격
  List<String> cartItems = [];  // 장바구니에 담긴 상품 목록

  // 판매하는 상품 목록을 출력하는 메서드
  void showProducts() {
    print('판매 상품 목록:');
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  // 상품을 장바구니에 담는 메서드
  void addToCart() {
    stdout.write('장바구니에 담을 상품 이름을 입력하세요: ');
    String? productName = stdin.readLineSync();  // 상품 이름 입력 받기
    stdout.write('상품 개수를 입력하세요: ');
    String? quantityInput = stdin.readLineSync();  // 상품 개수 입력 받기

    if (productName == null || quantityInput == null) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    int? quantity;
    try {
      quantity = int.parse(quantityInput);
    } catch (e) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    if (quantity <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요!');
      return;
    }

    var foundProducts = products.where((product) => product.name == productName);
    Product? selectedProduct = foundProducts.isNotEmpty ? foundProducts.first : null;

    if (selectedProduct == null) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    totalCartPrice += selectedProduct.price * quantity;
    for (var i = 0; i < quantity; i++) {
      cartItems.add(selectedProduct.name);
    }
    print('장바구니에 상품이 담겼어요!');
  }

  // 장바구니에 담긴 상품들의 목록과 총 가격을 출력하는 메서드
  void showCartContents() {
    if (cartItems.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      String itemList = cartItems.join(', ');
      print('장바구니에 $itemList가 담겨있네요. 총 ${totalCartPrice}원입니다!');
    }
  }

  // 장바구니를 초기화하는 메서드
  void clearCart() {
    if (cartItems.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
    } else {
      cartItems.clear();
      totalCartPrice = 0;
      print('장바구니가 초기화되었습니다.');
    }
  }

  // 프로그램을 종료할 때 사용자에게 종료 여부를 확인하는 메서드
  void exitProgram() {
    stdout.write('정말 종료하시겠습니까? (y/n): ');
    String? confirmation = stdin.readLineSync();
    if (confirmation != null && confirmation.toLowerCase() == 'y') {
      print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
    } else {
      print('종료가 취소되었습니다.');
    }
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
    print('3. 장바구니 목록 및 총 가격 보기');
    print('4. 프로그램 종료');
    print('6. 장바구니 초기화');
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
        // 3을 입력하면 장바구니 목록과 총 가격을 출력
        mall.showCartContents();
        break;
      case '4':
        // 4를 입력하면 프로그램 종료 여부 확인
        mall.exitProgram();
        if (stdin.readLineSync()?.toLowerCase() == 'y') {
          running = false;
        }
        break;
      case '6':
        // 6을 입력하면 장바구니 초기화
        mall.clearCart();
        break;
      default:
        // 1, 2, 3, 4, 6 외의 입력값에 대한 오류 메시지 출력
        print('지원하지 않는 기능입니다! 다시 시도해 주세요.');
    }
  }
}