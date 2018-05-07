
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьПоясняющийТекстКатегорииСтажа();
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КатегорияСтажаПриИзменении(Элемент)
	УстановитьПоясняющийТекстКатегорииСтажа();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства 
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура УстановитьПоясняющийТекстКатегорииСтажа()
	
	Если Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.Непрерывный") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Непрерывный трудовой стаж - продолжительность работы на одном предприятии (в учреждении, организации) без перерыва или на разных предприятиях, если при переходе с одного предприятия на другое непрерывность стажа сохранялась в установленном порядке. Указывается в личной карточке работника (форма № Т-2).'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.ОбщийНаучноПедагогический") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Суммарная продолжительность трудовой деятельности в научных и образовательных учреждениях. Указывается в учетной карточке научного работника (форма № Т-4).'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.Общий") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Суммарная продолжительность работы по трудовому договору, иной общественно полезной деятельности.  Указывается в личной карточке работника (форма № Т-2).'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.Педагогический") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Суммарная продолжительность трудовой деятельности в образовательных учреждениях на должностях, связанных с учебным процессом. Указывается в учетной карточке научного работника (форма № Т-4).'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.Страховой") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Страховой стаж для определения размеров пособий по временной нетрудоспособности.'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.РасширенныйСтраховой") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Стаж для оплаты больничных листов с учетом нестраховых периодов (с 2010 года) - «расширенный» страховой стаж с учетом нестраховых периодов, учет этого вида стажа ведется только для работников, имеющих такие нестраховые периоды. Необходим для определения суммы дополнительных расходов на выплату пособий по временной нетрудоспособности, связанных с зачетом в страховой стаж застрахованного лица нестраховых периодов, финансовое обеспечение которых осуществляется за счет межбюджетных трансфертов из федерального бюджета, предоставляемых бюджету ФСС РФ.'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.Северный") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Суммарная продолжительность трудовой деятельности в районах Крайнего Севера и приравненных к ним местностям.'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.ВыслугаЛет") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Стаж работы, дающий право на надбавку за выслугу лет. Учет этой категории стажа ведется, если в организации выплачивается надбавка за выслугу лет. Указывается в личной карточке работника (форма № Т-2).'");
	ИначеЕсли Объект.КатегорияСтажа = ПредопределенноеЗначение("Перечисление.КатегорииСтажа.Прочее") Тогда
		КатегорияСтажаПоясняющийТекст = НСтр("ru='Прочие виды стажа сотрудников.'");
	Иначе
		КатегорияСтажаПоясняющийТекст = "";
	КонецЕсли;
	
	ЗарплатаКадрыКлиентСервер.УстановитьРасширеннуюПодсказкуЭлементуФормы(ЭтаФОрма, "КатегорияСтажа", КатегорияСтажаПоясняющийТекст);
	
КонецПроцедуры

#КонецОбласти
