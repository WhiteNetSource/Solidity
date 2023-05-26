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
    function sub( uint _a , uint _b ) public pure returns( uint ) {
        if( _a > _b ) {
            return _a - _b ; 
        } else {
            return _b - _a ;
        }
    }
}

// 3의 배수라면 “A”를, 
// 나머지가 1이 있다면 “B”를,
//  나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.

contract Q23 {
    function returnStrings( uint _n ) public pure returns( string memory ) {
        if( 3 % _n == 0 ) {
            return "A" ;
        } else if( 3 % _n == 1 ) {
            return "B" ;
        } else {
            return "C" ;
        }
    }
}

// string을 input으로 받는 함수를 구현하세요.
//  “Alice”가 들어왔을 때에만 true를 반환하세요.

