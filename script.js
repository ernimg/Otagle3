
( () => {
    let ini2Obj = {};
    const keyValuePair = kvStr => {
    	const kvPair = kvStr.split('=').map( val => val.trim() );
        return { key: kvPair[0], value: kvPair[1] };
    };
    const result = document.querySelector("#results");
    document.getElementById( 'inifile' ).textContent
    	.split( /\n/ )                                      
        .map( line => line.replace( /^\s+|\r/g, "" ) )    
        .forEach( line =>  {                              
            line = line.trim();
            if ( line.startsWith('#') || line.startsWith(';') ) { return false; }
            if ( line.length ) {
              if ( /^\[/.test(line) ) {
                this.currentKey = line.replace(/\[|\]/g,'');
                ini2Obj[this.currentKey] = {};
              } else if ( this.currentKey.length ) {
                const kvPair = keyValuePair(line);
                ini2Obj[this.currentKey][kvPair.key] = kvPair.value;
              }
            } 
          }, {currentKey: ''} );
    
        console.log(`${JSON.stringify(ini2Obj, null, ' ')};`)
    
    // result.textContent +=`${JSON.stringify(ini2Obj, null, ' ')};` 
})();