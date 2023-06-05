// 숫자만 들어갈 수 있으며 길이가 4인 배열을 (상태변수로)선언하고
//  그 배열에 숫자를 넣는 함수를 구현하세요. 
//  배열을 초기화하는 함수도 구현하세요. 
//  (길이가 4가 되면 자동으로 초기화하는 기능은 굳이 구현하지 않아도 됩니다.)

contract Q41 {
    uint[4] numbers;

    function setNum( uint[4] memory _n ) public {
        numbers = _n ;
    }

    function reset() public {
        //numbers = [0,0,0] ;
        delete numbers ;
    }
}


contract Q41_1 {
    uint[4] public a ;
    uint  public count  ;

    function pushA( uint _a ) public {
        a[ count++ ] = _a ;
    } // a의 몇번째에 넣어달하는겨 count++ 자동으로 카운트 되면서 1234 넣어줌

}

contract Q41_2 {
    uint[ 4 ] public a ;

    function pushA( uint _slot , uint _number ) public {
        a[ _slot-1 ] = _number ;
    }

}

// 이름과 번호 그리고 지갑주소를 가진 '고객'이라는 구조체를 선언하세요.
// 새로운 고객 정보를 만들 수 있는 함수도 구현하되
// 이름의 글자가 최소 5글자가 되게 설정하세요.

contract Q42 {

    struct User {
        string name ;
        uint number ;
        address addr ;
    }

    User[] users ;

    function createUser1( string memory _name , uint _number , address _addr ) public {
        bytes memory name = bytes(_name) ;
        if(  name.length >= 5  ) {
            users.push( User( _name , _number , _addr ) ) ;
        }
    }

    function createUser( string memory _name , uint _number , address _addr ) public { 
        require( bytes( _name ).length >= 5 , "hho" ) ;
            users.push( User( _name , _number , _addr ) ) ;    
    } 


      function createUser2( string memory _name , uint _number , address _addr ) public {     
        if(  bytes(_name).length >= 5  ) {
            users.push( User( _name , _number , _addr ) ) ;
        }
    }

    function getUser() public view returns( User[] memory ) {
        return users ;
    }

    modifier lengthCheck( string memory _name ) {
        require( bytes( _name ).length >= 5 ) ;
        _ ;
    }
    function setUser( string calldata _name , uint _number ) public lengthCheck( _name ) {
        users.push( User( _name , _number , msg.sender )) ;
    }

    function reset() public {
        delete users;
    }

}




