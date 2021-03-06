
Перем Владелец;
Перем КоличествоСтраниц;
Перем ТекущаяСтраница;
Перем КоличествоНаСтранице;
Перем КоличествоРепозиториев;
Перем СписокРепозиториев;

Процедура ПриСозданииОбъекта(пВладелец, пКоличествоНаСтраница = 20)

	Владелец = пВладелец;
	КоличествоНаСтранице = пКоличествоНаСтраница;
	КоличествоРепозиториев = Владелец.Репозиториев;
	КоличествоСтраниц = ЦелоеКоличествоСтраниц(КоличествоРепозиториев, КоличествоНаСтранице);

КонецПроцедуры

Функция КоличествоСтраниц() Экспорт
	Возврат КоличествоСтраниц;
КонецФункции

Функция ТекущаяСтраница() Экспорт
	Возврат ТекущаяСтраница;
КонецФункции

Функция КоличествоРепозиториев() Экспорт
	Возврат КоличествоРепозиториев;
КонецФункции

Функция Репозитории() Экспорт
	Возврат СписокРепозиториев;
КонецФункции

Функция ПолучитьСледующие(Клиент) Экспорт

	Результат = Ложь;
	СписокРепозиториев.Очистить();

	ВременнаяТекущаяСтраница = ТекущаяСтраница + 1;
	Если ВременнаяТекущаяСтраница > КоличествоСтраниц Тогда
		Возврат Результат;
	КонецЕсли;

	ТекущаяСтраница = ВременнаяТекущаяСтраница;

	Список = Клиент.ПолучитьРепозиторииПоВладельцу(Владелец, ТекущаяСтраница, КоличествоНаСтранице);
	Если Список = Неопределено Тогда
		Сообщить("Не удалось получить список репозиториев");
	Иначе
		Результат = Истина;
		СписокРепозиториев = Список;
	КонецЕсли;

	Возврат Результат;

КонецФункции

Функция ПолучитьВесьСписок(Клиент) Экспорт

	Результат = Истина;

	Если КоличествоНаСтранице = 0 Тогда
		Возврат Ложь;
	КонецЕсли;

	СписокРепозиториев = Новый Массив;
	ТекущаяСтраница = 1;
	Для ТекущаяСтраница = 1 По КоличествоСтраниц Цикл
		Список = Клиент.ПолучитьРепозиторииПоВладельцу(Владелец, ТекущаяСтраница, КоличествоНаСтранице);
		Если Список = Неопределено Тогда
			Результат = Ложь;
			Сообщить("Не удалось получить список репозиториев");
			Прервать;
		Иначе
			Для Каждого Репозиторий Из Список Цикл
				СписокРепозиториев.Добавить(Репозиторий);	
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;

КонецФункции

Функция ЦелоеКоличествоСтраниц(ОбщееКоличество, КоличествоВПорции)

	Результат = 0;
	Если КоличествоВПорции = 0 Тогда
		Возврат Результат;
	КонецЕсли;

	Результат = ОбщееКоличество / КоличествоВПорции;
	РезультатЦелое = Цел(Результат);
	Если Результат > РезультатЦелое Тогда
		Результат = РезультатЦелое + 1;
	КонецЕсли;

	Возврат Результат;

КонецФункции

КоличествоСтраниц = 0;
ТекущаяСтраница = 0;
КоличествоНаСтранице = 0;
КоличествоРепозиториев = 0;

СписокРепозиториев = Новый Массив;
