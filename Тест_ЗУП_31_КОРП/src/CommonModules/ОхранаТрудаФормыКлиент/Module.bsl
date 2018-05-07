////////////////////////////////////////////////////////////////////////////////
// Подсистема "Охрана труда"
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Процедура ЭлементРедактированияНачалоВыбора(Форма, Элемент, ДанныеВыбора, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыОповещения = Новый Структура;
	ИмяЭлемента = Элемент.Имя;
	Если ТипЗнч(Форма.ТекущийЭлемент) = Тип("ТаблицаФормы") Тогда
		ИмяЭлемента = СтрЗаменить(ИмяЭлемента, Форма.ТекущийЭлемент.Имя, "");
		ПараметрыОповещения.Вставить("ТаблицаФормы", Форма.ТекущийЭлемент.Имя);
	КонецЕсли;
	ПараметрыОповещения.Вставить("ИмяЭлемента", ИмяЭлемента);
	ПараметрыОповещения.Вставить("Форма", Форма);
	Оповещение = Новый ОписаниеОповещения("ЭлементРедактированияЗавершениеВвода", ЭтотОбъект, ПараметрыОповещения);
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияМногострочногоТекста(
		Оповещение,
		Элемент.ТекстРедактирования,
		Элемент.Заголовок);
	
КонецПроцедуры

Процедура ЭлементРедактированияЗавершениеВвода(Знач ВведенныйТекст, Знач ДополнительныеПараметры) Экспорт
	
	Если ВведенныйТекст = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Форма = ДополнительныеПараметры.Форма;
	Если ДополнительныеПараметры.Свойство("ТаблицаФормы") Тогда
		Форма.Элементы[ДополнительныеПараметры.ТаблицаФормы].ТекущиеДанные[ДополнительныеПараметры.ИмяЭлемента] = ВведенныйТекст;
	Иначе
		Форма.Объект[ДополнительныеПараметры.ИмяЭлемента] = ВведенныйТекст;
	КонецЕсли;
	Форма.Модифицированность = Истина;
	
КонецПроцедуры

#Область ОткрытиеФорм

Процедура ОткрытьФормуПоОхранеТруда(ФормаВладелец, СотрудникСсылка) Экспорт
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("ОбщаяФорма.СотрудникиОхранаТруда"), ФормаВладелец, Истина);
		
КонецПроцедуры

#КонецОбласти

#КонецОбласти

