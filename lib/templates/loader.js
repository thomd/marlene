(function(){
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = '{{script}}?' + (new Date().getTime());
    document.getElementsByTagName('body')[0].appendChild(script);
})()
