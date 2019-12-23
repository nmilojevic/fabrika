//! moment.js locale configuration
//! locale : English (United Kingdom) [en-gb]
//! author : Chris Gedrim : https://github.com/chrisgedrim

;(function (global, factory) {
   typeof exports === 'object' && typeof module !== 'undefined'
       && typeof require === 'function' ? factory(require('../moment')) :
   typeof define === 'function' && define.amd ? define(['../moment'], factory) :
   factory(global.moment)
}(this, function (moment) { 'use strict';


    var en_gb = moment.defineLocale('rs', {
        months : 'januar_februar_mart_april_maj_jun_jul_avgust_september_oktobar_novembar_decembar'.split('_'),
        monthsShort : 'jan_feb_mar_apr_maj_jun_jul_avg_sep_okt_nov_dec'.split('_'),
        weekdays : 'Nedelja_Ponedeljak_Utorak_Sreda_Četvrtak_Petak_Subota'.split('_'),
        weekdaysShort : 'Ned_Pon_Uto_Sre_Čet_Pet_Sub'.split('_'),
        weekdaysMin : 'Ne_Po_Ut_Sr_Čt_Pe_Su'.split('_'),
        longDateFormat : {
            LT : 'HH:mm',
            LTS : 'HH:mm:ss',
            L : 'DD/MM/YYYY',
            LL : 'D MMMM YYYY',
            LLL : 'D MMMM YYYY HH:mm',
            LLLL : 'dddd, D MMMM YYYY HH:mm'
        },
        calendar : {
            sameDay : '[Danas u] LT',
            nextDay : '[Sutra u] LT',
            nextWeek : 'dddd [at] LT',
            lastDay : '[Juče u] LT',
            lastWeek : '[Prošle] dddd [u] LT',
            sameElse : 'L'
        },
        relativeTime : {
            future : '%s',
            past : 'pre %s',
            s : 'par sekundi',
            m : 'minut',
            mm : '%d minuta',
            h : 'sat',
            hh : '%d sati',
            d : 'dan',
            dd : '%d dana',
            M : 'mesec',
            MM : '%d meseci',
            y : 'godina',
            yy : '%d godina'
        },
        ordinalParse: '.',
        ordinal : function (number) {
            return number + '.';
        },
        week : {
            dow : 1, // Monday is the first day of the week.
            doy : 4  // The week that contains Jan 4th is the first week of the year.
        }
    });

    return en_gb;

}));