
#Область СлужебныеПроцедурыИФункции

Процедура УстановитьИнформационнуюСсылкуПереносаДанных(ИмяИсточника, ИнформационнаяСсылка) Экспорт
	
	Если ИмяИсточника = "ЗарплатаИУправлениеПерсоналом" Тогда
		ИнформационнаяСсылка = "http://its.1c.ru/db/metod81#content:5501:1";
	ИначеЕсли ИмяИсточника = "Зарплата+Кадры. Редакция 2.3" Тогда
		ИнформационнаяСсылка = "http://its.1c.ru/db/metod81#content:6219:hdoc";
	ИначеЕсли ИмяИсточника = "БухгалтерияПредприятияКОРП" Тогда
		ИнформационнаяСсылка = "";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
