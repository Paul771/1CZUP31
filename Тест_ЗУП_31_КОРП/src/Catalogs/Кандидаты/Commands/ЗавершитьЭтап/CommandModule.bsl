#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = ПодборПерсоналаКлиентСервер.ПараметрыРедактированияЭтапаРаботыСКандидатом();
	ПараметрыФормы.Кандидаты = ПараметрКоманды;
	ПараметрыФормы.СостояниеЭтапа = ПредопределенноеЗначение("Перечисление.СостоянияЭтаповРаботыСКандидатами.Пройден");
	
	ПараметрыОповещения = Новый Структура("Источник, Кандидаты");
	ПараметрыОповещения.Источник = ПараметрыВыполненияКоманды.Источник;
	ПараметрыОповещения.Кандидаты = ПараметрКоманды;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ЗавершитьЭтапПослеВыбора", ЭтотОбъект, ПараметрыОповещения);
	ОткрытьФорму(
		"РегистрСведений.РаботаСКандидатами.Форма.ЭтапРаботыСКандидатом", 
		ПараметрыФормы, 
		ПараметрыВыполненияКоманды.Источник, 
		ПараметрыВыполненияКоманды.Уникальность, 
		ПараметрыВыполненияКоманды.Окно, 
		, 
		ОбработчикОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗавершитьЭтапПослеВыбора(РезультатВыбора, ПараметрыОповещения) Экспорт
	
	Если РезультатВыбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗавершитьЭтапПослеВыбораНаСервере(РезультатВыбора);
	
	// Отражаем изменения в открытых формах.
	ФормаВладелец = ПараметрыОповещения.Источник;
	Если ФормаВладелец.Параметры.Свойство("Ключ") Тогда
		ФормаВладелец.Прочитать();
	КонецЕсли;
	ОповеститьОбИзменении(ТипЗнч("СправочникСсылка.Кандидаты"));
	
	ПараметрыОповещения.Вставить("Вакансии", РезультатВыбора.Вакансии);
	Оповестить("ЗавершенЭтапРаботыСКандидатом", ПараметрыОповещения, ПараметрыОповещения.Источник);
	
КонецПроцедуры

&НаСервере
Процедура ЗавершитьЭтапПослеВыбораНаСервере(РезультатВыбора)
	ПодборПерсонала.УстановитьСостояниеЭтапаРаботыКандидатов(РезультатВыбора);
КонецПроцедуры

#КонецОбласти