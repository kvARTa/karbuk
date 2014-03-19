/* "Style First Word Script" by http://www.dynamicsitesolutions.com/
Using both functions, this works in Firefox, Netscape 6+, Opera 7+, IE4+/Win, 
Safari, and IE5/Mac.
*/
function firstwordselect(tagname, selectclassname, classname){

var firstWordClassName = selectclassname;

// for IE4 support
if(document.all && !document.getElementsByTagName && document.all.tags) {
  document.getElementsByTagName = function(elType) {
    return document.all.tags(elType)
  }
}
/*
styleFirstWord2() is for IE4 compatibility.
*/
function styleFirstWord2() {
  if(!document.getElementsByTagName||!document.body||!document.body.innerHTML)
    return;
  var str,str2='',str3,idx,idx2,idx3,k=0;
  var paras = document.getElementsByTagName(tagname);
  for(var i=0;i<paras.length;i++) {
    if(firstWordClassName != '')
      if(paras[i].className.indexOf(firstWordClassName) == -1) continue;
    str2 = '';
    k=0;
    str = paras[i].innerHTML;
    idx = str.indexOf(' ');
    idx2 = str.indexOf('<');
    while(idx>idx2) {
      idx3 = str.indexOf('>');
      if(idx3>idx2 && idx3>idx) {
        str2 += str.substring(0,idx3+1);
        str = str.substring(idx3+1,str.length);
        idx = str.indexOf(' ');
        idx2 = str.indexOf('<');
      } else { break; }
    }
    while(str.charAt(k).match(/\s/)) { k++; }
    idx = k+str.replace(/^\s+/,'').indexOf(' ');
    if(idx<1) idx=str.length;
    str3='<span class="'+classname+'">'+str.substring(k,idx)+'<\/span>';
    paras[i].innerHTML = str2+str3+str.substring(idx,str.length);
  }
}

/* styleFirstWord() works in Firefox, Netscape 6+, Opera 7+, and IE5+ */
function styleFirstWord() {
  if(!document.getElementsByTagName || !document.getElementsByTagName('body') ||
    !document.createElement || 
    !document.getElementsByTagName('body')[0].childNodes) {
      styleFirstWord2(); //for IE4
      return;
    }
  var el,pel,str,str2,idx,j,k,m,r=/^\s+$/;
  var paras = document.getElementsByTagName(tagname);
  for(var i=0;i<paras.length;i++) {
    if(!paras[i].hasChildNodes()) continue;
    if(firstWordClassName != '')
      if(paras[i].className.indexOf(firstWordClassName) == -1) continue;
    if(paras[i].normalize) paras[i].normalize();
    pel = paras[i].childNodes[0];
    j=0;
    m=(pel.nodeType != 3)?1:(pel.nodeValue.match(r)?1:0);
    while(m) {
      if(!pel.hasChildNodes()) {
        if(pel.nextSibling) pel = pel.nextSibling;
      } else if(pel.nodeType == 1) {
        pel = pel.childNodes[0];
      }
      j++;
      m=(pel.nodeType!=3)?1:(pel.nodeValue===null)?1:pel.nodeValue.match(r)?1:0;
      m=(j<16)?m:0;
    }
    str = pel.data;
    if(!str.length) continue;
    k=0;
    while(str.charAt(k).match(/\s/)) { k++; }
    idx = str.replace(/^\s+/,'').indexOf(' ');
    if(idx==-1) idx=0;
    if(idx > 0) {
      idx+=k;
      pel.data = str.substring(idx,str.length);
      str = str.substring(0,idx);
    } else {
      pel.data = '';
    }
    el = document.createElement('span');
    pel.parentNode.insertBefore(el,pel);
    el.className=classname;
    str2 = document.createTextNode(str);
    el.appendChild(str2);
    if(pel.data == '') pel.parentNode.removeChild(pel);
  }
}
var tempFunc;
if(typeof window.onload == "function") { tempFunc = window.onload; }
window.onload = function() {
  if(typeof tempFunc == "function") tempFunc();
  styleFirstWord();
}
}