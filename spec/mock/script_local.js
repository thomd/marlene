// a contains method for arrays
Array.prototype.contains = function(item){
    return this.indexOf(item) > -1;
}

alert([1,2,3,4,5].contains(4));
