import 'dart:io'; // Standart input/output işlemleri için gerekli kütüphane.

void main() {
  // 'money2' isminde bir tamsayı (int) değişkeni oluşturduk ve başlangıç değerini 10 olarak atadık.
  int money2 = 10;
  // Konsola "1" yazdırılıyor.
  print("1");

  // myVoid isimli fonksiyon çağrılıyor, bu fonksiyon yalnızca konsola "2" yazdıracak.
  myVoid();

  // getName fonksiyonu çağrılıyor ve 'money2' değeri bu fonksiyona parametre olarak veriliyor.
  // Fonksiyonun dönüş değerini (string) konsola yazdırıyoruz.
  print(getName(money2));

  // 'const' ile sabit bir string değişken oluşturuyoruz, değeri program boyunca değiştirilemez.
  const String name = "Cihan";

  // 'final' ile bir string değişken oluşturuyoruz, bu değişkenin değeri sadece bir kez atanabilir.
  // 'const' farkı, 'final' değişkenleri runtime sırasında da atanabilir.
  final String second_name = "Utku";

  // 'surname' adında string bir değişken oluşturduk. Diğerlerinden farkı, bu değişkenin değeri sonradan değiştirilebilir.
  String surname = "Akgün";

  // 'isBigger' adında boolean bir değişken oluşturduk. true/false değer tutar.
  bool isBigger = false;

  // 'age' adında integer (tamsayı) bir değişken oluşturduk. Yaş bilgisi tutmak için kullanıyoruz.
  int age = 15;

  // 'money' adında bir double (ondalıklı sayı) değişkeni oluşturduk ve 100.5 olarak başlatıyoruz.
  double money = 100.5;

  // 'dynamic' türde bir değişken oluşturduk, bu türde değişkenin veri tipi runtime (çalışma zamanında) değişebilir.
  dynamic val = "";

  // Koşul kontrolü: Eğer 'age' 20'den büyükse 'isBigger' false olacak, değilse true olacak.
  // Bu kontrolle yaşı 20'nin üzerinde olanları belirlemeye çalışıyoruz.
  if (age > 20) {
    isBigger = false; // Eğer yaş 20'den büyükse, isBigger false olacak.
  } else {
    isBigger =
        true; // Eğer yaş 20'den küçük ya da eşitse, isBigger true olacak.
  }

  // String türünde bir liste oluşturduk ve bu listede isimler tutuluyor.
  List<String> names = ["Ali", "Veli", "Cihan", "Mehmet"];

  // Integer türünde bir liste oluşturduk ve yaş bilgilerini burada saklıyoruz.
  List<int> ages = [15, 20, 17, 49, 67];

  // Map yapısı ile birden fazla türde veriyi bir arada saklayabiliyoruz. Burada 'user1' adında bir kullanıcı oluşturduk.
  Map user1 = {
    "name": "Cihan Akgün", // Kullanıcının adı.
    "age": 21, // Kullanıcının yaşı.
    "school": "Sabahattin Zaim", // Kullanıcının okuduğu okul.
    "isStudent":
        false // Kullanıcının öğrenci olup olmadığını belirten boolean değer.
  };

  // 'user1' adlı haritadaki tüm verileri dolaşmak için forEach kullanıyoruz.
  // Map, anahtar (key) ve değer (value) çiftlerinden oluşur, bu yüzden her anahtar ve değeri sırasıyla işliyoruz.
  user1.forEach(((key, value) {
    // Eğer anahtar 'name' ise, o anahtara ait değeri yazdırıyoruz.
    key == "name" ? print("$key :$value") : null;

    // Alternatif olarak, if koşulu ile aynı işlemi yapıyoruz.
    if (key == "name") {
      print("$key :$value");
    } else {
      null;
    }
  }));

  // 'for' döngüsü ile 'names' adlı listenin belirli elemanlarını yazdırıyoruz.
  // Döngü, 'i' değişkeni 0'dan başlıyor ve her döngüde 2 artarak devam ediyor. Bu şekilde 2 eleman atlıyoruz.
  for (var i = 0; i < 4; i = i + 2) {
    print("Eleman ${i}: ${names[i]}"); // i. sıradaki elemanı yazdırıyoruz.
  }

  // Listeden belirli elemanları sırasıyla ekrana yazdırıyoruz.
  print(names[0]); // 'Ali' yazdırılacak.
  print(names[1]); // 'Veli' yazdırılacak.
  print(names[2]); // 'Cihan' yazdırılacak.
  print(names[3]); // 'Mehmet' yazdırılacak.

  // 'user2' adında yeni bir kullanıcı map'i oluşturuyoruz.
  Map user2 = {
    "name": "Burak",
    "age": 21,
    "school": "YTÜ",
  };

  // 'users' adında bir liste oluşturduk ve içinde iki kullanıcı (user1, user2) bulunuyor.
  List<Map> users = [user1, user2];

  // Kullanıcıdan klavyeden giriş alıyoruz. Bu giriş, 'namess' adlı string değişkenine atanıyor.
  String? namess = stdin.readLineSync();

  // Yaşa göre bir koşul kontrolü yapıyoruz. Eğer yaş 2 ise, "sen iki yaşındasın" yazdırılacak.
  if (age == 2) {
    print("sen iki yaşındasın");
  } else if (age == 15) {
    // Eğer yaş 15 ise, yaşı yazdırıyoruz.
    print(age);
  } else {
    // Eğer başka bir yaşsa, yaş bir artırılıyor ve uyarı mesajı yazdırılıyor.
    age += 1;
    print(age);
    print("yaşınız sistemimize uygun değil");
  }

  // Switch-case yapısını kullanarak yaşı kontrol ediyoruz. Yaşın değerine göre ilgili mesaj yazdırılıyor.
  switch (age) {
    case 2:
      print("sen iki yaşındasın");
      break;
    case 15:
      print(age);
    default:
      age += 1; // Default durumunda yaş bir artırılıyor.
      print(age);
      print("yaşınız sistemimize uygun değil");
  }

  // Eğer para miktarı 100.5'ten farklıysa, "Paran az kalmış" yazdırılıyor. Değilse, "Yeterince paran var" yazılıyor.
  if (money != 100.5) {
    print("Paran az kalmış");
  } else {
    print("Yeterince paran var");
  }

  // Para miktarını artırma ve azaltma işlemleri yapıyoruz.
  money = money + 10; // Paraya 10 ekliyoruz.
  money += 10; // Bir kez daha 10 ekliyoruz.
  money -= 20; // Paradan 20 çıkarıyoruz.
  money *= 5; // Parayı 5 ile çarpıyoruz.

  // String birleştirme yöntemlerini gösteriyoruz. İki farklı yöntem kullanarak isim soyisim bilgilerini birleştiriyoruz.
  print(name + second_name + surname); // + operatörü ile string birleştirme.
  print(
      "$name $second_name $surname"); // String interpolasyonu ile birleştirme.

  // 'Ben [isim] ve ben [yaş] yaşındayım' cümlesini yazdırıyoruz.
  print("Ben $name $second_name $surname ve ben $age yaşındayım");

  // 'runtimeType' ile değişkenin türünü kontrol ediyoruz.
  print(age.runtimeType); // 'age' değişkeninin veri tipini yazdırıyoruz.
  print(age.toString()); // 'age' değişkenini stringe çevirip yazdırıyoruz.
  print(age
      .toString()
      .runtimeType); // Stringe çevrilmiş değerin veri tipini yazdırıyoruz.
}

// 'myVoid' isimli basit bir fonksiyon. Konsola sadece "2" yazdırıyor.
void myVoid() {
  print("2");
}

// 'getName' fonksiyonu, verilen para miktarına göre bir string mesaj döndürüyor.
// Belirli para miktarlarına göre farklı mesajlar var.
String getName(int money) {
  switch (money) {
    case 50:
      return "Paran yetersiz"; // Eğer para 50 ise, bu mesaj döner.
    case 100:
      return "Satın alabilirsiniz"; // Eğer para 100 ise, bu mesaj döner.
    case 150:
      return "1.5 porsiyon alabilirsiniz"; // Eğer para 150 ise, bu mesaj döner.
    default:
      return "Geçerli ücret girin"; // Diğer tüm durumlarda bu mesaj döner.
  }
}
