
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Элементы.Список.Обновить();
	Элементы.Список.ТекущаяСтрока = ВыбранноеЗначение;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьИзБиблиотеки(Команда)
	
	ОткрытьФорму("Справочник.ДействияСотрудников.Форма.БиблиотекаДействийСотрудников", , ЭтотОбъект);	
	
КонецПроцедуры

#КонецОбласти
