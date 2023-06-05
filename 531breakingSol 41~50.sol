// 숫자만 들어갈 수 있으며 길이가 4인 배열을 (상태변수로)선언하고
//  그 배열에 숫자를 넣는 함수를 구현하세요. 
//  배열을 초기화하는 함수도 구현하세요. 
//  (길이가 4가 되면 자동으로 초기화하는 기능은 굳이 구현하지 않아도 됩니다.)

contract Q41 {
    uint[3] numbers;

    function setNum( uint[3] memory _n ) public {
        numbers = _n ;
    }

    function reset() public {
        //numbers = [0,0,0] ;
        delete numbers ;
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

    function createUser( string _name ; uint _number ; )


}