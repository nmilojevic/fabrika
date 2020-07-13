!function(e){"function"==typeof define&&define.amd?define(["jquery"],e):e(jQuery)}(function(r){function n(e,t){var i,n,s,o=e.nodeName.toLowerCase();return"area"===o?(n=(i=e.parentNode).name,!(!e.href||!n||"map"!==i.nodeName.toLowerCase())&&(!!(s=r("img[usemap='#"+n+"']")[0])&&a(s))):(/^(input|select|textarea|button|object)$/.test(o)?!e.disabled:"a"===o&&e.href||t)&&a(e)}function a(e){return r.expr.filters.visible(e)&&!r(e).parents().addBack().filter(function(){return"hidden"===r.css(this,"visibility")}).length}var e,t,i,s;r.ui=r.ui||{},r.extend(r.ui,{version:"1.11.4",keyCode:{BACKSPACE:8,COMMA:188,DELETE:46,DOWN:40,END:35,ENTER:13,ESCAPE:27,HOME:36,LEFT:37,PAGE_DOWN:34,PAGE_UP:33,PERIOD:190,RIGHT:39,SPACE:32,TAB:9,UP:38}}),r.fn.extend({scrollParent:function(e){var t=this.css("position"),i="absolute"===t,n=e?/(auto|scroll|hidden)/:/(auto|scroll)/,s=this.parents().filter(function(){var e=r(this);return(!i||"static"!==e.css("position"))&&n.test(e.css("overflow")+e.css("overflow-y")+e.css("overflow-x"))}).eq(0);return"fixed"!==t&&s.length?s:r(this[0].ownerDocument||document)},uniqueId:(e=0,function(){return this.each(function(){this.id||(this.id="ui-id-"+ ++e)})}),removeUniqueId:function(){return this.each(function(){/^ui-id-\d+$/.test(this.id)&&r(this).removeAttr("id")})}}),r.extend(r.expr[":"],{data:r.expr.createPseudo?r.expr.createPseudo(function(t){return function(e){return!!r.data(e,t)}}):function(e,t,i){return!!r.data(e,i[3])},focusable:function(e){return n(e,!isNaN(r.attr(e,"tabindex")))},tabbable:function(e){var t=r.attr(e,"tabindex"),i=isNaN(t);return(i||0<=t)&&n(e,!i)}}),r("<a>").outerWidth(1).jquery||r.each(["Width","Height"],function(e,i){function n(e,t,i,n){return r.each(s,function(){t-=parseFloat(r.css(e,"padding"+this))||0,i&&(t-=parseFloat(r.css(e,"border"+this+"Width"))||0),n&&(t-=parseFloat(r.css(e,"margin"+this))||0)}),t}var s="Width"===i?["Left","Right"]:["Top","Bottom"],o=i.toLowerCase(),a={innerWidth:r.fn.innerWidth,innerHeight:r.fn.innerHeight,outerWidth:r.fn.outerWidth,outerHeight:r.fn.outerHeight};r.fn["inner"+i]=function(e){return e===undefined?a["inner"+i].call(this):this.each(function(){r(this).css(o,n(this,e)+"px")})},r.fn["outer"+i]=function(e,t){return"number"!=typeof e?a["outer"+i].call(this,e):this.each(function(){r(this).css(o,n(this,e,!0,t)+"px")})}}),r.fn.addBack||(r.fn.addBack=function(e){return this.add(null==e?this.prevObject:this.prevObject.filter(e))}),r("<a>").data("a-b","a").removeData("a-b").data("a-b")&&(r.fn.removeData=(t=r.fn.removeData,function(e){return arguments.length?t.call(this,r.camelCase(e)):t.call(this)})),r.ui.ie=!!/msie [\w.]+/.exec(navigator.userAgent.toLowerCase()),r.fn.extend({focus:(s=r.fn.focus,function(t,i){return"number"==typeof t?this.each(function(){var e=this;setTimeout(function(){r(e).focus(),i&&i.call(e)},t)}):s.apply(this,arguments)}),disableSelection:(i="onselectstart"in document.createElement("div")?"selectstart":"mousedown",function(){return this.bind(i+".ui-disableSelection",function(e){e.preventDefault()})}),enableSelection:function(){return this.unbind(".ui-disableSelection")},zIndex:function(e){if(e!==undefined)return this.css("zIndex",e);if(this.length)for(var t,i,n=r(this[0]);n.length&&n[0]!==document;){if(("absolute"===(t=n.css("position"))||"relative"===t||"fixed"===t)&&(i=parseInt(n.css("zIndex"),10),!isNaN(i)&&0!==i))return i;n=n.parent()}return 0}}),r.ui.plugin={add:function(e,t,i){var n,s=r.ui[e].prototype;for(n in i)s.plugins[n]=s.plugins[n]||[],s.plugins[n].push([t,i[n]])},call:function(e,t,i,n){var s,o=e.plugins[t];if(o&&(n||e.element[0].parentNode&&11!==e.element[0].parentNode.nodeType))for(s=0;s<o.length;s++)e.options[o[s][0]]&&o[s][1].apply(e.element,i)}}}),function(e){"function"==typeof define&&define.amd?define(["jquery"],e):e(jQuery)}(function(h){var o,i=0,r=Array.prototype.slice;return h.cleanData=(o=h.cleanData,function(e){var t,i,n;for(n=0;null!=(i=e[n]);n++)try{(t=h._data(i,"events"))&&t.remove&&h(i).triggerHandler("remove")}catch(s){}o(e)}),h.widget=function(e,i,t){var n,s,o,a,r={},l=e.split(".")[0];return e=e.split(".")[1],n=l+"-"+e,t||(t=i,i=h.Widget),h.expr[":"][n.toLowerCase()]=function(e){return!!h.data(e,n)},h[l]=h[l]||{},s=h[l][e],o=h[l][e]=function(e,t){if(!this._createWidget)return new o(e,t);arguments.length&&this._createWidget(e,t)},h.extend(o,s,{version:t.version,_proto:h.extend({},t),_childConstructors:[]}),(a=new i).options=h.widget.extend({},a.options),h.each(t,function(t,n){var s,o;h.isFunction(n)?r[t]=(s=function(){return i.prototype[t].apply(this,arguments)},o=function(e){return i.prototype[t].apply(this,e)},function(){var e,t=this._super,i=this._superApply;return this._super=s,this._superApply=o,e=n.apply(this,arguments),this._super=t,this._superApply=i,e}):r[t]=n}),o.prototype=h.widget.extend(a,{widgetEventPrefix:s&&a.widgetEventPrefix||e},r,{constructor:o,namespace:l,widgetName:e,widgetFullName:n}),s?(h.each(s._childConstructors,function(e,t){var i=t.prototype;h.widget(i.namespace+"."+i.widgetName,o,t._proto)}),delete s._childConstructors):i._childConstructors.push(o),h.widget.bridge(e,o),o},h.widget.extend=function(e){for(var t,i,n=r.call(arguments,1),s=0,o=n.length;s<o;s++)for(t in n[s])i=n[s][t],n[s].hasOwnProperty(t)&&i!==undefined&&(h.isPlainObject(i)?e[t]=h.isPlainObject(e[t])?h.widget.extend({},e[t],i):h.widget.extend({},i):e[t]=i);return e},h.widget.bridge=function(o,t){var a=t.prototype.widgetFullName||o;h.fn[o]=function(i){var e="string"==typeof i,n=r.call(arguments,1),s=this;return e?this.each(function(){var e,t=h.data(this,a);return"instance"===i?(s=t,!1):t?h.isFunction(t[i])&&"_"!==i.charAt(0)?(e=t[i].apply(t,n))!==t&&e!==undefined?(s=e&&e.jquery?s.pushStack(e.get()):e,!1):void 0:h.error("no such method '"+i+"' for "+o+" widget instance"):h.error("cannot call methods on "+o+" prior to initialization; attempted to call method '"+i+"'")}):(n.length&&(i=h.widget.extend.apply(null,[i].concat(n))),this.each(function(){var e=h.data(this,a);e?(e.option(i||{}),e._init&&e._init()):h.data(this,a,new t(i,this))})),s}},h.Widget=function(){},h.Widget._childConstructors=[],h.Widget.prototype={widgetName:"widget",widgetEventPrefix:"",defaultElement:"<div>",options:{disabled:!1,create:null},_createWidget:function(e,t){t=h(t||this.defaultElement||this)[0],this.element=h(t),this.uuid=i++,this.eventNamespace="."+this.widgetName+this.uuid,this.bindings=h(),this.hoverable=h(),this.focusable=h(),t!==this&&(h.data(t,this.widgetFullName,this),this._on(!0,this.element,{remove:function(e){e.target===t&&this.destroy()}}),this.document=h(t.style?t.ownerDocument:t.document||t),this.window=h(this.document[0].defaultView||this.document[0].parentWindow)),this.options=h.widget.extend({},this.options,this._getCreateOptions(),e),this._create(),this._trigger("create",null,this._getCreateEventData()),this._init()},_getCreateOptions:h.noop,_getCreateEventData:h.noop,_create:h.noop,_init:h.noop,destroy:function(){this._destroy(),this.element.unbind(this.eventNamespace).removeData(this.widgetFullName).removeData(h.camelCase(this.widgetFullName)),this.widget().unbind(this.eventNamespace).removeAttr("aria-disabled").removeClass(this.widgetFullName+"-disabled ui-state-disabled"),this.bindings.unbind(this.eventNamespace),this.hoverable.removeClass("ui-state-hover"),this.focusable.removeClass("ui-state-focus")},_destroy:h.noop,widget:function(){return this.element},option:function(e,t){var i,n,s,o=e;if(0===arguments.length)return h.widget.extend({},this.options);if("string"==typeof e)if(o={},e=(i=e.split(".")).shift(),i.length){for(n=o[e]=h.widget.extend({},this.options[e]),s=0;s<i.length-1;s++)n[i[s]]=n[i[s]]||{},n=n[i[s]];if(e=i.pop(),1===arguments.length)return n[e]===undefined?null:n[e];n[e]=t}else{if(1===arguments.length)return this.options[e]===undefined?null:this.options[e];o[e]=t}return this._setOptions(o),this},_setOptions:function(e){var t;for(t in e)this._setOption(t,e[t]);return this},_setOption:function(e,t){return this.options[e]=t,"disabled"===e&&(this.widget().toggleClass(this.widgetFullName+"-disabled",!!t),t&&(this.hoverable.removeClass("ui-state-hover"),this.focusable.removeClass("ui-state-focus"))),this},enable:function(){return this._setOptions({disabled:!1})},disable:function(){return this._setOptions({disabled:!0})},_on:function(a,r,e){var l,u=this;"boolean"!=typeof a&&(e=r,r=a,a=!1),e?(r=l=h(r),this.bindings=this.bindings.add(r)):(e=r,r=this.element,l=this.widget()),h.each(e,function(e,t){function i(){if(a||!0!==u.options.disabled&&!h(this).hasClass("ui-state-disabled"))return("string"==typeof t?u[t]:t).apply(u,arguments)}"string"!=typeof t&&(i.guid=t.guid=t.guid||i.guid||h.guid++);var n=e.match(/^([\w:-]*)\s*(.*)$/),s=n[1]+u.eventNamespace,o=n[2];o?l.delegate(o,s,i):r.bind(s,i)})},_off:function(e,t){t=(t||"").split(" ").join(this.eventNamespace+" ")+this.eventNamespace,e.unbind(t).undelegate(t),this.bindings=h(this.bindings.not(e).get()),this.focusable=h(this.focusable.not(e).get()),this.hoverable=h(this.hoverable.not(e).get())},_delay:function(e,t){function i(){return("string"==typeof e?n[e]:e).apply(n,arguments)}var n=this;return setTimeout(i,t||0)},_hoverable:function(e){this.hoverable=this.hoverable.add(e),this._on(e,{mouseenter:function(e){h(e.currentTarget).addClass("ui-state-hover")},mouseleave:function(e){h(e.currentTarget).removeClass("ui-state-hover")}})},_focusable:function(e){this.focusable=this.focusable.add(e),this._on(e,{focusin:function(e){h(e.currentTarget).addClass("ui-state-focus")},focusout:function(e){h(e.currentTarget).removeClass("ui-state-focus")}})},_trigger:function(e,t,i){var n,s,o=this.options[e];if(i=i||{},(t=h.Event(t)).type=(e===this.widgetEventPrefix?e:this.widgetEventPrefix+e).toLowerCase(),t.target=this.element[0],s=t.originalEvent)for(n in s)n in t||(t[n]=s[n]);return this.element.trigger(t,i),!(h.isFunction(o)&&!1===o.apply(this.element[0],[t].concat(i))||t.isDefaultPrevented())}},h.each({show:"fadeIn",hide:"fadeOut"},function(o,a){h.Widget.prototype["_"+o]=function(t,e,i){"string"==typeof e&&(e={effect:e});var n,s=e?!0===e||"number"==typeof e?a:e.effect||a:o;"number"==typeof(e=e||{})&&(e={duration:e}),n=!h.isEmptyObject(e),e.complete=i,e.delay&&t.delay(e.delay),n&&h.effects&&h.effects.effect[s]?t[o](e):s!==o&&t[s]?t[s](e.duration,e.easing,i):t.queue(function(e){h(this)[o](),i&&i.call(t[0]),e()})}}),h.widget}),function(e){"function"==typeof define&&define.amd?define(["jquery"],e):e(jQuery)}(function(A){return function(){function x(e,t,i){return[parseFloat(e[0])*(l.test(e[0])?t/100:1),parseFloat(e[1])*(l.test(e[1])?i/100:1)]}function C(e,t){return parseInt(A.css(e,t),10)||0}function t(e){var t=e[0];return 9===t.nodeType?{width:e.width(),height:e.height(),offset:{top:0,left:0}}:A.isWindow(t)?{width:e.width(),height:e.height(),offset:{top:e.scrollTop(),left:e.scrollLeft()}}:t.preventDefault?{width:0,height:0,offset:{top:t.pageY,left:t.pageX}}:{width:e.outerWidth(),height:e.outerHeight(),offset:e.offset()}}A.ui=A.ui||{};var s,k,T=Math.max,E=Math.abs,W=Math.round,n=/left|center|right/,o=/top|center|bottom/,a=/[\+\-]\d+(\.[\d]+)?%?/,r=/^\w+/,l=/%$/,i=A.fn.position;A.position={scrollbarWidth:function(){if(s!==undefined)return s;var e,t,i=A("<div style='display:block;position:absolute;width:50px;height:50px;overflow:hidden;'><div style='height:100px;width:auto;'></div></div>"),n=i.children()[0];return A("body").append(i),e=n.offsetWidth,i.css("overflow","scroll"),e===(t=n.offsetWidth)&&(t=i[0].clientWidth),i.remove(),s=e-t},getScrollInfo:function(e){var t=e.isWindow||e.isDocument?"":e.element.css("overflow-x"),i=e.isWindow||e.isDocument?"":e.element.css("overflow-y"),n="scroll"===t||"auto"===t&&e.width<e.element[0].scrollWidth;return{width:"scroll"===i||"auto"===i&&e.height<e.element[0].scrollHeight?A.position.scrollbarWidth():0,height:n?A.position.scrollbarWidth():0}},getWithinInfo:function(e){var t=A(e||window),i=A.isWindow(t[0]),n=!!t[0]&&9===t[0].nodeType;return{element:t,isWindow:i,isDocument:n,offset:t.offset()||{left:0,top:0},scrollLeft:t.scrollLeft(),scrollTop:t.scrollTop(),width:i||n?t.width():t.outerWidth(),height:i||n?t.height():t.outerHeight()}}},A.fn.position=function(c){if(!c||!c.of)return i.apply(this,arguments);c=A.extend({},c);var d,f,p,m,v,e,g=A(c.of),_=A.position.getWithinInfo(c.within),b=A.position.getScrollInfo(_),y=(c.collision||"flip").split(" "),w={};return e=t(g),g[0].preventDefault&&(c.at="left top"),f=e.width,p=e.height,m=e.offset,v=A.extend({},m),A.each(["my","at"],function(){var e,t,i=(c[this]||"").split(" ");1===i.length&&(i=n.test(i[0])?i.concat(["center"]):o.test(i[0])?["center"].concat(i):["center","center"]),i[0]=n.test(i[0])?i[0]:"center",i[1]=o.test(i[1])?i[1]:"center",e=a.exec(i[0]),t=a.exec(i[1]),w[this]=[e?e[0]:0,t?t[0]:0],c[this]=[r.exec(i[0])[0],r.exec(i[1])[0]]}),1===y.length&&(y[1]=y[0]),"right"===c.at[0]?v.left+=f:"center"===c.at[0]&&(v.left+=f/2),"bottom"===c.at[1]?v.top+=p:"center"===c.at[1]&&(v.top+=p/2),d=x(w.at,f,p),v.left+=d[0],v.top+=d[1],this.each(function(){var i,e,a=A(this),r=a.outerWidth(),l=a.outerHeight(),t=C(this,"marginLeft"),n=C(this,"marginTop"),s=r+t+C(this,"marginRight")+b.width,o=l+n+C(this,"marginBottom")+b.height,u=A.extend({},v),h=x(w.my,a.outerWidth(),a.outerHeight());"right"===c.my[0]?u.left-=r:"center"===c.my[0]&&(u.left-=r/2),"bottom"===c.my[1]?u.top-=l:"center"===c.my[1]&&(u.top-=l/2),u.left+=h[0],u.top+=h[1],k||(u.left=W(u.left),u.top=W(u.top)),i={marginLeft:t,marginTop:n},A.each(["left","top"],function(e,t){A.ui.position[y[e]]&&A.ui.position[y[e]][t](u,{targetWidth:f,targetHeight:p,elemWidth:r,elemHeight:l,collisionPosition:i,collisionWidth:s,collisionHeight:o,offset:[d[0]+h[0],d[1]+h[1]],my:c.my,at:c.at,within:_,elem:a})}),c.using&&(e=function(e){var t=m.left-u.left,i=t+f-r,n=m.top-u.top,s=n+p-l,o={target:{element:g,left:m.left,top:m.top,width:f,height:p},element:{element:a,left:u.left,top:u.top,width:r,height:l},horizontal:i<0?"left":0<t?"right":"center",vertical:s<0?"top":0<n?"bottom":"middle"};f<r&&E(t+i)<f&&(o.horizontal="center"),p<l&&E(n+s)<p&&(o.vertical="middle"),T(E(t),E(i))>T(E(n),E(s))?o.important="horizontal":o.important="vertical",c.using.call(this,e,o)}),a.offset(A.extend(u,{using:e}))})},A.ui.position={fit:{left:function(e,t){var i,n=t.within,s=n.isWindow?n.scrollLeft:n.offset.left,o=n.width,a=e.left-t.collisionPosition.marginLeft,r=s-a,l=a+t.collisionWidth-o-s;t.collisionWidth>o?0<r&&l<=0?(i=e.left+r+t.collisionWidth-o-s,e.left+=r-i):e.left=0<l&&r<=0?s:l<r?s+o-t.collisionWidth:s:0<r?e.left+=r:0<l?e.left-=l:e.left=T(e.left-a,e.left)},top:function(e,t){var i,n=t.within,s=n.isWindow?n.scrollTop:n.offset.top,o=t.within.height,a=e.top-t.collisionPosition.marginTop,r=s-a,l=a+t.collisionHeight-o-s;t.collisionHeight>o?0<r&&l<=0?(i=e.top+r+t.collisionHeight-o-s,e.top+=r-i):e.top=0<l&&r<=0?s:l<r?s+o-t.collisionHeight:s:0<r?e.top+=r:0<l?e.top-=l:e.top=T(e.top-a,e.top)}},flip:{left:function(e,t){var i,n,s=t.within,o=s.offset.left+s.scrollLeft,a=s.width,r=s.isWindow?s.scrollLeft:s.offset.left,l=e.left-t.collisionPosition.marginLeft,u=l-r,h=l+t.collisionWidth-a-r,c="left"===t.my[0]?-t.elemWidth:"right"===t.my[0]?t.elemWidth:0,d="left"===t.at[0]?t.targetWidth:"right"===t.at[0]?-t.targetWidth:0,f=-2*t.offset[0];u<0?((i=e.left+c+d+f+t.collisionWidth-a-o)<0||i<E(u))&&(e.left+=c+d+f):0<h&&(0<(n=e.left-t.collisionPosition.marginLeft+c+d+f-r)||E(n)<h)&&(e.left+=c+d+f)},top:function(e,t){var i,n,s=t.within,o=s.offset.top+s.scrollTop,a=s.height,r=s.isWindow?s.scrollTop:s.offset.top,l=e.top-t.collisionPosition.marginTop,u=l-r,h=l+t.collisionHeight-a-r,c="top"===t.my[1]?-t.elemHeight:"bottom"===t.my[1]?t.elemHeight:0,d="top"===t.at[1]?t.targetHeight:"bottom"===t.at[1]?-t.targetHeight:0,f=-2*t.offset[1];u<0?((n=e.top+c+d+f+t.collisionHeight-a-o)<0||n<E(u))&&(e.top+=c+d+f):0<h&&(0<(i=e.top-t.collisionPosition.marginTop+c+d+f-r)||E(i)<h)&&(e.top+=c+d+f)}},flipfit:{left:function(){A.ui.position.flip.left.apply(this,arguments),A.ui.position.fit.left.apply(this,arguments)},top:function(){A.ui.position.flip.top.apply(this,arguments),A.ui.position.fit.top.apply(this,arguments)}}},function(){var e,t,i,n,s,o=document.getElementsByTagName("body")[0],a=document.createElement("div");for(s in e=document.createElement(o?"div":"body"),i={visibility:"hidden",width:0,height:0,border:0,margin:0,background:"none"},o&&A.extend(i,{position:"absolute",left:"-1000px",top:"-1000px"}),i)e.style[s]=i[s];e.appendChild(a),(t=o||document.documentElement).insertBefore(e,t.firstChild),a.style.cssText="position: absolute; left: 10.7432222px;",n=A(a).offset().left,k=10<n&&n<11,e.innerHTML="",t.removeChild(e)}()}(),A.ui.position}),function(e){"function"==typeof define&&define.amd?define(["jquery","./core","./widget","./position"],e):e(jQuery)}(function(r){return r.widget("ui.menu",{version:"1.11.4",defaultElement:"<ul>",delay:300,options:{icons:{submenu:"ui-icon-carat-1-e"},items:"> *",menus:"ul",position:{my:"left-1 top",at:"right top"},role:"menu",blur:null,focus:null,select:null},_create:function(){this.activeMenu=this.element,this.mouseHandled=!1,this.element.uniqueId().addClass("ui-menu ui-widget ui-widget-content").toggleClass("ui-menu-icons",!!this.element.find(".ui-icon").length).attr({role:this.options.role,tabIndex:0}),this.options.disabled&&this.element.addClass("ui-state-disabled").attr("aria-disabled","true"),this._on({"mousedown .ui-menu-item":function(e){e.preventDefault()},"click .ui-menu-item":function(e){var t=r(e.target);!this.mouseHandled&&t.not(".ui-state-disabled").length&&(this.select(e),e.isPropagationStopped()||(this.mouseHandled=!0),t.has(".ui-menu").length?this.expand(e):!this.element.is(":focus")&&r(this.document[0].activeElement).closest(".ui-menu").length&&(this.element.trigger("focus",[!0]),this.active&&1===this.active.parents(".ui-menu").length&&clearTimeout(this.timer)))},"mouseenter .ui-menu-item":function(e){if(!this.previousFilter){var t=r(e.currentTarget);t.siblings(".ui-state-active").removeClass("ui-state-active"),this.focus(e,t)}},mouseleave:"collapseAll","mouseleave .ui-menu":"collapseAll",focus:function(e,t){var i=this.active||this.element.find(this.options.items).eq(0);t||this.focus(e,i)},blur:function(e){this._delay(function(){r.contains(this.element[0],this.document[0].activeElement)||this.collapseAll(e)})},keydown:"_keydown"}),this.refresh(),this._on(this.document,{click:function(e){this._closeOnDocumentClick(e)&&this.collapseAll(e),this.mouseHandled=!1}})},_destroy:function(){this.element.removeAttr("aria-activedescendant").find(".ui-menu").addBack().removeClass("ui-menu ui-widget ui-widget-content ui-menu-icons ui-front").removeAttr("role").removeAttr("tabIndex").removeAttr("aria-labelledby").removeAttr("aria-expanded").removeAttr("aria-hidden").removeAttr("aria-disabled").removeUniqueId().show(),this.element.find(".ui-menu-item").removeClass("ui-menu-item").removeAttr("role").removeAttr("aria-disabled").removeUniqueId().removeClass("ui-state-hover").removeAttr("tabIndex").removeAttr("role").removeAttr("aria-haspopup").children().each(function(){var e=r(this);e.data("ui-menu-submenu-carat")&&e.remove()}),this.element.find(".ui-menu-divider").removeClass("ui-menu-divider ui-widget-content")},_keydown:function(e){var t,i,n,s,o=!0;switch(e.keyCode){case r.ui.keyCode.PAGE_UP:this.previousPage(e);break;case r.ui.keyCode.PAGE_DOWN:this.nextPage(e);break;case r.ui.keyCode.HOME:this._move("first","first",e);break;case r.ui.keyCode.END:this._move("last","last",e);break;case r.ui.keyCode.UP:this.previous(e);break;case r.ui.keyCode.DOWN:this.next(e);break;case r.ui.keyCode.LEFT:this.collapse(e);break;case r.ui.keyCode.RIGHT:this.active&&!this.active.is(".ui-state-disabled")&&this.expand(e);break;case r.ui.keyCode.ENTER:case r.ui.keyCode.SPACE:this._activate(e);break;case r.ui.keyCode.ESCAPE:this.collapse(e);break;default:o=!1,i=this.previousFilter||"",n=String.fromCharCode(e.keyCode),s=!1,clearTimeout(this.filterTimer),n===i?s=!0:n=i+n,t=this._filterMenuItems(n),(t=s&&-1!==t.index(this.active.next())?this.active.nextAll(".ui-menu-item"):t).length||(n=String.fromCharCode(e.keyCode),t=this._filterMenuItems(n)),t.length?(this.focus(e,t),this.previousFilter=n,this.filterTimer=this._delay(function(){delete this.previousFilter},1e3)):delete this.previousFilter}o&&e.preventDefault()},_activate:function(e){this.active.is(".ui-state-disabled")||(this.active.is("[aria-haspopup='true']")?this.expand(e):this.select(e))},refresh:function(){var e,t=this,n=this.options.icons.submenu,i=this.element.find(this.options.menus);this.element.toggleClass("ui-menu-icons",!!this.element.find(".ui-icon").length),i.filter(":not(.ui-menu)").addClass("ui-menu ui-widget ui-widget-content ui-front").hide().attr({role:this.options.role,"aria-hidden":"true","aria-expanded":"false"}).each(function(){var e=r(this),t=e.parent(),i=r("<span>").addClass("ui-menu-icon ui-icon "+n).data("ui-menu-submenu-carat",!0);t.attr("aria-haspopup","true").prepend(i),e.attr("aria-labelledby",t.attr("id"))}),(e=i.add(this.element).find(this.options.items)).not(".ui-menu-item").each(function(){var e=r(this);t._isDivider(e)&&e.addClass("ui-widget-content ui-menu-divider")}),e.not(".ui-menu-item, .ui-menu-divider").addClass("ui-menu-item").uniqueId().attr({tabIndex:-1,role:this._itemRole()}),e.filter(".ui-state-disabled").attr("aria-disabled","true"),this.active&&!r.contains(this.element[0],this.active[0])&&this.blur()},_itemRole:function(){return{menu:"menuitem",listbox:"option"}[this.options.role]},_setOption:function(e,t){"icons"===e&&this.element.find(".ui-menu-icon").removeClass(this.options.icons.submenu).addClass(t.submenu),"disabled"===e&&this.element.toggleClass("ui-state-disabled",!!t).attr("aria-disabled",t),this._super(e,t)},focus:function(e,t){var i,n;this.blur(e,e&&"focus"===e.type),this._scrollIntoView(t),this.active=t.first(),n=this.active.addClass("ui-state-focus").removeClass("ui-state-active"),this.options.role&&this.element.attr("aria-activedescendant",n.attr("id")),this.active.parent().closest(".ui-menu-item").addClass("ui-state-active"),e&&"keydown"===e.type?this._close():this.timer=this._delay(function(){this._close()},this.delay),(i=t.children(".ui-menu")).length&&e&&/^mouse/.test(e.type)&&this._startOpening(i),this.activeMenu=t.parent(),this._trigger("focus",e,{item:t})},_scrollIntoView:function(e){var t,i,n,s,o,a;this._hasScroll()&&(t=parseFloat(r.css(this.activeMenu[0],"borderTopWidth"))||0,i=parseFloat(r.css(this.activeMenu[0],"paddingTop"))||0,n=e.offset().top-this.activeMenu.offset().top-t-i,s=this.activeMenu.scrollTop(),o=this.activeMenu.height(),a=e.outerHeight(),n<0?this.activeMenu.scrollTop(s+n):o<n+a&&this.activeMenu.scrollTop(s+n-o+a))},blur:function(e,t){t||clearTimeout(this.timer),this.active&&(this.active.removeClass("ui-state-focus"),this.active=null,this._trigger("blur",e,{item:this.active}))},_startOpening:function(e){clearTimeout(this.timer),"true"===e.attr("aria-hidden")&&(this.timer=this._delay(function(){this._close(),this._open(e)},this.delay))},_open:function(e){var t=r.extend({of:this.active},this.options.position);clearTimeout(this.timer),this.element.find(".ui-menu").not(e.parents(".ui-menu")).hide().attr("aria-hidden","true"),e.show().removeAttr("aria-hidden").attr("aria-expanded","true").position(t)},collapseAll:function(t,i){clearTimeout(this.timer),this.timer=this._delay(function(){var e=i?this.element:r(t&&t.target).closest(this.element.find(".ui-menu"));e.length||(e=this.element),this._close(e),this.blur(t),this.activeMenu=e},this.delay)},_close:function(e){e||(e=this.active?this.active.parent():this.element),e.find(".ui-menu").hide().attr("aria-hidden","true").attr("aria-expanded","false").end().find(".ui-state-active").not(".ui-state-focus").removeClass("ui-state-active")},_closeOnDocumentClick:function(e){return!r(e.target).closest(".ui-menu").length},_isDivider:function(e){return!/[^\-\u2014\u2013\s]/.test(e.text())},collapse:function(e){var t=this.active&&this.active.parent().closest(".ui-menu-item",this.element);t&&t.length&&(this._close(),this.focus(e,t))},expand:function(e){var t=this.active&&this.active.children(".ui-menu ").find(this.options.items).first();t&&t.length&&(this._open(t.parent()),this._delay(function(){this.focus(e,t)}))},next:function(e){this._move("next","first",e)},previous:function(e){this._move("prev","last",e)},isFirstItem:function(){return this.active&&!this.active.prevAll(".ui-menu-item").length},isLastItem:function(){return this.active&&!this.active.nextAll(".ui-menu-item").length},_move:function(e,t,i){var n;this.active&&(n="first"===e||"last"===e?this.active["first"===e?"prevAll":"nextAll"](".ui-menu-item").eq(-1):this.active[e+"All"](".ui-menu-item").eq(0)),n&&n.length&&this.active||(n=this.activeMenu.find(this.options.items)[t]()),this.focus(i,n)},nextPage:function(e){var t,i,n;this.active?this.isLastItem()||(this._hasScroll()?(i=this.active.offset().top,n=this.element.height(),this.active.nextAll(".ui-menu-item").each(function(){return(t=r(this)).offset().top-i-n<0}),this.focus(e,t)):this.focus(e,this.activeMenu.find(this.options.items)[this.active?"last":"first"]())):this.next(e)},previousPage:function(e){var t,i,n;this.active?this.isFirstItem()||(this._hasScroll()?(i=this.active.offset().top,n=this.element.height(),this.active.prevAll(".ui-menu-item").each(function(){return 0<(t=r(this)).offset().top-i+n}),this.focus(e,t)):this.focus(e,this.activeMenu.find(this.options.items).first())):this.next(e)},_hasScroll:function(){return this.element.outerHeight()<this.element.prop("scrollHeight")},select:function(e){this.active=this.active||r(e.target).closest(".ui-menu-item");var t={item:this.active};this.active.has(".ui-menu").length||this.collapseAll(e,!0),this._trigger("select",e,t)},_filterMenuItems:function(e){var t=e.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g,"\\$&"),i=new RegExp("^"+t,"i");return this.activeMenu.find(this.options.items).filter(".ui-menu-item").filter(function(){return i.test(r.trim(r(this).text()))})}})}),function(e){"function"==typeof define&&define.amd?define(["jquery","./core","./widget","./position","./menu"],e):e(jQuery)}(function(a){return a.widget("ui.autocomplete",{version:"1.11.4",defaultElement:"<input>",options:{appendTo:null,autoFocus:!1,delay:300,minLength:1,position:{my:"left top",at:"left bottom",collision:"none"},source:null,change:null,close:null,focus:null,open:null,response:null,search:null,select:null},requestIndex:0,pending:0,_create:function(){var i,n,s,e=this.element[0].nodeName.toLowerCase(),t="textarea"===e,o="input"===e;this.isMultiLine=!!t||!o&&this.element.prop("isContentEditable"),this.valueMethod=this.element[t||o?"val":"text"],this.isNewMenu=!0,this.element.addClass("ui-autocomplete-input").attr("autocomplete","off"),this._on(this.element,{keydown:function(e){if(this.element.prop("readOnly"))n=s=i=!0;else{n=s=i=!1;var t=a.ui.keyCode;switch(e.keyCode){case t.PAGE_UP:i=!0,this._move("previousPage",e);break;case t.PAGE_DOWN:i=!0,this._move("nextPage",e);break;case t.UP:i=!0,this._keyEvent("previous",e);break;case t.DOWN:i=!0,this._keyEvent("next",e);break;case t.ENTER:this.menu.active&&(i=!0,e.preventDefault(),this.menu.select(e));break;case t.TAB:this.menu.active&&this.menu.select(e);break;case t.ESCAPE:this.menu.element.is(":visible")&&(this.isMultiLine||this._value(this.term),this.close(e),e.preventDefault());break;default:n=!0,this._searchTimeout(e)}}},keypress:function(e){if(i)return i=!1,void(this.isMultiLine&&!this.menu.element.is(":visible")||e.preventDefault());if(!n){var t=a.ui.keyCode;switch(e.keyCode){case t.PAGE_UP:this._move("previousPage",e);break;case t.PAGE_DOWN:this._move("nextPage",e);break;case t.UP:this._keyEvent("previous",e);break;case t.DOWN:this._keyEvent("next",e)}}},input:function(e){if(s)return s=!1,void e.preventDefault();this._searchTimeout(e)},focus:function(){this.selectedItem=null,this.previous=this._value()},blur:function(e){this.cancelBlur?delete this.cancelBlur:(clearTimeout(this.searching),this.close(e),this._change(e))}}),this._initSource(),this.menu=a("<ul>").addClass("ui-autocomplete ui-front").appendTo(this._appendTo()).menu({role:null}).hide().menu("instance"),this._on(this.menu.element,{mousedown:function(e){e.preventDefault(),this.cancelBlur=!0,this._delay(function(){delete this.cancelBlur});var i=this.menu.element[0];a(e.target).closest(".ui-menu-item").length||this._delay(function(){var t=this;this.document.one("mousedown",function(e){e.target===t.element[0]||e.target===i||a.contains(i,e.target)||t.close()})})},menufocus:function(e,t){var i,n;if(this.isNewMenu&&(this.isNewMenu=!1,e.originalEvent&&/^mouse/.test(e.originalEvent.type)))return this.menu.blur(),void this.document.one("mousemove",function(){a(e.target).trigger(e.originalEvent)});n=t.item.data("ui-autocomplete-item"),!1!==this._trigger("focus",e,{item:n})&&e.originalEvent&&/^key/.test(e.originalEvent.type)&&this._value(n.value),(i=t.item.attr("aria-label")||n.value)&&a.trim(i).length&&(this.liveRegion.children().hide(),a("<div>").text(i).appendTo(this.liveRegion))},menuselect:function(e,t){var i=t.item.data("ui-autocomplete-item"),n=this.previous;this.element[0]!==this.document[0].activeElement&&(this.element.focus(),this.previous=n,this._delay(function(){this.previous=n,this.selectedItem=i})),!1!==this._trigger("select",e,{item:i})&&this._value(i.value),this.term=this._value(),this.close(e),this.selectedItem=i}}),this.liveRegion=a("<span>",{role:"status","aria-live":"assertive","aria-relevant":"additions"}).addClass("ui-helper-hidden-accessible").appendTo(this.document[0].body),this._on(this.window,{beforeunload:function(){this.element.removeAttr("autocomplete")}})},_destroy:function(){clearTimeout(this.searching),this.element.removeClass("ui-autocomplete-input").removeAttr("autocomplete"),this.menu.element.remove(),this.liveRegion.remove()},_setOption:function(e,t){this._super(e,t),"source"===e&&this._initSource(),"appendTo"===e&&this.menu.element.appendTo(this._appendTo()),"disabled"===e&&t&&this.xhr&&this.xhr.abort()},_appendTo:function(){var e=this.options.appendTo;return e&&(e=e.jquery||e.nodeType?a(e):this.document.find(e).eq(0)),e&&e[0]||(e=this.element.closest(".ui-front")),e.length||(e=this.document[0].body),e},_initSource:function(){var i,n,s=this;a.isArray(this.options.source)?(i=this.options.source,this.source=function(e,t){t(a.ui.autocomplete.filter(i,e.term))}):"string"==typeof this.options.source?(n=this.options.source,this.source=function(e,t){s.xhr&&s.xhr.abort(),s.xhr=a.ajax({url:n,data:e,dataType:"json",success:function(e){t(e)},error:function(){t([])}})}):this.source=this.options.source},_searchTimeout:function(n){clearTimeout(this.searching),this.searching=this._delay(function(){var e=this.term===this._value(),t=this.menu.element.is(":visible"),i=n.altKey||n.ctrlKey||n.metaKey||n.shiftKey;e&&(!e||t||i)||(this.selectedItem=null,this.search(null,n))},this.options.delay)},search:function(e,t){return e=null!=e?e:this._value(),this.term=this._value(),e.length<this.options.minLength?this.close(t):!1!==this._trigger("search",t)?this._search(e):void 0},_search:function(e){this.pending++,this.element.addClass("ui-autocomplete-loading"),this.cancelSearch=!1,this.source({term:e},this._response())},_response:function(){var t=++this.requestIndex;return a.proxy(function(e){t===this.requestIndex&&this.__response(e),this.pending--,this.pending||this.element.removeClass("ui-autocomplete-loading")},this)},__response:function(e){e&&(e=this._normalize(e)),this._trigger("response",null,{content:e}),!this.options.disabled&&e&&e.length&&!this.cancelSearch?(this._suggest(e),this._trigger("open")):this._close()},close:function(e){this.cancelSearch=!0,this._close(e)},_close:function(e){this.menu.element.is(":visible")&&(this.menu.element.hide(),this.menu.blur(),this.isNewMenu=!0,this._trigger("close",e))},_change:function(e){this.previous!==this._value()&&this._trigger("change",e,{item:this.selectedItem})},_normalize:function(e){return e.length&&e[0].label&&e[0].value?e:a.map(e,function(e){return"string"==typeof e?{label:e,value:e}:a.extend({},e,{label:e.label||e.value,value:e.value||e.label})})},_suggest:function(e){var t=this.menu.element.empty();this._renderMenu(t,e),this.isNewMenu=!0,this.menu.refresh(),t.show(),this._resizeMenu(),t.position(a.extend({of:this.element},this.options.position)),this.options.autoFocus&&this.menu.next()},_resizeMenu:function(){var e=this.menu.element;e.outerWidth(Math.max(e.width("").outerWidth()+1,this.element.outerWidth()))},_renderMenu:function(i,e){var n=this;a.each(e,function(e,t){n._renderItemData(i,t)})},_renderItemData:function(e,t){return this._renderItem(e,t).data("ui-autocomplete-item",t)},_renderItem:function(e,t){return a("<li>").text(t.label).appendTo(e)},_move:function(e,t){if(this.menu.element.is(
":visible"))return this.menu.isFirstItem()&&/^previous/.test(e)||this.menu.isLastItem()&&/^next/.test(e)?(this.isMultiLine||this._value(this.term),void this.menu.blur()):void this.menu[e](t);this.search(null,t)},widget:function(){return this.menu.element},_value:function(){return this.valueMethod.apply(this.element,arguments)},_keyEvent:function(e,t){this.isMultiLine&&!this.menu.element.is(":visible")||(this._move(e,t),t.preventDefault())}}),a.extend(a.ui.autocomplete,{escapeRegex:function(e){return e.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g,"\\$&")},filter:function(e,t){var i=new RegExp(a.ui.autocomplete.escapeRegex(t),"i");return a.grep(e,function(e){return i.test(e.label||e.value||e)})}}),a.widget("ui.autocomplete",a.ui.autocomplete,{options:{messages:{noResults:"No search results.",results:function(e){return e+(1<e?" results are":" result is")+" available, use up and down arrow keys to navigate."}}},__response:function(e){var t;this._superApply(arguments),this.options.disabled||this.cancelSearch||(t=e&&e.length?this.options.messages.results(e.length):this.options.messages.noResults,this.liveRegion.children().hide(),a("<div>").text(t).appendTo(this.liveRegion))}}),a.ui.autocomplete}),$(document).ready(function(){$("#more_options").hide(),$('nav#actions.multilist > ul:not(.search_list) li a[href$="'+window.location.pathname+'"]').parent().addClass("selected"),0==$("nav#actions.multilist > ul:not(.search_list) li.selected").length&&$("nav#actions.multilist > ul:not(.search_list) li a:nth(1)").parent().addClass("selected"),$("nav#actions.multilist > ul:not(.search_list) li > a").each(function(){null==$(this).data("dialog-title")&&$(this).bind("click",function(){$(this).css("background-image","url('/images/refinery/icons/ajax-loader.gif') !important")})}),$("ul.collapsible_menu").each(function(){(first_li=$(this).children("li:first")).after(div=$("<div></div>")),$("<span class='arrow'>&nbsp;</span>").appendTo(first_li),0==$(this).children("li.selected").length&&(div.hide(),first_li.addClass("closed")),$(this).children("li:not(:first)").appendTo(div),first_li.find("> a, > span.arrow").click(function(e){$(this).parent().toggleClass("closed"),$(this).parent().toggleClass("open"),$(this).parent().next("div").animate({opacity:"toggle",height:"toggle"},250,$.proxy(function(){$(this).css("background-image",null)},$(this))),e.preventDefault()})}),$(".success_icon, .failure_icon").bind("click",function(e){$.get($(this).attr("href"),$.proxy(function(e){$(this).css("background-image",null).removeClass("failure_icon").removeClass("success_icon").addClass(e.enabled?"success_icon":"failure_icon")},$(this))),e.preventDefault()}),$("#page-tabs").tabs(),$("#copy_body_link").click(function(e){var i=$("#post_custom_teaser")[0],n=null;$.each(WYMeditor.INSTANCES,function(e,t){t._element[0]==i&&(n=t)}),n&&n.html($("#post_body").val()),e.preventDefault()}),page_options.init(!1,"","")});