#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ТекстВопроса = НСтр("ru='При восстановлении начальных значений будет выполнена очистка записей
		|и произведено заполнение заново.
		|
		|Восстановить начальные значения?'");
	
	ИменаРегистров = Новый Массив;
	ИменаРегистров.Добавить("РегистрСведений.СтавкаРефинансированияЦБ");
	ИменаРегистров.Добавить("РегистрСведений.МинимальнаяОплатаТрудаРФ");
	ИменаРегистров.Добавить("РегистрСведений.МаксимальныйРазмерЕжемесячнойСтраховойВыплаты");
	ИменаРегистров.Добавить("РегистрСведений.РазмерыГосударственныхПособий");
	ИменаРегистров.Добавить("РегистрСведений.ПредельнаяВеличинаБазыСтраховыхВзносов");
	ИменаРегистров.Добавить("РегистрСведений.РазмерВычетовНДФЛ");
	ИменаРегистров.Добавить("РегистрСведений.ТарифыСтраховыхВзносов");
	
	Обработчик = Новый ОписаниеОповещения("ПослеВосстановленияЗаконодательныхЗначений", ЭтотОбъект);
	
	Если ТипЗнч(ПараметрыВыполненияКоманды.Источник) = Тип("УправляемаяФорма") Тогда
		Форма = ПараметрыВыполненияКоманды.Источник;
	Иначе
		Форма = Новый Структура("УникальныйИдентификатор", Новый УникальныйИдентификатор);
	КонецЕсли;
	
	ЗарплатаКадрыКлиент.ВосстановитьНачальныеЗначенияСлужебный(Форма, СтрСоединить(ИменаРегистров, ","), Обработчик, ТекстВопроса);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПослеВосстановленияЗаконодательныхЗначений(Задание, ДополнительныеПараметры) Экспорт
	Статус = ?(Задание = Неопределено, "Отменено", Задание.Статус);
	Если Статус = "Выполнено" Тогда
		ПоказатьОповещениеПользователя(, , НСтр("ru = 'Начальные значения восстановлены.'"), БиблиотекаКартинок.Успешно32);
		Оповестить("ВосстановленыНачальныеЗначения");
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

