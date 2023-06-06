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

// 1. 은행의 역할을 하는 contract를 만드려고 합니다. 
// 별도의 고객 등록 과정은 없습니다.
//  해당 contract에 ether를 예치할 수 있는 기능을 만드세요.
//   또한, 자신이 현재 얼마를 예치했는지도 볼 수 있는 함수 
//   그리고 자신이 예치한만큼의 ether를 인출할 수 있는 기능을 구현하세요.
    
//     힌트 : mapping을 꼭 이용하세요.

contract Q43 {

    mapping( address => uint ) balance ;

    // function deposit( uint _amount ) public {
    //     require( _amount[ msg.sender ] >= 0 ) ;
    // 내가 이렇게 작성한 이유는  그 금액은 누른사람이 들고 있어야하는 금액이라 이렇게적음
    // 생각을 고침 여기 넣은 사람은 당연히 값을 넣는 특정인 일테고 (_amount <- 값이 바로들어감)
    // 잔고는 특전 누구를 가리켜야 하는 대상 즉 키이기에 확실히 해줘야하므로 메센을 붙인다.
    //     balance += balance[_amount] ;
    // }

    function de() public payable {}

    function deposit( uint _amount ) public {
        require( _amount > 0 ) ;
        balance[msg.sender] += _amount ;
    }

    function checkBalance() public view returns( uint ) {
        return balance[ msg.sender ] ;
    }

    function withdraw( uint _amount ) public {
        require( balance[ msg.sender ] > 0 , "You dont have enough balance." ) ;
        balance[ msg.sender ] = balance[ msg.sender ] - _amount ;
        // balance[ msg.sender ] -= _amount ;
        
    }

    //종이에 글 적음 참고하길...
}

// string만 들어가는 array를 만들되, 
// 4글자 이상인 문자열만 들어갈 수 있게 구현하세요.

contract Q44 {
    string[] OnlyString ;

    function onlyString4Letter( string memory _string ) public {
        require( bytes( _string ).length >=  4 ) ;
        OnlyString.push( _string ) ;
    }
}

//1. 숫자만 들어가는 array를 만들되, 100이하의 숫자만 들어갈 수 있게 구현하세요.

contract Q45 {
    uint[] OnlyNumber ;
    function onlyNumberNumber100( uint _number ) public {
        require( _number <= 100 ) ;
        OnlyNumber.push( _number ) ;
    } 
}

// 1. 3의 배수이거나 10의 배수이면서 50보다 작은 수만 들어갈 수 있는 array를 구현하세요.
    


contract Q46 {

    uint[] public vaildNumbers ;

    function Num( uint _number ) public {
        if( (_number % 3 == 0 || _number % 10 == 0) && _number  < 50 ) {
            return vaildNumbers.push(_number) ; 
            //if문은 답이 아니면 0을 집어넣음 그러니깐 계약이 성립됨
        }
    }


    function pushNumbers(uint _a) public {
        require(_a%3==0 || _a%10==0 && _a<50);
        vaildNumbers.push(_a);
    }


}

