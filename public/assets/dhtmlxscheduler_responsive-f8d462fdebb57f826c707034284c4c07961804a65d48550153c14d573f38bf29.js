function initResponsive(i){function e(e,t,n){i.xy.nav_height=e,u[i.skin]&&(i.xy.nav_height=t),i.templates.week_scale_date=function(e){return i.date.date_to_str(n)(e)}}function t(e){var t=document.createElement("link");t.setAttribute("rel","stylesheet"),t.setAttribute("type","text/css"),t.setAttribute("href",e),document.getElementsByTagName("head")[0].appendChild(t)}function n(e,t){var n=document.getElementsByTagName("head")[0],i=document.createElement("script");i.type="text/javascript",i.src=e,i.onreadystatechange=t,i.onload=t,n.appendChild(i)}var a=59,c=23,s=130,o=140,d=!0,r="%F, %D %d",h="%D %d",u={glossy:!0,classic:!0};i.attachEvent("onBeforeViewChange",function l(){return void 0!==i&&(768<=window.innerWidth?e(a,c,r):e(s,o,h)),!0}),i.attachEvent("onSchedulerResize",function(){i.setCurrentView()}),i.attachEvent("onTemplatesReady",function(){u[i.skin]&&t("../Content/dhtmlxScheduler/dhtmlxscheduler-responsive-classic.css")}),/Android|webOS|iPhone|iPad|iPod|IEMobile/i.test(navigator.userAgent)&&d&&n("../Scripts/dhtmlxScheduler/ext/dhtmlxscheduler_quick_info.js",function(){i.config.touch="force",i.xy.menu_width=0})}