#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	ЗарплатаКадрыВызовСервера.ПодготовитьДанныеВыбораКлассификаторовСПорядкомКодов(ДанныеВыбора, Параметры, СтандартнаяОбработка, "Справочник.ВидыДоходовНДФЛ");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура НачальноеЗаполнение() Экспорт
	
	ЗаполнитьКодыДоходовНДФЛ();
	СоздатьКодыДоходовНДФЛ();
	ЗаполнитьКодыДоходовНДФЛДекабрь2011();
	СоздатьКодыДоходовНДФЛДекабрь2011();
	ОбновлениеДоходовВычетовНДФЛПредопределенныхЯнварь2012();
	ОбновлениеДоходовВычетовНДФЛНеПредопределенныхЯнварь2012();
	ПроставитьКодамНатуральныхДоходовПризнакПредопределенного();
	УстановитьСтавкуДоходу3022();
	
КонецПроцедуры

// Выполняет заполнение справочника "ВидыДоходовНДФЛ".
//
Процедура ЗаполнитьКодыДоходовНДФЛ()
	
	Ставка09 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка09;
	Ставка13 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13;
	Ставка35 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка35;
	ВидыДоходовНДФЛ = Справочники.ВидыДоходовНДФЛ;
	ВычетыНДФЛ = Справочники.ВидыВычетовНДФЛ;
	
	// ОБНОВЛЕНИЕ СПРАВОЧНИКА ВидыДоходовНДФЛ
	
	// Заполнение реквизитов предопределенных элементов.
	ОписатьКодДоходаНДФЛ("Код1010", 			Ставка09, "1010", "Дивиденды", Ложь, Истина, ВычетыНДФЛ.Код601);
	ОписатьКодДоходаНДФЛ("Код1211", 			Ставка13, "1211", "Доходы, полученные в виде сумм страховых взносов по договорам страхования, если указанные суммы вносятся за физических лиц из средств работодателей", Ложь, Истина, ВычетыНДФЛ.Код607);
	ОписатьКодДоходаНДФЛ("Код1300", 			Ставка13, "1300", "Доходы, полученные налогоплательщиком от использования в РФ авторских или иных смежных прав (кроме авторских вознаграждений)");
	ОписатьКодДоходаНДФЛ("Код1530", 			Ставка13, "1530", "Доходы, полученные по операциям купли-продажи ценных бумаг, обращающихся на организованном рынке ценных бумаг", Ложь, Истина, ВычетыНДФЛ.Код201);
	ОписатьКодДоходаНДФЛ("Код1531", 			Ставка13, "1531", "Доходы, полученные по операциям купли-продажи ценных бумаг, не обращающихся на организованном рынке ценных бумаг", Ложь, Истина, ВычетыНДФЛ.Код202);
	ОписатьКодДоходаНДФЛ("Код1532", 			Ставка13, "1532", "Доходы, полученные по операциям с финансовыми инструментами срочных сделок, базисным активом по которым являются ценные бумаги или фондовые индексы", Ложь, Истина, ВычетыНДФЛ.Код205);
	ОписатьКодДоходаНДФЛ("Код1533", 			Ставка13, "1533", "Доходы, полученные от продажи и погашения инвестиционных паев паевых инвестиционных фондов", Ложь, Истина, ВычетыНДФЛ.Код202);
	ОписатьКодДоходаНДФЛ("Код1535", 			Ставка13, "1535", "Доходы, полученные по операциям с финансовыми инструментами срочных сделок, базисным активом которых не являются ценные бумаги или фондовые индексы", Ложь, Истина, ВычетыНДФЛ.Код207);
	ОписатьКодДоходаНДФЛ("Код1536", 			Ставка13, "1536", "Доход полученные по операциям купли-продажи ценных бумаг, не обращающихся на организованном рынке ценных бумаг, но отвечавших его требованиям", Ложь, Истина, ВычетыНДФЛ.Код203);
	ОписатьКодДоходаНДФЛ("КодДоходаПоУмолчанию",Ставка13, "2000", "Вознаграждение за выполнение трудовых или иных обязанностей; денежное содержание и иные налогооблагаемые выплаты военнослужащим и приравненным к ним", , , , , Истина);
	ОписатьКодДоходаНДФЛ("Код2010", 			Ставка13, "2010", "Выплаты по договорам гражданско-правового характера (за исключением авторских вознаграждений)", Ложь, Истина, ВычетыНДФЛ.Код403);
	ОписатьКодДоходаНДФЛ("Код2201", 			Ставка13, "2201", "Авторские вознаграждения (вознаграждения) за создание литературных произведений, в том числе для театра, кино, эстрады и цирка", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2202", 			Ставка13, "2202", "Авторские вознаграждения (вознаграждения) за создание художественно-графических произведений, фоторабот для печати, произведений архитектуры и дизайна", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2203", 			Ставка13, "2203", "Авторские вознаграждения (вознаграждения) за создание произведений скульптуры, живописи, театрально- и кинодекорационного искусства и графики", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2204", 			Ставка13, "2204", "Авторские вознаграждения (вознаграждения) за создание аудиовизуальных произведений (видео-, теле- и кинофильмов)", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2205", 			Ставка13, "2205", "Авторские за создание музыкальных произведений: музыкально-сценических, симфонических, хоровых, камерных, для духового оркестра, для фильмов и театра", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2206", 			Ставка13, "2206", "Авторские вознаграждения (вознаграждения) за создание других музыкальных произведений, в том числе подготовленных к опубликованию", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2207", 			Ставка13, "2207", "Авторские вознаграждения (вознаграждения) за исполнение произведений литературы и искусства", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2208", 			Ставка13, "2208", "Авторские вознаграждения (вознаграждения) за создание научных трудов и разработок", Истина, Ложь, ВычетыНДФЛ.Код405);
	ОписатьКодДоходаНДФЛ("Код2209", 			Ставка13, "2209", "Авторские вознаграждения за открытия, изобретения, промышленные образцы", Истина, Ложь, ВычетыНДФЛ.Код405);
	// не облагается у НА
	ОписатьКодДоходаНДФЛ("Код2210", 			Ставка13, "2210", "Вознаграждение, выплачиваемое наследникам (правопреемникам) авторов произведений науки, литературы, искусства, открытий, изобретений и пром. образцов", , , , Истина);
	ОписатьКодДоходаНДФЛ("Код2610",				Ставка35, "2610", "Материальная выгода, полученная от экономии на процентах за пользование заемными (кредитными) средствами");
	ОписатьКодДоходаНДФЛ("Код2720", 			Ставка13, "2720", "Стоимость подарков", Истина, Истина, ВычетыНДФЛ.Код501);
	ОписатьКодДоходаНДФЛ("Код2730", 			Ставка13, "2730", "Стоимость призов в денежной и натуральной форме на конкурсах и соревнованиях, проводимых в соотв. с решениями Правительства РФ и др. органов власти", Истина, Истина, ВычетыНДФЛ.Код502);
	ОписатьКодДоходаНДФЛ("Код2740", 			Ставка35, "2740", "Стоимость выигрышей и призов, получаемых в проводимых конкурсах, играх и других мероприятиях в целях рекламы товаров, работ и услуг", Истина, Истина, ВычетыНДФЛ.Код505);
	ОписатьКодДоходаНДФЛ("Код2760", 			Ставка13, "2760", "Материальная помощь, оказываемая работодателями своим работникам, а также бывшим своим работникам, уволившимся в связи с выходом на пенсию", Истина, Истина, ВычетыНДФЛ.Код503);
	ОписатьКодДоходаНДФЛ("Код2761", 			Ставка13, "2761", "Материальная помощь, оказываемая инвалидам общественными организациями инвалидов", Истина, Истина, ВычетыНДФЛ.Код506);
	ОписатьКодДоходаНДФЛ("Код2762",				Ставка13, "2762", "Материальная помощь, оказываемая работодателями своим работникам при рождении (усыновлении) ребенка", Истина, Истина, ВычетыНДФЛ.Код508);
	ОписатьКодДоходаНДФЛ("Код2770", 			Ставка13, "2770", "Возмещение (оплата) работодателями своим работникам и членам их семьи, бывшим своим работникам-пенсионерам, а также инвалидам стоимости медикаментов", Истина, Истина, ВычетыНДФЛ.Код504);
	ОписатьКодДоходаНДФЛ("Код2790", 			Ставка13, "2790", "Сумма помощи (в денежной и натуральной форме), стоимость подарков, полученных ветеранами, инвалидами Великой Отечественной войны и приравненных к ним", Истина, Истина, ВычетыНДФЛ.Код507);
	ОписатьКодДоходаНДФЛ("Код2791", 			Ставка13, "2791", "Доходы, полученные работниками в натуральной форме в качестве оплаты труда от с/х товаропроизводителей, упл-х ЕСХН, и крестьянских х-в", Ложь, Истина, ВычетыНДФЛ.Код509);
	ОписатьКодДоходаНДФЛ("Код4800", 			Ставка13, "4800", "Иные доходы", Ложь, Истина, ВычетыНДФЛ.Код620);
	
КонецПроцедуры 

// Выполняет заполнение справочника "ВидыДоходовНДФЛ" не предопределенными элементами.
//
Процедура СоздатьКодыДоходовНДФЛ() Экспорт
	
	Ставка09 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка09;
	Ставка13 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13;
	Ставка35 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка35;
	
	// Добавление непредопределенных кодов доходов.
	// Строка не локализуется т.к. является частью регламентированной формы, применяемой в РФ.
	ОписатьКодДоходаНДФЛ(, Ставка13, "1011", "Проценты, включая дисконт, полученный по долговому обязательству любого вида (за исключением доходов с кодами 1110, 2800 и 3020).");
	ОписатьКодДоходаНДФЛ(, Ставка09, "1110", "Проценты по облигациям с ипотечным покрытием, эмитированным до 01.01.2007");
	ОписатьКодДоходаНДФЛ(, Ставка09, "1120", "Доходы учредителей доверительного управления ипотечным покрытием, полученные на основании приобретения ипотечных сертификатов, выданных до 01.01.2007");
	ОписатьКодДоходаНДФЛ(, Ставка13, "1200", "Доходы, полученные в виде иных страховых выплат по договорам страхования");
	ОписатьКодДоходаНДФЛ(, Ставка13, "1201", "Доходы, полученные в виде страховых выплат по договорам страхования в виде оплаты стоимости санаторно-курортных путевок"); 
	ОписатьКодДоходаНДФЛ(, Ставка13, "1202", "Доходы, полученные в виде страховых выплат по договорам добровольного страхования жизни (за исключением добровольного пенсионного страхования)"); 
	ОписатьКодДоходаНДФЛ(, Ставка13, "1203", "Доходы, полученные в виде страховых выплат по договорам добровольного имущественного страхования (включая страхование гражданской ответственности)"); 
	ОписатьКодДоходаНДФЛ(, Ставка13, "1212", "Доходы в виде денежных (выкупных) сумм, выплачиваемых по договорам страхования при досрочном расторжении договоров страхования");
	ОписатьКодДоходаНДФЛ(, Ставка13, "1213", "Доходы в виде денежных (выкупных) сумм при расторжении договора за вычетом сумм страховых взносов, уплаченных по договору добр. пенс. страхования"); 
	ОписатьКодДоходаНДФЛ(, Ставка13, "1220", "Доходы в виде денежных (выкупных) сумм, выплачиваемые по договорам негосударственного пенсионного обеспечения");
	ОписатьКодДоходаНДФЛ(, Ставка13, "1240", "Суммы пенсий, выплачиваемых по договорам негосударственного пенсионного обеспечения");
	ОписатьКодДоходаНДФЛ(, Ставка13, "1301", "Доходы, полученные от отчуждения авторских или иных смежных прав"); 
	ОписатьКодДоходаНДФЛ(, Ставка13, "1400", "Доходы от сдачи в аренду и иного использования имущества (кроме доходов от сдачи в аренду транспортных средств, средств связи, компьютерных сетей)");
	ОписатьКодДоходаНДФЛ(, Ставка13, "1540", "Доходы, полученные от реализации долей участия в уставном капитале организаций ");
	ОписатьКодДоходаНДФЛ(, Ставка13, "1550", "Доходы, полученные налогоплательщиком при уступке прав требования по договору участия в долевом строительстве (договору инвестирования и др.)");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2001", "Вознаграждение директоров и иные аналогичные выплаты, получаемые членами органа управления организации (совета директоров или иного подобного органа)");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2012", "Суммы отпускных выплат");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2300", "Пособия по временной нетрудоспособности");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2400", "Доходы от использования любых транспортных средств в связи с перевозками, включая штрафы; трубопроводов, ЛЭП, линий связи, компьютерных сетей");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2630", "Материальная выгода, полученная от приобретения товаров, работ, услуг у физ. лиц, организаций, явл. взаимозависимыми по отношению к налогоплательщику");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2640", "Материальная выгода, полученная от приобретения ценных бумаг");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2710", "Материальная помощь (за исключением материальной помощи, учитываемой с кодами 2760 и 2761)");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2750", "Стоимость призов в денежной и натуральной форме (за исключением стоимости призов, учитываемой с кодами 2730 и 2740)");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2780", "Возмещение (оплата) стоимости приобретенных налогоплательщиком медикаментов в случаях, не подпадающих под действие п. 28 ст. 217 НК РФ");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2800", "Проценты (дисконт), полученные при оплате предъявленного к платежу векселя");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2900", "Доходы, полученные от операций с иностранной валютой");
	ОписатьКодДоходаНДФЛ(, Ставка13, "3010", "Выигрыши, выплачиваемые организаторами лотерей, тотализаторов и других основанных на риске игр (в том числе с использованием игровых автоматов)");
	ОписатьКодДоходаНДФЛ(, Ставка35, "3020", "Доходы в виде процентов, получаемых по вкладам в банках");
	
КонецПроцедуры 

Процедура ЗаполнитьКодыДоходовНДФЛДекабрь2011() Экспорт 
	
	Ставка13 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13;
	Ставка35 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка35;
	ВидыДоходовНДФЛ = Справочники.ВидыДоходовНДФЛ;
	ВычетыНДФЛ = Справочники.ВидыВычетовНДФЛ;	
	
	ОписатьКодДоходаНДФЛ("Код1537", 			Ставка13, "1537", "Доходы в виде процентов по займу, полученные по совокупности операций РЕПО", Ложь, Ложь,   ВычетыНДФЛ.Код210);
	ОписатьКодДоходаНДФЛ("Код1538", 			Ставка13, "1538", "Доходы в виде процентов, полученные в налоговом периоде по совокупности договоров займа", Ложь, Истина, ВычетыНДФЛ.Код214);
	ОписатьКодДоходаНДФЛ("Код1539", 			Ставка13, "1539", "Доходы по операциям, связанным с открытием короткой позиции, являющимся объектом операций РЕПО", Ложь, Истина, ВычетыНДФЛ.Код212);
	
КонецПроцедуры	

Процедура СоздатьКодыДоходовНДФЛДекабрь2011() Экспорт 
	Ставка13 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13;
	Ставка35 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка35;
	
	// Строка не локализуется т.к. является частью регламентированной формы, применяемой в РФ.
	ОписатьКодДоходаНДФЛ(, Ставка35, "3022", "Доходы в виде платы за использование денежных средств членов кр.потреб.кооператива или %% за исп-е с-х кр.потреб.кооперативом займов (с 01.01.2011)");
	ОписатьКодДоходаНДФЛ(, Ставка13, "2641", "Материальная выгода, полученная от приобретения финансовых инструментов срочных сделок");

КонецПроцедуры	

Процедура ОбновлениеДоходовВычетовНДФЛПредопределенныхЯнварь2012() Экспорт
	
	ОписатьКодДоходаНДФЛ("Код1541", Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13, "1541", "Доходы, получаемые в результате обмена ценных бумаг, переданных по первой части РЕПО");
	
КонецПроцедуры

Процедура ОбновлениеДоходовВычетовНДФЛНеПредопределенныхЯнварь2012() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДоходыНДФЛ.Ссылка
	|ИЗ
	|	Справочник.ВидыДоходовНДФЛ КАК ДоходыНДФЛ
	|ГДЕ
	|	ДоходыНДФЛ.Код = ""1541""
	|	И НЕ ДоходыНДФЛ.Предопределенный
	|	И НЕ ДоходыНДФЛ.ПометкаУдаления";
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Объект = Выборка.Ссылка.ПолучитьОбъект();
		Объект.КодПрименяемыйВНалоговойОтчетностиС2010Года = "-";
		Объект.ПометкаУдаления = Истина;
		Объект.ДополнительныеСвойства.Вставить("ЗаписьОбщихДанных");
		Объект.Записать();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроставитьКодамНатуральныхДоходовПризнакПредопределенного() Экспорт

	НачатьТранзакцию();

	КодыДляИнициализации = Новый Структура("Код2510,Код2520,Код2530");
	
	СтрокаПодстановки = "Код%1";
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыДоходовНДФЛ.Код КАК Код,
	|	ВидыДоходовНДФЛ.Предопределенный КАК Предопределенный,
	|	МАКСИМУМ(ВидыДоходовНДФЛ.Ссылка) КАК Ссылка
	|ИЗ
	|	Справочник.ВидыДоходовНДФЛ КАК ВидыДоходовНДФЛ
	|ГДЕ
	|	(ВидыДоходовНДФЛ.Код = ""2510""
	|			ИЛИ ВидыДоходовНДФЛ.Код = ""2520""
	|			ИЛИ ВидыДоходовНДФЛ.Код = ""2530"")
	|
	|СГРУППИРОВАТЬ ПО
	|	ВидыДоходовНДФЛ.Код,
	|	ВидыДоходовНДФЛ.Предопределенный";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ИмяПредопределенныхДанных = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			СтрокаПодстановки, Выборка.Код);
		
		// Если "встретился" предопределенный элементы, значит ранее он уже был инициализирован.
		Если Выборка.Предопределенный Тогда
			КодыДляИнициализации.Удалить(ИмяПредопределенныхДанных);
			Продолжить;
		КонецЕсли;

		ЭлементДляУдаления = Справочники.ВидыДоходовНДФЛ[ИмяПредопределенныхДанных].ПолучитьОбъект();		
		ЭлементДляУдаления.ОбменДанными.Загрузка = Истина;
		ЭлементДляУдаления.Удалить();
		
		КодыДляИнициализации.Удалить(ИмяПредопределенныхДанных);
		
		Элемент = Выборка.Ссылка.ПолучитьОбъект();
		Элемент.ИмяПредопределенныхДанных = ИмяПредопределенныхДанных;
		Элемент.ОбменДанными.Загрузка = Истина;
		Элемент.Записать();
		
	КонецЦикла;
	
	// Инициализация предопределенных элементов, дубликаты которых в справочнике найдены не были.
	Ставка13 = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13;
	
	Для Каждого КодДляИнициализации Из КодыДляИнициализации Цикл
		
		Если КодДляИнициализации.Ключ = "Код2510" Тогда
			ОписатьКодДоходаНДФЛ("Код2510", Ставка13, "2510", "Оплата за налогоплательщика товаров, работ, услуг или имущественных прав, в том числе коммунальных услуг, питания, отдыха, обучения в его интересах");
		ИначеЕсли КодДляИнициализации.Ключ = "Код2520" Тогда
			ОписатьКодДоходаНДФЛ("Код2520", Ставка13, "2520", "Стоимость товаров, работ, услуг, полученных на безвозмездной основе");
		ИначеЕсли КодДляИнициализации.Ключ = "Код2530" Тогда
			ОписатьКодДоходаНДФЛ("Код2530", Ставка13, "2530", "Оплата труда в натуральной форме", , , , , Истина);
		КонецЕсли;

	КонецЦикла;
	
	ЗафиксироватьТранзакцию();

	
КонецПроцедуры

Процедура УстановитьСтавкуДоходу3022() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыДоходовНДФЛ.Ссылка
	|ИЗ
	|	Справочник.ВидыДоходовНДФЛ КАК ВидыДоходовНДФЛ
	|ГДЕ
	|	ВидыДоходовНДФЛ.Код = ""3022""
	|	И ВидыДоходовНДФЛ.СтавкаНалогообложенияРезидента <> ЗНАЧЕНИЕ(Перечисление.НДФЛСтавкиНалогообложенияРезидента.Ставка35)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ОписатьКодДоходаНДФЛ(Выборка.Ссылка, Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка35);
	КонецЕсли;	

КонецПроцедуры

Процедура ПроставитьКодамДоходаОтношениеКОплатеТруда() Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыДоходовНДФЛ.Ссылка
	|ИЗ
	|	Справочник.ВидыДоходовНДФЛ КАК ВидыДоходовНДФЛ
	|ГДЕ
	|	(ВидыДоходовНДФЛ.Ссылка = ЗНАЧЕНИЕ(Справочник.ВидыДоходовНДФЛ.КодДоходаПоУмолчанию)
	|			ИЛИ ВидыДоходовНДФЛ.Код = ""2530"")
	|	И НЕ ВидыДоходовНДФЛ.СоответствуетОплатеТруда";
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Элемент = Выборка.Ссылка.ПолучитьОбъект();
		Элемент.СоответствуетОплатеТруда = Истина;
		Элемент.ОбменДанными.Загрузка = Истина;
		Элемент.Записать();
	КонецЦикла;
	
КонецПроцедуры

Процедура ОписатьКодДоходаНДФЛ(СсылкаИлиИмяПредопределенныхДанных = Неопределено, СтавкаНалогообложения = Неопределено, Код = "", Наименование = "", ВычетРассчитываетсяАвтоматически = Ложь, ИмеетЕдинственныйВычет = Ложь, ВычетПоУмолчанию = Неопределено, НеОблагаетсяУНалоговогоАгента = Ложь, СоответствуетОплатеТруда = Ложь)

	Если ТипЗнч(СсылкаИлиИмяПредопределенныхДанных) = Тип("Строка") И Не ПустаяСтрока(СсылкаИлиИмяПредопределенныхДанных) Тогда
		
		СсылкаПредопределенного = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыДоходовНДФЛ." + СсылкаИлиИмяПредопределенныхДанных);
		Если ЗначениеЗаполнено(СсылкаПредопределенного) Тогда
			Элемент = СсылкаПредопределенного.ПолучитьОбъект();
		Иначе
			Элемент = Справочники.ВидыДоходовНДФЛ.СоздатьЭлемент();
			Элемент.ИмяПредопределенныхДанных = СсылкаИлиИмяПредопределенныхДанных;
		КонецЕсли;
		
	Иначе
		
		Если ЗначениеЗаполнено(СсылкаИлиИмяПредопределенныхДанных) Тогда
			СсылкаНаЭлемент = СсылкаИлиИмяПредопределенныхДанных;
		Иначе
			СсылкаНаЭлемент = Справочники.ВидыДоходовНДФЛ.НайтиПоКоду(Код);
		КонецЕсли; 
		
		Если ЗначениеЗаполнено(СсылкаНаЭлемент) Тогда
			Элемент = СсылкаНаЭлемент.ПолучитьОбъект();
		Иначе
			Элемент = Справочники.ВидыДоходовНДФЛ.СоздатьЭлемент();
		КонецЕсли;
		
	КонецЕсли;

	Если ЗначениеЗаполнено(Код) Тогда
		Элемент.Код = Код;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Наименование) Тогда
		Элемент.Наименование = Наименование;
	КонецЕсли;

	Элемент.КодПрименяемыйВНалоговойОтчетностиС2010Года	= Элемент.Код;
	Элемент.СтавкаНалогообложенияРезидента		= ?(Не ЗначениеЗаполнено(СтавкаНалогообложения), Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13, СтавкаНалогообложения);
    Элемент.ВычетПоУмолчанию					= ВычетПоУмолчанию;
    Элемент.ВычетРассчитываетсяАвтоматически	= ВычетРассчитываетсяАвтоматически;
    Элемент.ИмеетЕдинственныйВычет				= ИмеетЕдинственныйВычет;
	Элемент.НеОблагаетсяУНалоговогоАгента		= НеОблагаетсяУНалоговогоАгента;
	Элемент.СоответствуетОплатеТруда			= СоответствуетОплатеТруда;
	
	Элемент.ОбменДанными.Загрузка = Истина;
	Элемент.Записать();

КонецПроцедуры	

#КонецЕсли

// Возвращает реквизиты справочника, которые образуют естественный ключ
//  для элементов справочника.
// Используется для сопоставления элементов механизмом «Выгрузка/загрузка областей данных».
//
// Возвращаемое значение: Массив(Строка) - массив имен реквизитов, образующих
//  естественный ключ.
//
Функция ПоляЕстественногоКлюча() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("Код");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
