 //1. 숫자들이 들어가는 배열을 선언하고 그 중에서 3번째로 큰 수를 반환하세요.
contract Q51 {

    uint[] numbers = [1,6,9,4,10,7,5] ;
                        //1 4 5 6 7 9 10
    function pushNumber() public view returns( uint ) {
        return numbers[2] ; //0,1,2 / 칸의 배열의 숫자를 반환한다.
    }

    function sorting() public {
        for( uint i = 0 ; i < numbers.length  ; i ++ ) { //rw잡고 비교해서 넣어주는거임
            for( uint j = i + 1 ; j < numbers.length  ; j ++ ) {
                if( numbers[ i ] < numbers[ j ] ) {
                    ( numbers[ i ] , numbers[ j ] ) =( numbers[ j ] , numbers[ i ] ) ;
                }
            }
        }
    }

}

// 자동으로 아이디를 만들어주는 함수를 구현하세요.
// 이름, 생일, 지갑주소를 기반으로 만든 
// 해시값의 첫 10바이트를 추출하여 아이디로 만드시오.
contract Q52 {
    struct ID{
        string name ;
        uint birthday ;
        address addr ;
        bytes10 id ;
    }

    ID i ;

    function setID( string calldata _name , uint _birth ) public {
        ( i.name , i.birthday , i.addr ) = ( _name , _birth, msg.sender ) ;
        i.id = bytes10(keccak256(abi.encodePacked( _name , _birth , msg.sender ))) ;
    }

    function getID() public view returns( bytes10 ) {
        return i.id ;
    }

 }

//  1. 시중에는 A,B,C,D,E 5개의 은행이 있습니다. 
//  각 은행에 고객들은 마음대로 입금하고 인출할 수 있습니다. 
//  각 은행에 예치된 금액 확인, 입금과 인출할 수 있는 기능을 구현하세요.
    
//     힌트 : 이중 mapping을 꼭 이용하세요.

contract Q53 {
    mapping( string => mapping( address => uint )) balances ;
    
    function deposit( string memory _bank , uint _balance ) public {
        balances[ _bank ][ msg.sender ] = _balance ; 
    }

    function check( string memory _bank ) public view returns( uint ) {
        return balances[ _bank ][ msg.sender ] ;
    }

    function withdraw( string memory _bank , uint _balances ) public {
        balances[ _bank ][ msg.sender ] -= _balances ;
    }
}

// 1. 기부받는 플랫폼을 만드세요. 
// 가장 많이 기부하는 사람을 나타내는 변수와
//  그 변수를 지속적으로 바꿔주는 함수를 만드세요.
    
//     힌트 : 굳이 mapping을 만들 필요는 없습니다.

contract Q54 {
    address honerable_doner ; // 기부자의 주소를 저장하는 변수
    uint donated_amount ;  // 기부된 금액을 저장하는 변수

    function donation() public payable {
        if( msg.value > donated_amount ) {
            donated_amount = msg.value ;  // 기부된 금액 업데이트
            honerable_doner = msg.sender ;  // 기부자 주소 업데이트
        }
    }

}

// 배포와 함께 owner를 설정하고 owner를 
// 다른 주소로 바꾸는 것은 오직 owner 스스로만 할 수 있게 하십시오.

contract Q55 {
    address owner;    // 소유자(owner)의 주소를 저장하는 변수

    constructor() {
        owner = msg.sender;    // 배포 시 소유자(owner) 설정
    }

    // 소유자 변경 함수 - 오직 소유자(owner) 스스로만 다른 주소로 변경할 수 있도록 제한
    function ownerChange(address _newOwner) public {
        require(msg.sender == owner, "Only the owner can change the owner address");    // 호출자가 소유자(owner)인지 확인
        owner = _newOwner;    // 소유자(owner) 변경
    }
}

//위 문제의 확장버전입니다. owner와 sub_owner를 설정하고 owner를 바꾸기 위해서는 둘의 동의가 모두 필요하게 구현하세요.

contract Q56 {

    address owner ;
    address sub_owner ;

    constructor( address _sub ) {
        owner = msg.sender ;
        sub_owner = _sub;
    }

    uint[2] agreed ;

     modifier bothAgreed() {
        require(agreed[0]*agreed[1] == 1);
        _;
    }

    function changeOwner( address _newOwner ) public {
        owner = _newOwner ;
    }

    function agree_Owner( bool _agree ) public {
        require( owner == msg.sender ) ;
        if( _agree == true ){
            agreed[0] = 1 ;
        } else {
            agreed[0] =0 ;
        }
    }

    function agree_SubOwner( bool _agree ) public {
        require( msg.sender == sub_owner ) ;
        if( _agree == true ) {
            agreed[1] = 1;
        } else {
            agreed[1] =0 ;
        }
    }
} //문제 오류는 없으나 작동이 이상

// 위 문제의 또다른 버전입니다. 
// owner가 변경할 때는 바로 변경가능하게 sub-owner가 
// 변경하려고 한다면 owner의 동의가 필요하게 구현하세요.

contract Q57 {
    
}
