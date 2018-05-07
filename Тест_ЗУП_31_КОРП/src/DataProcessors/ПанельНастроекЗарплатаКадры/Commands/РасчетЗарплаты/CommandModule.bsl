
#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ИмяФормы = "РасчетЗарплаты";
	ПараметрыФормы = Новый Структура("ТекущийРаздел", ИмяФормы);
	
	ОткрытьФорму(
		"Обработка.ПанельНастроекЗарплатаКадры.Форма" + "." + ИмяФормы,
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		"Обработка.ПанельНастроекЗарплатаКадры.Форма" + "." + ИмяФормы + ?(ПараметрыВыполненияКоманды.Окно = Неопределено, ".ОтдельноеОкно", ""),
		ПараметрыВыполненияКоманды.Окно);
		
КонецПроцедуры

#КонецОбласти