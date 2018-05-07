#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	АдресПубликацииИБ = АдресПубликацииИнформационнойБазыВИнтернете();
	
	Если Не ЗначениеЗаполнено(АдресПубликацииИБ) Тогда
		ТекстСообщения = НСтр("ru = 'Не заполнен адрес информационной базы в Интернете. Заполнить можно в общих настройках раздела Администрирование.'");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	// Уточнить адрес веб-сервера.
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(АдресПубликацииИБ + "#" + ПолучитьНавигационнуюСсылку(ПараметрКоманды));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция АдресПубликацииИнформационнойБазыВИнтернете()
	Возврат ОбщегоНазначения.АдресПубликацииИнформационнойБазыВИнтернете();
КонецФункции

#КонецОбласти