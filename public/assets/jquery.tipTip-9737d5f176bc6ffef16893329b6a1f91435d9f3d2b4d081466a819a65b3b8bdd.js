/*
 * TipTip
 * Copyright 2010 Drew Wilson
 * www.drewwilson.com
 * code.drewwilson.com/entry/tiptip-jquery-plugin
 *
 * Version 1.3   -   Updated: Mar. 23, 2010
 *
 * This Plug-In will create a custom tooltip to replace the default
 * browser tooltip. It is extremely lightweight and very smart in
 * that it detects the edges of the browser window and will make sure
 * the tooltip stays within the current window size. As a result the
 * tooltip will adjust itself to be displayed above, below, to the left 
 * or to the right depending on what is necessary to stay within the
 * browser window. It is completely customizable as well via CSS.
 *
 * This TipTip jQuery plug-in is dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
!function(t){t.fn.tipTip=function(e){var o={activation:"hover",keepAlive:!1,maxWidth:"200px",edgeOffset:3,defaultPosition:"bottom",delay:400,fadeIn:200,fadeOut:200,attribute:"title",content:!1,enter:function(){},exit:function(){}},i=t.extend(o,e);if(t("#tiptip_holder").length<=0){var n=t('<div id="tiptip_holder" style="max-width:'+i.maxWidth+';"></div>'),r=t('<div id="tiptip_content"></div>'),a=t('<div id="tiptip_arrow"></div>');t("body").append(n.html(r).prepend(a.html('<div id="tiptip_arrow_inner"></div>')))}else n=t("#tiptip_holder"),r=t("#tiptip_content"),a=t("#tiptip_arrow");return this.each(function(){var e=t(this);if(i.content)var o=i.content;else o=e.attr(i.attribute);if(""!=o){i.content||e.removeAttr(i.attribute);var f=!1;function d(){i.enter.call(this),r.html(o),n.hide().removeAttr("class").css("margin","0"),a.removeAttr("style");var d=parseInt(e.offset().top),u=parseInt(e.offset().left),p=parseInt(e.outerWidth()),l=parseInt(e.outerHeight()),h=n.outerWidth(),c=n.outerHeight(),s=Math.round((p-h)/2),_=Math.round((l-c)/2),v=Math.round(u+s),m=Math.round(d+l+i.edgeOffset),g="",b="",M=Math.round(h-12)/2;"bottom"==i.defaultPosition?g="_bottom":"top"==i.defaultPosition?g="_top":"left"==i.defaultPosition?g="_left":"right"==i.defaultPosition&&(g="_right");var w=s+u<parseInt(t(window).scrollLeft()),O=h+u>parseInt(t(window).width());w&&s<0||"_right"==g&&!O||"_left"==g&&u<h+i.edgeOffset+5?(g="_right",b=Math.round(c-13)/2,M=-12,v=Math.round(u+p+i.edgeOffset),m=Math.round(d+_)):(O&&s<0||"_left"==g&&!w)&&(g="_left",b=Math.round(c-13)/2,M=Math.round(h),v=Math.round(u-(h+i.edgeOffset+5)),m=Math.round(d+_));var x=d+l+i.edgeOffset+c+8>parseInt(t(window).height()+t(window).scrollTop()),I=d+l-(i.edgeOffset+c+8)<0;x||"_bottom"==g&&x||"_top"==g&&!I?("_top"==g||"_bottom"==g?g="_top":g+="_top",b=c,m=Math.round(d-(c+5+i.edgeOffset))):(I|("_top"==g&&I)||"_bottom"==g&&!x)&&("_top"==g||"_bottom"==g?g="_bottom":g+="_bottom",b=-12,m=Math.round(d+l+i.edgeOffset)),"_right_top"==g||"_left_top"==g?m+=5:"_right_bottom"!=g&&"_left_bottom"!=g||(m-=5),"_left_top"!=g&&"_left_bottom"!=g||(v+=5),a.css({"margin-left":M+"px","margin-top":b+"px"}),n.css({"margin-left":v+"px","margin-top":m+"px"}).attr("class","tip"+g),f&&clearTimeout(f),f=setTimeout(function(){n.stop(!0,!0).fadeIn(i.fadeIn)},i.delay)}function u(){i.exit.call(this),f&&clearTimeout(f),n.fadeOut(i.fadeOut)}"hover"==i.activation?(e.hover(function(){d()},function(){i.keepAlive||u()}),i.keepAlive&&n.hover(function(){},function(){u()})):"focus"==i.activation?e.focus(function(){d()}).blur(function(){u()}):"click"==i.activation&&(e.click(function(){return d(),!1}).hover(function(){},function(){i.keepAlive||u()}),i.keepAlive&&n.hover(function(){},function(){u()}))}})}}(jQuery);