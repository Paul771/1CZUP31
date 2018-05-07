////////////////////////////////////////////////////////////////////////////////
// Обработчики получения поставляемых данных БРО.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Регистрирует обработчики поставляемых данных за день и за все время
//
Процедура ЗарегистрироватьОбработчикиПоставляемыхДанных(Знач Обработчики) Экспорт
	
	ВнешниеРегламентированныеОтчетыВМоделиСервиса.ЗарегистрироватьОбработчикиПоставляемыхДанных(Обработчики);
	ВнешниеМодулиДокументооборотаСКОВМоделиСервиса.ЗарегистрироватьОбработчикиПоставляемыхДанных(Обработчики);
	
КонецПроцедуры

#КонецОбласти
