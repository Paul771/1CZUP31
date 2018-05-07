
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбновитьАдресРезюме();
	УстановитьВидимостьЭлементовФормы();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	УстановитьВидимостьФайлаРезюме(ТекущийОбъект);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ИсточникПриИзменении(Элемент)
	ОбновитьАдресРезюме();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗарегистрироватьКандидата(Команда)
	
	СозданКандидат = Ложь;
	ИнтеграцияРекрутинговыхСайтовКлиент.СоздатьКандидатаПоРезюме(Запись.ИдентификаторРезюме, Запись.Источник, Запись.Вакансия, СозданКандидат);
	
	Если СозданКандидат Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеКандидата = ПодборПерсоналаКлиентСервер.ОписаниеРезюмеКандидата();
	ЗаполнитьРезюмеКандидатаПоДаннымОтклика(ОписаниеКандидата);
	
	ПараметрыФормы = Новый Структура("СтруктураРезюме");
	ПараметрыФормы.СтруктураРезюме = ОписаниеКандидата;
	
	ОткрытьФорму("Справочник.Кандидаты.Форма.ФормаЭлемента", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлРезюме(Команда)
	ОткрытьФайлРезюмеНаКлиенте();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьАдресРезюме()
	
	АдресРезюме = Запись.АдресРезюме;
	
	Если АдресРезюме = "" 
		И Запись.Источник = ИнтеграцияРекрутинговыхСайтовКлиентСервер.HeadHunter() Тогда
		
		АдресРезюме = "http://hh.ru/resume/" + Запись.ИдентификаторРезюме;
		
	КонецЕсли;
	
	Если ЗначениеЗаполнено(АдресРезюме) Тогда
		
		ЧастиСтроки = Новый Массив;
		ЧастиСтроки.Добавить(Новый ФорматированнаяСтрока(АдресРезюме, , , , АдресРезюме));
		
		Элементы.АдресРезюме.Заголовок = Новый ФорматированнаяСтрока(ЧастиСтроки);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементовФормы()
	
	Элементы.АдресРезюме.Видимость = Не Элементы.АдресРезюме.Заголовок = "";
	
	ПодборПерсоналаФормы.УстановитьВидимостьЭлементаФормы(Элементы.ЗарегистрироватьКандидата);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьФайлаРезюме(ТекущийОбъект)
	
	ОписаниеФайла = ТекущийОбъект.ФайлРезюме.Получить();
	Если ОписаниеФайла = Неопределено Тогда
		Элементы.ОткрытьФайлРезюме.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	АдресФайлаРезюме = ПоместитьВоВременноеХранилище(ОписаниеФайла.Файл, УникальныйИдентификатор);
	ИмяФайлаРезюме = ОписаниеФайла.ИмяФайла;
	
	Элементы.ОткрытьФайлРезюме.Видимость = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлРезюмеНаКлиенте()
	
	Если Не ЗначениеЗаполнено(АдресФайлаРезюме) Тогда
		Возврат;
	КонецЕсли;
	
	#Если Не ВебКлиент Тогда	
		Файл = ПолучитьИзВременногоХранилища(АдресФайлаРезюме);
		РасширениеИмениФайла = ОбщегоНазначенияКлиентСервер.ПолучитьРасширениеИмениФайла(ИмяФайлаРезюме);
		ИмяВременногоФайла = ПолучитьИмяВременногоФайла(РасширениеИмениФайла);
		Файл.Записать(ИмяВременногоФайла);
		ОбщегоНазначенияКлиент.ОткрытьФайлВПрограммеПросмотра(ИмяВременногоФайла);
	#Иначе
		ПолучитьФайл(АдресФайлаРезюме, ИмяФайлаРезюме);	
	#КонецЕсли
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеКонтактнойИнформации()
	Возврат Новый Структура("Тип, Вид, Представление");
КонецФункции

&НаСервере
Процедура ЗаполнитьРезюмеКандидатаПоДаннымОтклика(ОписаниеКандидата)
	
	ОписаниеКандидата.Вакансия = Запись.Вакансия;
	ОписаниеКандидата.Фамилия = Запись.Фамилия;
	ОписаниеКандидата.Имя = Запись.Имя;
	ОписаниеКандидата.Отчество = Запись.Отчество;
	ОписаниеКандидата.Ответственный = Пользователи.ТекущийПользователь();
	ОписаниеКандидата.ДатаРегистрации = ТекущаяДатаСеанса();
	ОписаниеКандидата.ИсточникИнформации = Запись.Источник;
	ОписаниеКандидата.КонтактнаяИнформация = Новый Массив;
	
	Если ЗначениеЗаполнено(Запись.Адрес) Тогда
		Описание = ОписаниеКонтактнойИнформации();
		Описание.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес;
		Описание.Вид = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыКонтактнойИнформации.АдресМестаПроживанияФизическиеЛица");
		Описание.Представление = Запись.Адрес;
		ОписаниеКандидата.КонтактнаяИнформация.Добавить(Описание);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Запись.Телефон) Тогда
		Описание = ОписаниеКонтактнойИнформации();
		Описание.Тип = Перечисления.ТипыКонтактнойИнформации.Телефон;
		Описание.Вид = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыКонтактнойИнформации.ТелефонМобильныйФизическиеЛица");
		Описание.Представление = Запись.Телефон;
		ОписаниеКандидата.КонтактнаяИнформация.Добавить(Описание);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Запись.EMail) Тогда
		Описание = ОписаниеКонтактнойИнформации();
		Описание.Тип = Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты;
		Описание.Вид = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыКонтактнойИнформации.EMailФизическиеЛица");
		Описание.Представление = Запись.EMail;
		ОписаниеКандидата.КонтактнаяИнформация.Добавить(Описание);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
