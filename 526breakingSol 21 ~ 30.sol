//3의 배수만 들어갈 수 있는 array를 구현하세요.

contract Q21 {

    uint[] numbers;

    function only3( uint _n ) public {
        if( _n % 3 == 0 ) 
        
        numbers.push( _n ) ;
    }

    function get() public view returns( uint[] memory ) {
        return numbers;
    }
}

// 1. 뺄셈 함수를 구현하세요. 
// 임의의 두 숫자를 넣으면 자동으로 둘 중 큰수로부터 작은 수를 빼는 함수를 구현하세요.
    
//     예) 2,5 input → 5-2=3(output)

contract Q22 {

    function sub( uint _n , uint _n1 ) public pure returns( uint ) {
        if( _n > _n1 ) {
            return _n - _n1 ;
        } else {
            return _n1 - _n;
        }
    }
}