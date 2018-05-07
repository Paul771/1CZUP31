
#Область СлужебныеПроцедурыИФункции

#Область ПроцедурыФормВедомостей

#Область ОбработчикиСобытийФормы

// Обработчик события ПриСозданииНаСервере.
// 	Устанавливает первоначальные значения реквизитов объекта.
//	Инициализирует реквизиты формы.
//
// Параметры:
// 	Форма - УправляемаяФорма - форма, которая создается.
// 	Отказ - Булево - признак отказа от создания формы.
// 	СтандартнаяОбработка - Булево - признак выполнения стандартной обработки события.
// 	ЗначенияДляЗаполнения - структура с дополнительными заполняемыми реквизитами.
//		Имя элемента структуры идентифицирует значение, которое необходимо заполнить.
//		Значение элемента структуры - путь к реквизиту формы, значение которого необходимо заполнить.
//		Необязательный параметр.
//		По умолчанию заполняются:
//			ПериодРегистрации
//			Организация
//			Ответственный
//			ГлавныйБухгалтер
//			Руководитель
//			ДолжностьРуководителя
//
Процедура ВедомостьПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	// Первоначальное заполнение объекта.
	Если Форма.Параметры.Ключ.Пустая() Тогда
		ВедомостьЗаполнитьПервоначальныеЗначения(Форма);
		Форма.ПриПолученииДанныхНаСервере(Форма.РеквизитФормыВЗначение("Объект"));
	КонецЕсли;
	
	ПодборПоРолям = Новый Соответствие;
	ПодборПоРолям.Вставить(Перечисления.СпособыВыплатыПрочихДоходов.ВыплатыБывшимСотрудникам, Перечисления.РолиФизическихЛиц.БывшийСотрудник);
	ПодборПоРолям.Вставить(Перечисления.СпособыВыплатыПрочихДоходов.ВыплатаПрочихДоходов, Перечисления.РолиФизическихЛиц.ПрочийПолучательДоходов);
	ПодборПоРолям.Вставить(Перечисления.СпособыВыплатыПрочихДоходов.Дивиденды, Перечисления.РолиФизическихЛиц.Акционер);
	ПодборПоРолям.Вставить(Перечисления.СпособыВыплатыПрочихДоходов.ДивидендыСотрудникам, Перечисления.РолиФизическихЛиц.Акционер);
	Форма.ОписаниеПодбораПоРолям = Новый ФиксированноеСоответствие(ПодборПоРолям);
	
КонецПроцедуры

// Обработчик события ПриЧтенииНаСервере.
//
// Параметры:
// 	Форма - УправляемаяФорма - форма, которая создается.
// 	ТекущийОбъект - читаемый объект.
//
Процедура ВедомостьПриЧтенииНаСервере(Форма, ТекущийОбъект) Экспорт
	
	Форма.ПриПолученииДанныхНаСервере(ТекущийОбъект);
	
КонецПроцедуры

// Обработчик события ПослеЗаписиНаСервере.
//
// Параметры:
// 	Форма - УправляемаяФорма - форма, в которой произошло событие.
// 	ТекущийОбъект - ДокументОбъект - записываемый объект.
//	ПараметрыЗаписи - структура - параметры записи.
//
Процедура ВедомостьПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	ВедомостьПриПолученииДанныхНаСервере(Форма, ТекущийОбъект);
	
КонецПроцедуры

// Обработчик события ОбработкаПроверкиЗаполненияНаСервере.
// 	Инициирует проверку заполнения объекта.
//
// Параметры:
// 	Форма - УправляемаяФорма - форма, в которой произошло событие.
//	Отказ - булево - признак отказа от записи 
//	ПроверяемыеРеквизиты - массив - пути к реквизитам, для которых будет выполнена проверка заполнения.
//	
Процедура ОбработкаПроверкиЗаполненияНаСервере(Форма, Отказ, ПроверяемыеРеквизиты) Экспорт
	ТекущийОбъект = Форма.РеквизитФормыВЗначение("Объект");
	Если НЕ ТекущийОбъект.ПроверитьЗаполнение() Тогда
		Форма.ОбработатьСообщенияПользователю();
		Отказ = Истина
	КонецЕсли;	
	ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "Объект");
КонецПроцедуры

Процедура ВедомостьСоставОбработкаВыбораНаСервере(Форма, Знач ВыбранноеЗначение, СтандартнаяОбработка) Экспорт
	
	Если ТипЗнч(ВыбранноеЗначение) <> Тип("Массив") Тогда
		ВыбранныеПолучатели = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ВыбранноеЗначение);
	Иначе
		ВыбранныеПолучатели = ОбщегоНазначенияКлиентСервер.СвернутьМассив(ВыбранноеЗначение)
	КонецЕсли;
	
	ПолучателиДоходов = Новый Массив;
	Для Каждого ПолучательДоходов Из ВыбранныеПолучатели Цикл
		
		СтрокиПолучателяДоходов = Форма.Объект.Состав.НайтиСтроки(Новый Структура("ФизическоеЛицо", ПолучательДоходов));
		
		Если СтрокиПолучателяДоходов.Количество() = 0 Тогда
			ПолучателиДоходов.Добавить(ПолучательДоходов)
		КонецЕсли;
		
	КонецЦикла;
	
	Если ПолучателиДоходов.Количество() > 0 Тогда
		ВедомостьДополнитьНаСервере(Форма, ПолучателиДоходов);
	КонецЕсли;
	
КонецПроцедуры	

#КонецОбласти

Процедура ВедомостьЗаполнитьНаСервере(Форма) Экспорт
	
	ТекущийОбъект = Форма.РеквизитФормыВЗначение("Объект");
	
	Если ТекущийОбъект.МожноЗаполнитьВыплаты() Тогда
		ТекущийОбъект.ЗаполнитьВыплаты();
	КонецЕсли;	
	
	Форма.ОбработатьСообщенияПользователю();
	
	Форма.ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
	
	ВедомостьПриПолученииДанныхНаСервере(Форма, ТекущийОбъект);	
	
КонецПроцедуры

Процедура ВедомостьДополнитьНаСервере(Форма, ПолучателиДоходов) Экспорт
	
	ТекущийОбъект = Форма.РеквизитФормыВЗначение("Объект");
	
	Если ТекущийОбъект.МожноЗаполнитьВыплаты() Тогда
		ТекущийОбъект.ДополнитьВыплату(ПолучателиДоходов);
	КонецЕсли;	
	
	Форма.ОбработатьСообщенияПользователю();
	
	Форма.ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
	
	ВедомостьПриПолученииДанныхНаСервере(Форма, ТекущийОбъект);	
	
КонецПроцедуры

Процедура ВедомостьОчиститьНаСервере(Форма) Экспорт
	
	ТекущийОбъект = Форма.РеквизитФормыВЗначение("Объект");
	
	ТекущийОбъект.ОчиститьСостав();
	
	Форма.ОбработатьСообщенияПользователю();
	
	Форма.ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
	
	ВедомостьПриПолученииДанныхНаСервере(Форма, ТекущийОбъект);	
	
КонецПроцедуры

// Вызывается при создании формы новой ведомости.
// Выполняет заполнение первоначальных значений реквизитов ведомости в форме.
//
// Параметры:
// 	Форма - УправляемаяФорма.
//
Процедура ВедомостьЗаполнитьПервоначальныеЗначения(Форма)
	
	ЗначенияДляЗаполнения = Новый Структура;
	Для Каждого ЗначениеДляЗаполнения Из ВедомостьЗначенияДляЗаполненияОтветственныхЛиц(Форма) Цикл
		ЗначенияДляЗаполнения.Вставить(ЗначениеДляЗаполнения.Ключ, ЗначениеДляЗаполнения.Значение);
	КонецЦикла;	
	ЗначенияДляЗаполнения.Вставить("ПредыдущийМесяц",	"Объект.ПериодРегистрации");
	ЗначенияДляЗаполнения.Вставить("Организация",		"Объект.Организация");
	ЗначенияДляЗаполнения.Вставить("Ответственный",		"Объект.Ответственный");
	
	ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(Форма, ЗначенияДляЗаполнения);
	
КонецПроцедуры

Функция ВедомостьЗначенияДляЗаполненияОтветственныхЛиц(Форма)
	
	МенеджерВедомости = ОбщегоНазначения.МенеджерОбъектаПоСсылке(Форма.Объект.Ссылка);
	РеквизитыОтветственныхЛиц = МенеджерВедомости.РеквизитыОтветственныхЛиц();
	
	ЗначенияДляЗаполнения = Новый Структура;
	Для Каждого Реквизит Из РеквизитыОтветственныхЛиц Цикл
		ПутьРеквизита = "Объект."+Реквизит;
		ЗначенияДляЗаполнения.Вставить(Реквизит, ПутьРеквизита);
	КонецЦикла;
	
	Возврат ЗначенияДляЗаполнения
	
КонецФункции

// Вызывается при получении формой данных объекта.
// 	Приспосабливаем форму к редактируемым данным.
//
// Параметры:
// 	Форма - УправляемаяФорма.
//	ТекущийОбъект - Объект, который будет прочитан, ДокументОбъект. 
//
Процедура ВедомостьПриПолученииДанныхНаСервере(Форма, ТекущийОбъект) Экспорт
	
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(Форма, "Объект.ПериодРегистрации", "ПериодРегистрацииСтрокой");
	
	ПоказыватьСтатьиРасходов		= ПолучитьФункциональнуюОпцию("ИспользоватьСтатьиРасходовЗарплата");
	ПоказыватьСтатьиФинансирования	= ПолучитьФункциональнуюОпцию("ИспользоватьСтатьиФинансированияЗарплата");
	Если Не ПоказыватьСтатьиФинансирования И Не ПоказыватьСтатьиРасходов Тогда
		ШаблонРасшифровкиФинансирование = "";
	ИначеЕсли ПоказыватьСтатьиФинансирования И ПоказыватьСтатьиРасходов Тогда
		ШаблонРасшифровкиФинансирование = "%1(%2)";
	Иначе
		ШаблонРасшифровкиФинансирование = "%1";
	КонецЕсли;
	
	Для Каждого СтрокаСостава Из Форма.Объект.Состав Цикл
		ВедомостьПриПолученииДанныхСтрокиСостава(Форма, СтрокаСостава, ШаблонРасшифровкиФинансирование);
	КонецЦикла;
	
	Форма.УстановитьДоступностьЭлементов();
	Форма.НастроитьОтображениеГруппыПодписей();
	Форма.УстановитьПредставлениеОплаты();
	
	ВзаиморасчетыПоПрочимДоходамКлиентСервер.ВедомостьУстановитьПредставлениеОснований(Форма); 
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьВнешниеХозяйственныеОперацииЗарплатаКадры") Тогда
		Форма.Элементы.ОплатыПредставление.Видимость	= Ложь;
		Форма.Элементы.ВнешниеОперацииГруппа.Видимость	= Истина;
		ВзаиморасчетыПоПрочимДоходамКлиентСервер.УстановитьОтображениеВХО(Форма);
	Иначе	
		Форма.Элементы.ОплатыПредставление.Видимость	= Истина;
		Форма.Элементы.ВнешниеОперацииГруппа.Видимость	= Ложь;
	КонецЕсли;
	
	Форма.СпособВыплатыПрежнееЗначение = Форма.Объект.СпособВыплаты;
	
	ПроверятьЗаполнениеФинансирования = ПолучитьФункциональнуюОпцию("ПроверятьЗаполнениеФинансированияВВедомостях");	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "СтатьяФинансирования", 	"АвтоОтметкаНезаполненного", ПроверятьЗаполнениеФинансирования);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "СтатьяФинансирования", 	"ОтметкаНезаполненного",     ПроверятьЗаполнениеФинансирования И Не ЗначениеЗаполнено(ТекущийОбъект.СтатьяФинансирования));
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "СтатьяРасходов", 	"АвтоОтметкаНезаполненного",         ПроверятьЗаполнениеФинансирования);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "СтатьяРасходов", 	"ОтметкаНезаполненного",             ПроверятьЗаполнениеФинансирования И Не ЗначениеЗаполнено(ТекущийОбъект.СтатьяРасходов));
	
	ОписаниеКлючевыхРеквизитов = Форма.КлючевыеРеквизитыЗаполненияФормыОписаниеКлючевыхРеквизитов();
	ТаблицыОчищаемыеПриИзменении = Форма.КлючевыеРеквизитыЗаполненияФормыТаблицыОчищаемыеПриИзменении();
	
	ЗарплатаКадрыКлиентСервер.КлючевыеРеквизитыЗаполненияФормыУстановитьОтображениеПредупреждения(Форма, , ОписаниеКлючевыхРеквизитов, ТаблицыОчищаемыеПриИзменении);
	ЗарплатаКадры.КлючевыеРеквизитыЗаполненияФормыЗаполнитьПредупреждения(Форма, ОписаниеКлючевыхРеквизитов);
		
КонецПроцедуры

Процедура ВедомостьПриПолученииДанныхСтрокиСостава(Форма, СтрокаСостава, ШаблонРасшифровкиФинансирование = Неопределено) Экспорт

	Если ШаблонРасшифровкиФинансирование = Неопределено Тогда
		ПоказыватьСтатьиРасходов		= ПолучитьФункциональнуюОпцию("ИспользоватьСтатьиРасходовЗарплата");
		ПоказыватьСтатьиФинансирования	= ПолучитьФункциональнуюОпцию("ИспользоватьСтатьиФинансированияЗарплата");
		Если Не ПоказыватьСтатьиФинансирования И Не ПоказыватьСтатьиРасходов Тогда
			ШаблонРасшифровкиФинансирование = "";
		ИначеЕсли ПоказыватьСтатьиФинансирования И ПоказыватьСтатьиРасходов Тогда
			ШаблонРасшифровкиФинансирование = "%1(%2)";
		Иначе
			ШаблонРасшифровкиФинансирование = "%1";
		КонецЕсли;	
	КонецЕсли;	
	
	СтрокиВыплатПоФизическомуЛицу = Форма.Объект.Выплаты.НайтиСтроки(Новый Структура("ИдентификаторСтроки", СтрокаСостава.ИдентификаторСтроки));
	СтрокаСостава.КВыплате = Форма.Объект.Выплаты.Выгрузить(СтрокиВыплатПоФизическомуЛицу, "КВыплате").Итог("КВыплате");
	
	Если Не ПустаяСтрока(ШаблонРасшифровкиФинансирование) Тогда
		
		ПоляСтатей = "СтатьяФинансирования, СтатьяРасходов";
		СочетанияСтатей = Форма.Объект.Выплаты.Выгрузить(Новый Структура("ИдентификаторСтроки", СтрокаСостава.ИдентификаторСтроки), ПоляСтатей);
		СочетанияСтатей.Свернуть(ПоляСтатей);
		
		РасшифровкаФинансирования = "";
		Для Индекс = 0 По СочетанияСтатей.Количество()-1 Цикл
			
			Если Индекс = 3 Тогда
				РасшифровкаФинансирования = РасшифровкаФинансирования + "...";
				Прервать
			ИначеЕсли Индекс > 0 Тогда
				РасшифровкаФинансирования = РасшифровкаФинансирования + Символы.ПС;
			КонецЕсли;
			
			КодСтатьиФинансирования	= ВзаиморасчетыССотрудникамиПовтИспРасширенный.КодыСтатейФинансирования()[СочетанияСтатей[Индекс].СтатьяФинансирования];
			КодСтатьиРасходов		= СтроковыеФункцииКлиентСервер.ДополнитьСтроку(СочетанияСтатей[Индекс].СтатьяРасходов, 3, " ");
			
			РасшифровкаФинансирования = 
			РасшифровкаФинансирования + 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонРасшифровкиФинансирование, КодСтатьиФинансирования, КодСтатьиРасходов); 
			
		КонецЦикла;	
		
		СтрокаСостава.Финансирование = РасшифровкаФинансирования;
		
	КонецЕсли;
	
	ПериодРегистрацииВедомости = Форма.Объект.ПериодРегистрации;
	
	СтрокиНДФЛРаботника = Форма.Объект.НДФЛ.НайтиСтроки(Новый Структура("ИдентификаторСтроки", СтрокаСостава.ИдентификаторСтроки));
	
	СтрокаСостава.НДФЛ = 0;
	СтрокаСостава.НДФЛРасшифровка = "";
	
	РасшифровкаПериодов = "";
	РасшифровкаОснований = "";
	
	ЕстьПрошлыеПериоды = Ложь;
	ТипыОснований = Новый Соответствие;
	Для Каждого СтрокаНДФЛРаботника Из СтрокиНДФЛРаботника Цикл
		
		СтрокаСостава.НДФЛ = СтрокаСостава.НДФЛ + СтрокаНДФЛРаботника.Сумма;
		
		ЕстьПрошлыеПериоды = 
			ЕстьПрошлыеПериоды ИЛИ 
			НачалоМесяца(СтрокаНДФЛРаботника.МесяцНалоговогоПериода) <> НачалоМесяца(ПериодРегистрацииВедомости); 		
			
		Если ЗначениеЗаполнено(СтрокаНДФЛРаботника.ДокументОснование) Тогда
			ТипыОснований.Вставить(ТипЗнч(СтрокаНДФЛРаботника.ДокументОснование));
		КонецЕсли	
		
	КонецЦикла;
	
	Если ЕстьПрошлыеПериоды Тогда
		РасшифровкаПериодов = НСтр("ru = 'в т.ч. в счет ранее исчисленного'");
	Иначе
	КонецЕсли;	

	Если ЗначениеЗаполнено(РасшифровкаПериодов) Тогда
		СтрокаСостава.НДФЛРасшифровка = РасшифровкаПериодов
	КонецЕсли;

КонецПроцедуры

// Устанавливает доступность элементов формы ведомости.
// 	Документ ввода начальных остатков, или по ведомость, по которой есть выплаты
//	доступны только для просмотра.
//
// Параметры:
// 	Форма - УправляемаяФорма.
//
Процедура ВедомостьУстановитьДоступностьЭлементов(Форма) Экспорт
	
	Форма.ТолькоПросмотр = 
		ЗначениеЗаполнено(Форма.Объект.Ссылка) 
		И (ДатыЗапретаИзменения.ИзменениеЗапрещено(Форма.Объект.Ссылка.Метаданные().ПолноеИмя(), Форма.Объект.Ссылка) 
			ИЛИ ВзаиморасчетыССотрудниками.ЕстьОплатаПоВедомости(Форма.Объект.Ссылка)
			ИЛИ Не ОбменСБанкамиПоЗарплатнымПроектам.ДоступностьПлатежногоДокумента(Форма.Объект.Ссылка)
			Или ВзаиморасчетыССотрудникамиВызовСервераРасширенный.ЕстьПодтверждениеВыплатыДоходовПоВедомости(Форма.Объект.Ссылка));
	
КонецПроцедуры

Процедура ВедомостьРедактироватьВыплатуСтрокиЗавершениеНаСервере(Форма, РезультатыРедактирования) Экспорт
	
	ИдентификаторСтроки	= РезультатыРедактирования.ИдентификаторСтроки;
	
	СтрокиСостава = Форма.Объект.Состав.НайтиСтроки(Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки));
	Если СтрокиСостава.Количество() <> 0 Тогда
		СтрокаСостава  = СтрокиСостава[0]
	Иначе
		Возврат
	КонецЕсли;	

	ВыплатаСтроки	= ПолучитьИзВременногоХранилища(РезультатыРедактирования.АдресВХранилищеВыплатыПоСтроке);
	
	УдаляемыеСтроки = Форма.Объект.Выплаты.НайтиСтроки(Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки));
	Для Каждого УдаляемаяСтрока Из УдаляемыеСтроки Цикл
		Форма.Объект.Выплаты.Удалить(УдаляемаяСтрока);
	КонецЦикла;	
	
	ПоляСостава	= Новый Массив;
	Для Каждого РеквизитСостава Из Форма.Объект.Ссылка.Метаданные().ТабличныеЧасти.Состав.Реквизиты  Цикл
		Если ВыплатаСтроки.Колонки.Найти(РеквизитСостава.Имя) = Неопределено Тогда
			ВыплатаСтроки.Колонки.Добавить(РеквизитСостава.Имя, РеквизитСостава.Тип);
		КонецЕсли;	
		ПоляСостава.Добавить(РеквизитСостава.Имя);
	КонецЦикла;	
	СписокСвойств = СтрСоединить(ПоляСостава, ", ");
	
	Для Каждого СтрокаВыплаты Из ВыплатаСтроки Цикл
		ЗаполнитьЗначенияСвойств(СтрокаВыплаты, СтрокаСостава, СписокСвойств)
	КонецЦикла;	
	
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(ВыплатаСтроки, Форма.Объект.Выплаты);

	ВедомостьПриПолученииДанныхСтрокиСостава(Форма, СтрокаСостава);
		
	Форма.Модифицированность = Истина;
	
КонецПроцедуры

Функция ВедомостьАдресВХранилищеВыплатыПоСтроке(Форма, ИдентификаторСтроки) Экспорт
	Возврат ПоместитьВоВременноеХранилище(Форма.Объект.Выплаты.Выгрузить(Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки)), Форма.УникальныйИдентификатор);
КонецФункции

Процедура ВедомостьОбновитьНДФЛНаСервере(Форма, ИдентификаторыСтрок) Экспорт
	
	СтрокиСостава = Новый Массив;
	Для Каждого ИдентификаторСтроки Из ИдентификаторыСтрок Цикл
		
		СтрокаСостава = Форма.Объект.Состав.НайтиПоИдентификатору(ИдентификаторСтроки);
		
		Если СтрокаСостава <> Неопределено Тогда
			СтрокиСостава.Добавить(СтрокаСостава);
		КонецЕсли	
		
	КонецЦикла;	

	ВедомостьЗаполнитьНДФЛ(Форма, СтрокиСостава);
	
КонецПроцедуры

Процедура ВедомостьЗаполнитьНДФЛ(Форма, СтрокиСостава)
	
	ФизЛица = Новый Массив;
	
	Для Каждого СтрокаСостава Из СтрокиСостава Цикл
		ФизЛица.Добавить(СтрокаСостава.ФизическоеЛицо);
	КонецЦикла;
	
	ТекущийОбъект = Форма.РеквизитФормыВЗначение("Объект");
	
	Если ТекущийОбъект.МожноЗаполнитьВыплаты() Тогда
		ВзаиморасчетыПоПрочимДоходам.ВедомостьОбновитьНДФЛ(ТекущийОбъект, ФизЛица);
	КонецЕсли;	
	
	Форма.ОбработатьСообщенияПользователю();
	
	Форма.ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
	
	ВедомостьПриПолученииДанныхНаСервере(Форма, ТекущийОбъект);	
	
КонецПроцедуры

Процедура ВедомостьСоставПослеУдаленияНаСервере(Форма) Экспорт
	
	Для Каждого ИдентификаторСтроки Из Форма.ИдентификаторыСтрок Цикл
		
		УдаляемыеСтроки = Форма.Объект.Выплаты.НайтиСтроки(Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки));
		Для Каждого УдаляемаяСтрока Из УдаляемыеСтроки Цикл
			Форма.Объект.Выплаты.Удалить(УдаляемаяСтрока);
		КонецЦикла;
		
		УдаляемыеСтроки = Форма.Объект.НДФЛ.НайтиСтроки(Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки));
		Для Каждого УдаляемаяСтрока Из УдаляемыеСтроки Цикл
			Форма.Объект.НДФЛ.Удалить(УдаляемаяСтрока);
		КонецЦикла;
		
	КонецЦикла
	
КонецПроцедуры

Процедура ВедомостьСоставКВыплатеПриИзмененииНаСервере(Форма) Экспорт
	
	СтрокаСостава = Форма.Объект.Состав.НайтиПоИдентификатору(Форма.Элементы.Состав.ТекущаяСтрока);
	ВыплатыСтрокиСостава = Форма.Объект.Выплаты.НайтиСтроки(Новый Структура("ИдентификаторСтроки", СтрокаСостава.ИдентификаторСтроки));
	
	ЗарплатаКадры.РазнестиСуммуПоБазе(СтрокаСостава.КВыплате, ВыплатыСтрокиСостава, "КВыплате");
	
КонецПроцедуры	

// Устанавливает условное оформление формы списка ведомостей.
//
// Параметры:
// 	Форма - УправляемаяФорма - форма, которая создается.
//
Процедура УстановитьУсловноеОформлениеФормыСписка(Форма) Экспорт
	
	Если Форма.Элементы.Список.РежимВыбора Тогда
		Возврат
	КонецЕсли;	

	ЭлементОформления = Форма.Список.УсловноеОформление.Элементы.Добавить();
	ЭлементОформления.Использование	= Истина;
	
	ЭлементОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.Использование		= Истина;
	ЭлементОтбора.ВидСравнения		= ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ЛевоеЗначение		= Новый ПолеКомпоновкиДанных("ЕстьОплаты");
	ЭлементОтбора.ПравоеЗначение	= Истина;
	
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
		
КонецПроцедуры

#КонецОбласти

#КонецОбласти



