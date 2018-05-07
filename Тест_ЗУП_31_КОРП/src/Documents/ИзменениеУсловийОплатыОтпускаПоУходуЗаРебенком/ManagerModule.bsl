#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// Сторнирует документ по учетам. Используется подсистемой исправления документов.
//
// Параметры:
//  Движения				 - КоллекцияДвижений, Структура	 - Коллекция движений исправляющего документа в которую будут добавлены сторно стоки.
//  Регистратор				 - ДокументСсылка				 - Документ регистратор исправления (документ исправление).
//  ИсправленныйДокумент	 - ДокументСсылка				 - Исправленный документ движения которого будут сторнированы.
//  СтруктураВидовУчета		 - Структура					 - Виды учета, по которым будет выполнено сторнирование исправленного документа.
//  					Состав полей см. в ПроведениеРасширенныйСервер.СтруктураВидовУчета().
//  ДополнительныеПараметры	 - Структура					 - Структура со свойствами:
//  					* ИсправлениеВТекущемПериоде - Булево - Истина когда исправление выполняется в периоде регистрации исправленного документа.
//						* ОтменаДокумента - Булево - Истина когда исправление вызвано документом СторнированиеНачислений.
//  					* ПериодРегистрации	- Дата - Период регистрации документа регистратора исправления.
// 
// Возвращаемое значение:
//  Булево - "Истина" если сторнирование выполнено этой функцией, "Ложь" если специальной процедуры не предусмотрено.
//
Функция СторнироватьПоУчетам(Движения, Регистратор, ИсправленныйДокумент, СтруктураВидовУчета, ДополнительныеПараметры) Экспорт
	
	УправлениеШтатнымРасписанием.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент);
	
	Если ДополнительныеПараметры.ОтменаДокумента Тогда
		ИсправлениеДокументовЗарплатаКадры.СторнироватьДвиженияПоВсемУчетам(Движения, ИсправленныйДокумент, Ложь, СтруктураВидовУчета);
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции
	
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаДокумента.
Функция ОписаниеСоставаДокумента() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаДокументаПоМетаданнымФизическоеЛицоВШапке(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДобавитьКомандыСозданияДокументов(КомандыСозданияДокументов, ДополнительныеПараметры) Экспорт
	
	ЗарплатаКадрыРасширенный.ДобавитьВКоллекциюКомандуСозданияДокументаПоМетаданнымДокумента(
		КомандыСозданияДокументов, Метаданные.Документы.ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком);
	
КонецФункции

Функция ПолныеПраваНаДокумент() Экспорт 
	
	Возврат Пользователи.РолиДоступны("ДобавлениеИзменениеДанныхДляНачисленияЗарплатыРасширенная, ЧтениеДанныхДляНачисленияЗарплатыРасширенная", , Ложь);
	
КонецФункции	

Функция ДанныеДляПроверкиОграниченийНаУровнеЗаписей(Объект) Экспорт 

	ДанныеДляПроверкиОграничений = ЗарплатаКадрыРасширенный.ОписаниеСтруктурыДанныхДляПроверкиОграниченийНаУровнеЗаписей();
	
	ДанныеДляПроверкиОграничений.Организация = Объект.Организация;
	ДанныеДляПроверкиОграничений.МассивФизическихЛиц = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Объект.Сотрудник);
	
	Возврат ДанныеДляПроверкиОграничений;
	
КонецФункции

Процедура РассчитатьФОТПоДокументу(ДокументОбъект) Экспорт
	
	Если НЕ ДокументОбъект.ИзменитьНачисления Тогда
		Возврат;
	КонецЕсли; 
			
	ТаблицаСотрудников = ДокументОбъект.Начисления.Выгрузить(, "РабочееМесто");
	ТаблицаСотрудников.Свернуть("РабочееМесто");
	
	ТаблицаНачислений = ПлановыеНачисленияСотрудников.ТаблицаНачисленийДляРасчетаВторичныхДанных();
	ТаблицаПоказателей = ПлановыеНачисленияСотрудников.ТаблицаИзвестныеПоказатели();
	ИзвестныеКадровыеДанные = ПлановыеНачисленияСотрудников.СоздатьТаблицаКадровыхДанных();
	
	Для каждого СтрокаТаблицыСотрудников Из ТаблицаСотрудников Цикл
		
		КадровыеДанныеСотрудника = ИзвестныеКадровыеДанные.Добавить();
		КадровыеДанныеСотрудника.Сотрудник = ДокументОбъект.ОсновнойСотрудник;
		КадровыеДанныеСотрудника.Период = ДокументОбъект.ДатаИзменения;
		КадровыеДанныеСотрудника.Организация = ДокументОбъект.Организация;
				
		НачисленияСотрудника = ДокументОбъект.Начисления.НайтиСтроки(Новый Структура("РабочееМесто", СтрокаТаблицыСотрудников.РабочееМесто));
		
		СписокНачислений = Новый Массив;
		Для Каждого СтрокаНачисления Из НачисленияСотрудника Цикл
			
			ДанныеНачисления = ТаблицаНачислений.Добавить();
			ДанныеНачисления.Сотрудник = ДокументОбъект.ОсновнойСотрудник;
			ДанныеНачисления.Период = ДокументОбъект.ДатаИзменения;
			ДанныеНачисления.Начисление = СтрокаНачисления.Начисление;
			ДанныеНачисления.ДокументОснование = СтрокаНачисления.ДокументОснование;
			ДанныеНачисления.Размер = СтрокаНачисления.Размер;
			
			ПоказателиНачисления = ДокументОбъект.Показатели.НайтиСтроки(Новый Структура("ИдентификаторСтрокиВидаРасчета", СтрокаНачисления.ИдентификаторСтрокиВидаРасчета));
			Для Каждого СтрокаПоказателя Из ПоказателиНачисления Цикл
				ДанныеПоказателя = ТаблицаПоказателей.Добавить();
				ДанныеПоказателя.Сотрудник = ДокументОбъект.ОсновнойСотрудник;
				ДанныеПоказателя.Период = ДокументОбъект.ДатаИзменения;
				ДанныеПоказателя.Показатель = СтрокаПоказателя.Показатель;
				ДанныеПоказателя.ДокументОснование = СтрокаНачисления.ДокументОснование;
				ДанныеПоказателя.Значение = СтрокаПоказателя.Значение;
			КонецЦикла;
			
		КонецЦикла;
					
	КонецЦикла;
	
	РассчитанныеДанные = ПлановыеНачисленияСотрудников.РассчитатьВторичныеДанныеПлановыхНачислений(ТаблицаНачислений, ТаблицаПоказателей, ИзвестныеКадровыеДанные);
	
	Для Каждого ОписаниеНачисления Из РассчитанныеДанные.ПлановыйФОТ Цикл
			
		Отбор = Новый Структура("РабочееМесто, Начисление, ДокументОснование", 
			СтрокаТаблицыСотрудников.РабочееМесто, ОписаниеНачисления.Начисление, ОписаниеНачисления.ДокументОснование);
		СтрокиДокумента = ДокументОбъект.Начисления.НайтиСтроки(Отбор);
		
		Если СтрокиДокумента.Количество() > 0 Тогда
			СтрокиДокумента[0].Размер = ОписаниеНачисления.ВкладВФОТ;
		КонецЕсли; 
		
	КонецЦикла;
		
	РасчетЗарплатыРасширенный.ЗаполнитьФОТВДвиженияхЗагружаемогоДокумента(ДокументОбъект.Движения.ПлановыеНачисления, ДокументОбъект.Начисления, "РабочееМесто");		
КонецПроцедуры

Функция ДанныеДляРегистрацииВУчетаСтажаПФР(МассивСсылок) Экспорт
	ДанныеДляРегистрацииВУчете = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.Ссылка,
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ОсновнойСотрудник,
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ДатаИзменения,
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ДатаНачалаПФР,
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ДатаОкончанияПособияДоПолутораЛет,
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ДатаОкончанияПособияДоТрехЛет,
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ВыплачиватьПособиеДоПолутораЛет,
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ВыплачиватьПособиеДоТрехЛет
	|ПОМЕСТИТЬ ВТДанныеДокументов
	|ИЗ
	|	Документ.ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком КАК ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком
	|ГДЕ
	|	ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.Ссылка В(&МассивСсылок)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеДокументов.Ссылка,
	|	ДанныеДокументов.ОсновнойСотрудник,
	|	ДанныеДокументов.ДатаИзменения,
	|	ДанныеДокументов.ДатаНачалаПФР,
	|	ДанныеДокументов.ДатаОкончанияПособияДоПолутораЛет,
	|	ДанныеДокументов.ДатаОкончанияПособияДоТрехЛет,
	|	ДанныеДокументов.ВыплачиватьПособиеДоПолутораЛет,
	|	ДанныеДокументов.ВыплачиватьПособиеДоТрехЛет,
	|	МАКСИМУМ(ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенкомПрименениеПлановыхНачислений.Применение) КАК ЭтоВозвратКРаботе
	|ИЗ
	|	ВТДанныеДокументов КАК ДанныеДокументов
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенком.ПрименениеПлановыхНачислений КАК ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенкомПрименениеПлановыхНачислений
	|		ПО ДанныеДокументов.Ссылка = ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенкомПрименениеПлановыхНачислений.Ссылка
	|			И ДанныеДокументов.ОсновнойСотрудник = ИзменениеУсловийОплатыОтпускаПоУходуЗаРебенкомПрименениеПлановыхНачислений.РабочееМесто
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДокументов.Ссылка,
	|	ДанныеДокументов.ДатаОкончанияПособияДоПолутораЛет,
	|	ДанныеДокументов.ДатаОкончанияПособияДоТрехЛет,
	|	ДанныеДокументов.ОсновнойСотрудник,
	|	ДанныеДокументов.ВыплачиватьПособиеДоПолутораЛет,
	|	ДанныеДокументов.ВыплачиватьПособиеДоТрехЛет,
	|	ДанныеДокументов.ДатаИзменения,
	|	ДанныеДокументов.ДатаНачалаПФР";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ДанныеДляРегистрацииВУчетеПоДокументу = УчетСтажаПФР.ДанныеДляРегистрацииВУчетеСтажаПФР();	
		ДанныеДляРегистрацииВУчете.Вставить(Выборка.Ссылка, ДанныеДляРегистрацииВУчетеПоДокументу);
		
		Если Выборка.ЭтоВозвратКРаботе Тогда
			ОписаниеПериода = УчетСтажаПФР.ОписаниеРегистрируемогоПериода();
			ОписаниеПериода.Сотрудник = Выборка.ОсновнойСотрудник;	
			ОписаниеПериода.ДатаНачалаПериода = Макс(Выборка.ДатаИзменения, Выборка.ДатаНачалаПФР);
			ОписаниеПериода.Состояние = Перечисления.СостоянияСотрудника.Работа;
			
			РегистрируемыйПериод = УчетСтажаПФР.ДобавитьЗаписьВДанныеДляРегистрацииВУчета(ДанныеДляРегистрацииВУчетеПоДокументу, ОписаниеПериода);
											
			УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "ВидСтажаПФР", Перечисления.ВидыСтажаПФР2014.ВключаетсяВСтажДляДосрочногоНазначенияПенсии);
		Иначе
			ДатаНачалаПериодаБезОплаты = Выборка.ДатаИзменения; 
			Если Выборка.ВыплачиватьПособиеДоПолутораЛет Тогда
				Если Выборка.ДатаОкончанияПособияДоПолутораЛет >= Макс(Выборка.ДатаИзменения, Выборка.ДатаНачалаПФР) Тогда
					ОписаниеПериода = УчетСтажаПФР.ОписаниеРегистрируемогоПериода();
					ОписаниеПериода.Сотрудник = Выборка.ОсновнойСотрудник;	
					ОписаниеПериода.ДатаНачалаПериода =  Макс(Выборка.ДатаИзменения, Выборка.ДатаНачалаПФР);
					ОписаниеПериода.Состояние = Перечисления.СостоянияСотрудника.ОтпускПоУходуЗаРебенком;
					
					РегистрируемыйПериод = УчетСтажаПФР.ДобавитьЗаписьВДанныеДляРегистрацииВУчета(ДанныеДляРегистрацииВУчетеПоДокументу, ОписаниеПериода);
												
					УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "ВидСтажаПФР", Перечисления.ВидыСтажаПФР2014.Дети);	
				КонецЕсли;	
				
				ДатаНачалаПериодаБезОплаты = Выборка.ДатаОкончанияПособияДоПолутораЛет + 86400;
			КонецЕсли; 
			
			ОписаниеПериода = УчетСтажаПФР.ОписаниеРегистрируемогоПериода();
			ОписаниеПериода.Сотрудник = Выборка.ОсновнойСотрудник;	
			ОписаниеПериода.ДатаНачалаСобытия = Макс(Выборка.ДатаИзменения, Выборка.ДатаНачалаПФР);
			ОписаниеПериода.ДатаНачалаПериода = Макс(ДатаНачалаПериодаБезОплаты, Выборка.ДатаНачалаПФР);
			ОписаниеПериода.Состояние = Перечисления.СостоянияСотрудника.ОтпускПоУходуЗаРебенком;
		
			РегистрируемыйПериод = УчетСтажаПФР.ДобавитьЗаписьВДанныеДляРегистрацииВУчета(ДанныеДляРегистрацииВУчетеПоДокументу, ОписаниеПериода);
								
			УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "ВидСтажаПФР", Перечисления.ВидыСтажаПФР2014.ДЛДЕТИ);
				
		КонецЕсли;	
	КонецЦикла;	
			
	Возврат ДанныеДляРегистрацииВУчете;
														
КонецФункции	

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Обработчик = "ЗарплатаКадрыКлиент.ВыполнитьКомандуПечати";
	КомандаПечати.МенеджерПечати = "Обработка.ПечатьКадровыхПриказовРасширенная";
	КомандаПечати.Идентификатор = "ПФ_MXL_ПриказОВыходеНаНеполноеРабочееВремя";
	КомандаПечати.Представление = НСтр("ru = 'Приказ о работе на условиях неполного рабочего времени'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	КомандаПечати.ДополнитьКомплектВнешнимиПечатнымиФормами = Истина;

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли