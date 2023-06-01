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

contract Q24 {
    function StrinToBool( string memory _text ) public pure returns( bool ) {
        if( keccak256(bytes( _text )) == keccak256(bytes( "Alice" ))) {
            return true ;
        }
    }
}//


contract Q24_1 {
    string[] names;

    function StringToBool( string memory _name ) public returns( bool ) {
        names.push(_name);
        return keccak256(abi.encodePacked( _name )) == keccak256(abi.encodePacked("Alice"));
    }
}


contract Q24_2 {    
	string[] names;

	function trueOnlyForAlice(string memory _name) public returns(bool) {
		return keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Alice"));
        names.push(_name);
	}
}

contract Q24_3 {
    string[] names;

    function trueOnlyForAlice(string memory _name) public returns(bool) {
        if (keccak256(abi.encodePacked(_name)) != keccak256(abi.encodePacked("Alice"))) {
            return false;
        }
        names.push(_name);
        return true;
    }

    function get() public view returns( string[] memory ) {
        return names;
    }
}


// 배열 A를 선언하고 해당 배열에 n부터 0까지 자동으로 넣는 함수를 구현하세요. 
contract Q25 {
    uint[] A;

    function pushNum( uint _n ) public {
        for( uint i = _n ; 0 < i ; i-- ) {
             A.push( i ) ;
        }
    }

    function get() public view returns( uint[] memory ) {
        return A;
    }

    function pushNumbers( uint n ) public {
        while( n > 0 ) {
            A.push( n ) ;
            n-- ;
        }   A.push( n );
    }
}

// 홀수만 들어가는 array, 짝수만 들어가는 array를 
// 구현하고 숫자를 넣었을 때 자동으로 홀,짝을 나누어 입력시키는 함수를 구현하세요.

contract Q26 {
    uint[] odds;
    uint[] evens;

    function pushOdds( uint _odd ) public  {
        if( _odd % 2 == 1 ) {
        odds.push(_odd) ;
        }
    } //실행버튼이 작동하지만 값은 출력이 안됨 /require는 작동조차 안됨

    function pushEvens( uint _evens ) public {
        require( _evens % 2 == 0 ) ;
        evens.push( _evens ) ;
    }

    function get() public view returns( uint[] memory ) {
        return odds;
    }
}

contract Q26_1 {
	uint[] odds;
	uint[] evens;

	function pushOdds(uint _n) public {
		require(_n%2==1);
		odds.push(_n);
	}

	function pushEvens(uint _n) public {
		require(_n%2==0);
		evens.push(_n);
	}

    function get() public view returns( uint[] memory ) {
        return odds;
    }
}

// string 과 bytes32를 key-value 쌍으로 묶어주는 mapping을 구현하세요. 
// 해당 mapping에 정보를 넣고, 지우고 불러오는 함수도 같이 구현하세요.    //하나의 키 안에 키 값 다 저장하는 맵함수 배열로 키를 저장해야함

contract Q27 {
    mapping( string => bytes32 ) stringToByte32 ;

    function pushSB( string memory _text ) public {
        stringToByte32[ _text ] = keccak256(abi.encodePacked(_text)) ;
    }

    function get( string memory _text ) public view returns( bytes32 ) {
        return stringToByte32[_text];
    }
}

//ID와 PW를 넣으면 해시함수(keccak256)에 둘을 같이 해시값을 반환해주는 함수를 구현하세요.

contract Q28 {

    
    function IDPW( string memory _ID , string memory _PW ) public pure returns( bytes32 ){
        return keccak256(abi.encodePacked(_ID,_PW)) ;
    }
    //0x71fb09a7e9dc4fd2a85797bc92080d49ead60ebaa2b562d817bdfb31bc258134

}

//숫자형 변수 a와 문자형 변수 b를 각각 10
// 그리고 “A”의 값으로 배포 직후 설정하는 contract를 구현하세요.
contract Q29 {
    uint a ;
    string b ;
    constructor( uint _a , string memory _b ) {
        a = _a ;
        b = _b ;
    }
}

// 1. 임의대로 숫자를 넣으면 알아서 내림차순으로 정렬해주는 함수를 구현하세요
// (sorting 코드 응용 → 약간 까다로움)
    
//     예 : [2,6,7,4,5,1,9] → [9,7,6,5,4,2,1]

contract Q30 {
	function sorting(uint[] memory numbers) public pure returns(uint[] memory) {
        for(uint i=0;i<numbers.length;i++) {         
            for(uint j=i+1; j<numbers.length ;j++) {     
                if(numbers[i] < numbers[j]) {
                    (numbers[i], numbers[j]) = (numbers[j], numbers[i]);
                }
            }
        } 
        return numbers;
    }
    
}



