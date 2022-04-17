function sortTable(e,t,r){var s,o;for(sortTable.sortCol=-1,null!=(s=e.className.match(/js-sort-\d+/))&&(sortTable.sortCol=s[0].replace(/js-sort-/,""),e.className=e.className.replace(new RegExp(" ?"+s[0]+"\\b"),"")),void 0===t&&(t=sortTable.sortCol),void 0!==r?sortTable.sortDir=-1==r||"desc"==r?-1:1:null!=(s=e.className.match(/js-sort-(a|de)sc/))&&sortTable.sortCol==t?sortTable.sortDir="js-sort-asc"==s[0]?-1:1:sortTable.sortDir=1,e.className=e.className.replace(/ ?js-sort-(a|de)sc/g,""),e.className+=" js-sort-"+t,sortTable.sortCol=t,e.className+=" js-sort-"+(-1==sortTable.sortDir?"desc":"asc"),t<e.tHead.rows[e.tHead.rows.length-1].cells.length&&(s=e.tHead.rows[e.tHead.rows.length-1].cells[t].className.match(/js-sort-[-\w]+/)),o=0;o<e.tHead.rows[e.tHead.rows.length-1].cells.length;o++)t==e.tHead.rows[e.tHead.rows.length-1].cells[o].getAttribute("data-js-sort-colNum")&&(s=e.tHead.rows[e.tHead.rows.length-1].cells[o].className.match(/js-sort-[-\w]+/));sortTable.sortFunc=null!=s?s[0].replace(/js-sort-/,""):"string",e.querySelectorAll(".js-sort-active").forEach(function(e){e.className=e.className.replace(/ ?js-sort-active\b/,"")}),e.querySelectorAll('[data-js-sort-colNum="'+t+'"]:not(:empty)').forEach(function(e){e.className+=" js-sort-active"});var a=[],l=e.tBodies[0];for(o=0;o<l.rows.length;o++)a[o]=l.rows[o];for("none"!=sortTable.sortFunc&&a.sort(sortTable.compareRow);l.firstChild;)l.removeChild(l.firstChild);for(o=0;o<a.length;o++)l.appendChild(a[o])}sortTable.compareRow=function(e,t){var r,s;return"function"!=typeof sortTable[sortTable.sortFunc]&&(sortTable.sortFunc="string"),(r=sortTable[sortTable.sortFunc](e.cells[sortTable.sortCol]))==(s=sortTable[sortTable.sortFunc](t.cells[sortTable.sortCol]))?0:sortTable.sortDir*(s<r?1:-1)},sortTable.stripTags=function(e){return e.replace(/<\/?[a-z][a-z0-9]*\b[^>]*>/gi,"")},sortTable.date=function(e){if("undefined"==typeof okDate)return new Date(sortTable.stripTags(e.innerHTML)).getTime()||0;var t=okDate(sortTable.stripTags(e.innerHTML));return t?t.getTime():0},sortTable.number=function(e){return Number(sortTable.stripTags(e.innerHTML).replace(/[^-\d.]/g,""))},sortTable.string=function(e){return null!=e?sortTable.stripTags(e.innerHTML).toLowerCase():""},sortTable.raw=function(e){return e.innerHTML},sortTable.last=function(e){return sortTable.stripTags(e.innerHTML).split(" ").pop().toLowerCase()},sortTable.input=function(e){for(var t=0;t<e.children.length;t++)if("object"==typeof e.children[t]&&"undefined"!=typeof e.children[t].value)return e.children[t].value.toLowerCase();return sortTable.string(e)},sortTable.none=function(){return null},sortTable.getClickHandler=function(e,t){return function(){sortTable(e,t)}},sortTable.init=function(){var e,t,r;t=document.querySelectorAll?document.querySelectorAll("table.js-sort-table"):document.getElementsByTagName("table");for(var s=0;s<t.length;s++)if((document.querySelectorAll||null!==t[s].className.match(/\bjs-sort-table\b/))&&!t[s].attributes["data-js-sort-table"]){t[s].tHead?e=t[s].tHead:((e=document.createElement("thead")).appendChild(t[s].rows[0]),t[s].insertBefore(e,t[s].children[0]));for(var o=0;o<e.rows.length;o++)for(var a=0,l=0;a<e.rows[o].cells.length;a++)e.rows[o].cells[a].className.match(/\bjs-sort-none\b/)||(e.rows[o].cells[a].setAttribute("data-js-sort-colNum",l),r=sortTable.getClickHandler(t[s],l),window.addEventListener?e.rows[o].cells[a].addEventListener("click",r):window.attachEvent&&e.rows[o].cells[a].attachEvent("onclick",r)),l+=e.rows[o].cells[a].colSpan;t[s].setAttribute("data-js-sort-table","true")}var n=document.createElement("style");document.head.insertBefore(n,document.head.childNodes[0]);var c=n.sheet;c.insertRule('table.js-sort-table.js-sort-asc thead tr > .js-sort-active:not(.js-sort-none):after {content: "\\25b2";font-size: 0.7em;padding-left: 3px;line-height: 0.7em;}',0),c.insertRule('table.js-sort-table.js-sort-desc thead tr > .js-sort-active:not(.js-sort-none):after {content: "\\25bc";font-size: 0.7em;padding-left: 3px;line-height: 0.7em;}',0)},window.addEventListener?window.addEventListener("load",sortTable.init,!1):window.attachEvent&&window.attachEvent("onload",sortTable.init),"function"!=typeof NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach);