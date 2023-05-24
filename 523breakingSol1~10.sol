

//더하기, 빼기, 곱하기, 나누기 그리고 제곱을 반환받는 계산기를 만드세요
    contract Q1 {
    function add (uint _a, uint _b) public pure returns(uint) {
        return _a + _b;
    }
    function sub (uint _a, uint _b) public pure returns(uint) {
        return _a - _b;
    }
    function div (uint _a, uint _b) public pure returns(uint) {
        return _a / _b;
    }
    function mul (uint _a) public pure returns(uint) {
        return _a ** 2;
    }
}

// 1개의 Input값을 가지고 1개의 output값을 가지는 2개의 함수를 만드시오.
     //각각의 함수는 제곱, 세제곱을 반환합니다.

contract Q2 {
    function sqr(uint _n) public pure returns(uint) {
         return _n ** 2;
    }

    function tre(uint _n) public pure returns(uint) {
        return _n ** 3;
    }
 }
 

//  이름(string), 번호(uint), 듣는 수업 목록(string[])을 담은 student라는 구조체를 만들고 
//  그 구조체들을 관리할 수 있는 array, students를 선언하세요.

contract Q3 {
    struct student {
        string name;
        uint number;
        string[] classes; 
    }

    student[] students;
} 

/* */ /* */ /* */ /* */ /* */ /* */ /* */ /* */ /* */
 
// 1. 아래의 함수를 만드세요
    
//     1~3을 입력하면 입력한 수의 제곱을 반환받습니다.
    
//     4~6을 입력하면 입력한 수의 2배를 반환받습니다.
    
//     7~9를 입력하면 입력한 수를 3으로 나눈 나머지를 반환받습니다.
contract Q5 {
    function getNumber( uint _n ) public pure returns( uint ) {
        if( 1 <= _n && _n <= 3 ) {
            return _n ** 2;
        }else if( 4 <= _n  && _n <= 6) {
            return _n * 2;
        }else if( 7 <= _n && _n <= 9) {
            return _n % 3;
        }else {
            "Out of range"; //require 응용해도된다함
        }
    }
}

// 숫자만 들어갈 수 있는 array numbers를 만들고 
// 그 array안에 0부터 9까지 자동으로 채우는 함수를 구현하세요.(for 문)

contract Q6 {
    
    uint[] numbers;

    function pushNumber() public { //재료 펼친다음 넣어주기
        for( uint i = 0 ; i <= 9 ; i++ ) {
            numbers.push(i);
        }    
    }

    function getNumber() public view returns( uint[] memory ) {
        return numbers;
    }
}

// 숫자만 들어갈 수 있는 array numbers를 만들고 그 array안에 0부터 5까지 자동으로 
// 채우는 함수와 array안의 모든 숫자를 더한 값을 반환하는 함수를 각각 구현하세요.(for 문)

contract Q7 {
    uint[] numbers;

    function pushNumber() public  {
        for( uint i = 0 ; i <= 5 ; i ++ ) {
            numbers.push( i ) ;
        }
    }

    function addNumberInArr() public view returns( uint ) {
        uint _sum ;
        for( uint i = 0 ; i < numbers.length ; i ++ ) {
            _sum += numbers[ i ] ; // _sum = _sum + numbers[i]; 값을 넣어줌 (숫자)
        }

        return _sum ;

    }
}

// 1~10을 입력하면 “A” 반환받습니다.

// 11~20을 입력하면 “B” 반환받습니다.

// 21~30을 입력하면 “C” 반환받습니다.

contract Q8 {
    function returnA( uint _n ) public pure returns( string memory ) {
        if( 1 <= _n && _n <= 10) {
            return "A" ;
        } else if( 11 <= _n && _n <= 20 ) {
            return "B" ;
        } else if( 21 <= _n && _n <= 30 ) {
            return "C" ;
        } else {
            "Out of range" ; //reqire 응용해도 된대
        }
    }
}

//문자형을 입력하면 bytes 형으로 변환하여 반환하는 함수를 구현하세요.

contract Q9 {
    function stringToBytes( string memory _word ) public pure returns( bytes memory ) {
        return bytes( _word ) ;
    }

    function bytesToString( bytes memory _bytes ) public pure returns( string memory ) {
        return string( _bytes ) ;
    }
}

// 숫자만 들어가는 array numbers를 선언하고 
// 숫자를 넣고(push), 빼고(pop), 특정 n번째 요소의 값을 볼 수 있는(get)함수를 구현하세요.

contract Q10 {
    uint[] numbers ;

    function push( uint _n ) public {
        numbers.push( _n ) ;
    }

    function getNumber() public view returns( uint[] memory ) {
        return numbers ;
    }

    function returnArr( uint _n ) public view returns( uint ) {
        return numbers[ _n ] ;
    }

    

}








    