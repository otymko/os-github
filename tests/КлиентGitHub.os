#Использовать ".."
#Использовать asserts
#Использовать fs

Перем Токен;

Процедура ПередЗапускомТеста() Экспорт

	ЗначениеПеременнойСреды = ПолучитьПеременнуюСреды("GITHUB_TOKEN");
	Если Не ЗначениеЗаполнено(ЗначениеПеременнойСреды) Тогда
		ИмяФайла = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "token.txt");
		Файл = Новый Файл(ИмяФайла);
		Если Не Файл.Существует() Тогда
			ВызватьИсключение("Не найден файл с токеном. Файл должен находится по пути ./fixtures/token.txt");
		КонецЕсли;

		ТекстовыйДокумент = Новый ТекстовыйДокумент();
		ТекстовыйДокумент.Прочитать(ИмяФайла);
		Токен = ТекстовыйДокумент.ПолучитьТекст();
	Иначе
		Токен = ЗначениеПеременнойСреды;
	КонецЕсли;
	
	ТекстовыйДокумент = Неопределено;

КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт

КонецПроцедуры

&Тест
Процедура Тест_ПроверитьПолучениеПользователя() Экспорт

	Клиент = Новый КлиентGitHub();
	Клиент.ИспользоватьТокен(Токен);

	ИмяПользователя = "freeCodeCamp";

	Пользователь = Клиент.ПолучитьПользователя(ИмяПользователя);
	Ожидаем.Что(Пользователь, "Пользователь guthib получен по имени").Заполнено();

	Пользователь = Клиент.ПолучитьПользователя(Новый ПользовательGitHub(ИмяПользователя));
	Ожидаем.Что(Пользователь, "Пользователь guthib получен по объекту").Заполнено();
	Ожидаем.Что(Пользователь.Логин, "Имя пользователя github совпадает с полученным").Равно(ИмяПользователя);

КонецПроцедуры

&Тест
Процедура Тест_ПроверитьПолучениеОрганизации() Экспорт

	Клиент = Новый КлиентGitHub();
	Клиент.ИспользоватьТокен(Токен);

	ИмяОрганизации = "github";
	Организация = Клиент.ПолучитьОрганизацию(ИмяОрганизации);
	Ожидаем.Что(Организация, "Организация guthib получена по имени").Заполнено();

	Организация = Клиент.ПолучитьОрганизацию(Новый ОрганизацияGitHub(ИмяОрганизации));
	Ожидаем.Что(Организация, "Организация guthib получена по объекту").Заполнено();

КонецПроцедуры

&Тест
Процедура Тест_ПроверитьПолучениеРепозитория() Экспорт

	Клиент = Новый КлиентGitHub(Токен);

	ИмяРепозитория = "freeCodeCamp";
	ИмяВладельца = "freeCodeCamp";
	Репозиторий = Клиент.ПолучитьРепозиторий(ИмяВладельца, ИмяРепозитория);
	Ожидаем.Что(Репозиторий, "Репозиторий guthib получен по логину и имени").Заполнено();

	ИмяВладельца = "otymko";
	ИмяРепозитория = "os-github";
	Пользователь = Новый ПользовательGitHub(ИмяВладельца);
	Репозиторий = Клиент.ПолучитьРепозиторий(Пользователь, ИмяРепозитория);
	Ожидаем.Что(Репозиторий, "Репозиторий guthib получен по пользователю и имени").Заполнено();

	ИмяВладельца = "freeCodeCamp";
	ИмяРепозитория = "freeCodeCamp";
	Организация = Новый ПользовательGitHub(ИмяВладельца);
	Репозиторий = Клиент.ПолучитьРепозиторий(Организация, ИмяРепозитория);
	Ожидаем.Что(Репозиторий, "Репозиторий guthib получен по организации и имени").Заполнено();

	Репозиторий = Клиент.ПолучитьРепозиторий(Новый РепозиторийGitHub(ИмяВладельца + "/" + ИмяРепозитория));
	Ожидаем.Что(Репозиторий, "Репозиторий guthib получен по объекту").Заполнено();

КонецПроцедуры

&Тест
Процедура Тест_ПроверитьПолучениеСотрудниковРепозитория() Экспорт

	Клиент = Новый КлиентGitHub(Токен);

	ИмяПользователя = "oscript-library";
	ИмяРепозитория = "add";
	Сотрудники = Клиент.ПолучитьСотрудниковРепозитория(ИмяПользователя, ИмяРепозитория);
	Ожидаем.Что(Сотрудники.Количество(), "Найдены collaborators по логину и имени репозитория").Больше(0);

КонецПроцедуры

&Тест
Процедура Тест_ПроверитьПолучениеРепозиториевПоВладельцу() Экспорт
	
	Клиент = Новый КлиентGitHub(Токен);	

	Владелец = Новый ОрганизацияGitHub("oscript-library");
	НомерСтраницы = 1;
	КоличествоНаСтранице = 10;

	Список = Клиент.ПолучитьРепозиторииПоВладельцу(Владелец, НомерСтраницы, КоличествоНаСтранице);
	Ожидаем.Что(Список, "Список репозиториев получен по владельцу (организация)").Заполнено();
	Ожидаем.Что(Список.Количество(), "Количество репозиториев получено = 10").Равно(10);
	
	Владелец = Новый ПользовательGitHub("otymko");
	Список = Клиент.ПолучитьРепозиторииПоВладельцу(Владелец);
	Ожидаем.Что(Список, "Список репозиториев получен по владельцу (пользователь)").Заполнено();
	Ожидаем.Что(Список.Количество(), "Получено репозиториев > 0").Больше(0);

КонецПроцедуры

&Тест
Процедура Тест_ПроверитьНавигаторРепозиториев() Экспорт

	Клиент = Новый КлиентGitHub(Токен);	
	Владелец = Клиент.ПолучитьОрганизацию(Новый ОрганизацияGitHub("oscript-library"));

	Навигатор = Новый НавигаторРепозиториев(Владелец, 20);
	Результат = Навигатор.ПолучитьВесьСписок(Клиент);
	Ожидаем.Что(Результат, "Получен весь список репозиториев через навигацию").Равно(Истина);

	Навигатор = Новый НавигаторРепозиториев(Владелец, 20);
	Ожидаем.Что(Навигатор.КоличествоРепозиториев(), "Количество репозиториев больше нуля").Больше(0);
	Ожидаем.Что(Навигатор.КоличествоСтраниц(), "Количество страниц больше нуля").Больше(0);

	Для ТекущийНомер = 1 По Навигатор.КоличествоСтраниц() Цикл
		Результат = Навигатор.ПолучитьСледующие(Клиент);
		Ожидаем.Что(Результат, СтрШаблон("Результат получен (%1)", ТекущийНомер)).Равно(Истина);
		Ожидаем.Что(Навигатор.Репозитории().Количество(), "В текущей пачке репозиториев больше 0").Больше(0);
	КонецЦикла;

	Результат = Навигатор.ПолучитьСледующие(Клиент);
	Ожидаем.Что(Результат, "Следующая пачка не получена").Равно(Ложь);

КонецПроцедуры

&Тест
Процедура Тест_ПроверитьПолучениеКонтента() Экспорт

	Клиент = Новый КлиентGitHub(Токен);	
	Репозиторий = Новый РепозиторийGitHub("otymko/os-github");

	Контент = Клиент.ПолучитьКонтент(Репозиторий, "readme");
	Ожидаем.Что(Контент, "Контент readme получен").Заполнено();

	ДД = Контент.ДвоичныеДанные();
	Ожидаем.Что(Контент, "Двоичные данные readme получены").Заполнено();

	ИмяКаталога = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "test");
	ФС.ОбеспечитьКаталог(ИмяКаталога);
	ИмяФайла = ОбъединитьПути(ИмяКаталога, Контент.Имя);
	ДД.Записать(ИмяФайла);
	ДД = Неопределено;

	Файл = Новый Файл(ИмяФайла);
	Ожидаем.Что(Файл.Существует(), "Файл контента сохранен").Равно(Истина);

	Попытка
		УдалитьФайлы(ИмяФайла);
	Исключение
		Сообщить("Не удалось удалить временный файл");
	КонецПопытки;

	Попытка
		УдалитьФайлы(ИмяКаталога);
	Исключение
		Сообщить("Не удалось удалить временный каталог");
	КонецПопытки;

КонецПроцедуры

Токен = "";