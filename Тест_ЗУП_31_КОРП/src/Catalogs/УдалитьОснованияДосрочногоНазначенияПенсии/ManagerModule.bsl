#Область СлужебныеПроцедурыИФункции

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура НачальноеЗаполнение() Экспорт
	
	ЗаполнитьСправочникОснованияДосрочногоНазначенияПенсии();
	
КонецПроцедуры

Процедура ЗаполнитьСправочникОснованияДосрочногоНазначенияПенсии()
	
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_11ВП",	"27-11ВП",	"Ведущие профессии на подземных и открытых горных работах");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_11ГР",	"27-11ГР",	"Подземные и открытые горные работы");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_12",		"27-12",	"Работа на судах флота рыбной промышленности по добыче, обработке рыбы и морепродуктов");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_14",		"27-14",	"Работа по управлению воздушным движением");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_15",		"27-15",	"Работа в инженерно-техническом составе по обслуживанию воздушных судов");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_ГД",		"27-ГД",	"Лечебная и иная работа по охране здоровья населения в городах");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_ГДХР",	"27-ГДХР",	"Связанная с хирургией лечебная работа в городах");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_ПД",		"27-ПД",	"Педагогическая деятельность в школах и других учреждениях для детей всех педагогических работников");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_ПДРК",	"27-ПДРК",	"Педагогическая деятельность в школах и других учреждениях для детей в качестве директоров");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_СМ",		"27-СМ",	"Лечебная и иная работа по охране здоровья населения в сельской местности");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_СМХР",	"27-СМХР",	"Связанная с хирургией лечебная работа в сельской местности");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("Ст27_СП",		"27-СП",	"Работа спасателем в профессиональных аварийно-спасательных службах");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ВЫСШПИЛ",		"ВЫСШПИЛ",	"Работа в должн. летного состава в учебных и спорт. авиац-ных организациях (высший пилотаж)");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ИНСПЕКТ",		"ИНСПЕКТ",	"Работники, проводящие инспектирование летного состава в испытательных полетах");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ИСПКЛС1",		"ИСПКЛС1",	"Работа в качестве летчика-испытателя 1 класса");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ИТСИСП",		"ИТСИСП",	"Инженерно–технический состав, совершающий полеты по испытаниям");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ИТСМАВ",		"ИТСМАВ",	"Инженерно–технический состав, совершающий полеты по испытаниям на воздушных судах маневренной авиаци");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ЛЕТИСП",		"ЛЕТИСП",	"Летно-испытательный состав");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ЛЕТРАБ",		"ЛЕТРАБ",	"Парашютисты, а также работники авиации летного состава в учебных и спортивных авиационных организ-ях");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("НОРМАПР",		"НОРМАПР",	"Парашютисты, выполнившие годовую норму прыжков с поршневых самолетов");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("НОРМСП",		"НОРМСП",	"Парашютисты, выполнившие годовую норму спусков (подъемов) с поршневых самолетов");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("ОПЫТИСП",		"ОПЫТИСП",	"Работа в качестве летчика (пилота)-испытателя, штурмана-испытателя и парашютиста-испытателя");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("РЕАКТИВН",		"РЕАКТИВН",	"Парашютисты, выполнившие годовую норму прыжков с реактивных самолетов и вертолетов");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("САМОЛЕТ",		"САМОЛЕТ",	"Работа в летном составе на самолетах гражданской авиации");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("СПАСАВ",		"СПАСАВ",	"Работа в составе летного экипажа воздушного судна в аварийно-(поисково-)спасательных  подразделениях");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("СПЕЦАВ",		"СПЕЦАВ",	"Работа в летном составе на вертолетах, в авиации специального применения");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("УЧЛЕТ",		"УЧЛЕТ",	"Работа в должностях летного состава в учебных и спортивных авиационных организациях");

	ДобавитьОснованиеДосрочногоНазначенияПенсии("", "ИТС", "Работа в инженерно-техническом составе по обслуживанию воздушных судов");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("", "ТВОРЧ15", "Творческая работа не менее 15 лет");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("", "ТВОРЧ20", "Творческая работа не менее 20 лет");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("", "ТВОРЧ25", "Творческая работа не менее 25 лет");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("", "ТВОРЧ30", "Творческая работа не менее 30 лет");
	ДобавитьОснованиеДосрочногоНазначенияПенсии("", "УВД", "Работа по управлению воздушным движением");
	
КонецПроцедуры

Процедура ДобавитьОснованиеДосрочногоНазначенияПенсии(ИмяПредопределенныхДанных, Код, Наименование)
	
	Если ПустаяСтрока(ИмяПредопределенныхДанных) Тогда
		
		СсылкаНаЭлемент = Справочники.ОснованияДосрочногоНазначенияПенсии.НайтиПоКоду(Код);
		Если ЗначениеЗаполнено(СсылкаНаЭлемент) Тогда
			Элемент = СсылкаНаЭлемент.ПолучитьОбъект();
		Иначе
			Элемент = Справочники.ОснованияДосрочногоНазначенияПенсии.СоздатьЭлемент();
		КонецЕсли;
		
	Иначе
		
		СсылкаПредопределенного = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ОснованияДосрочногоНазначенияПенсии." + ИмяПредопределенныхДанных);
		Если ЗначениеЗаполнено(СсылкаПредопределенного) Тогда
			Элемент = СсылкаПредопределенного.ПолучитьОбъект();
		Иначе
			Элемент = Справочники.ОснованияДосрочногоНазначенияПенсии.СоздатьЭлемент();
			Элемент.ИмяПредопределенныхДанных = ИмяПредопределенныхДанных;
		КонецЕсли;

	КонецЕсли;
	
	Элемент.ДополнительныеСвойства.Вставить("ЗаписьОбщихДанных", Истина);
	Элемент.Код = Код;
	Элемент.Наименование = Наименование;
	
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
