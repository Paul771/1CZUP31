
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Ведомость = ПараметрКоманды;
	Форма = ПараметрыВыполненияКоманды.Источник;
	
	ПараметрыФормы = Новый Структура("Отбор", Отбор(Ведомость));
	
	ОткрытьФорму("Документ.ПеречислениеНДФЛВБюджет.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно); 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция Отбор(Ведомость)
	
	Реквизиты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ведомость, "Организация, ПериодРегистрации");
	
	Отбор = Новый Структура;
	Отбор.Вставить("Организация", Реквизиты.Организация);
	Отбор.Вставить("МесяцНалоговогоПериода", Реквизиты.ПериодРегистрации);
	
	Возврат Отбор
	
КонецФункции

#КонецОбласти
