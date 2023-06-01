// string을 input으로 받는 함수를 구현하세요.
//  "Alice"나 "Bob"일 때에만 true를 반환하세요
contract Q31 {
    function input( string memory _name ) public pure returns( bytes32 ) {
        return keccak256(abi.encodePacked(_name));
    }

    function hashAliceAndBob( string memory _name ) public pure returns( bool ) {
        return (input(_name) == input("Alice") || input(_name) == input("Bob")) ;
    }

}

// 1. 3의 배수만 들어갈 수 있는 array를 구현하되,
//  3의 배수이자 동시에 10의 배수이면 들어갈 수 없는 추가 조건도 구현하세요.
    
//     예) 3 → o , 9 → o , 15 → o , 30 → x

contract Q32 {
    uint[] number3;

    function set3( uint _number) public {
        for( uint i = 0 ; i < _number ; i ++ ) {
            if( i % 3 == 0) {
                 number3.push(i) ;
            }
        }
    }

    function get() public view returns( uint[] memory ) {
        return number3;
    }
}

contract Q32_1 {
    uint[] numbers ;
    function pushNumbers( uint _n ) public {
        require( _n % 3 == 0 && _n % 10 != 0 ) ;
        numbers.push(_n) ;
    }
}

// 이름, 번호, 지갑주소 그리고 생일을 담은 고객 구조체를 구현하세요. 
// 고객의 정보를 넣는 함수와 고객의 이름으로 검색하면 
// 해당 고객의 전체 정보를 반환하는 함수를 구현하세요.

contract Q33 {
    struct User {
        string name;
        uint number;
        address account;
        uint birthday;
    }

    mapping( string => User ) list ;

    function setInfo( string memory _name , uint _number , address _account , uint _birthday ) public {
        list[_name] = User(_name , _number ,  _account , _birthday ) ;
    } //name에 트리구조 박혀있는 느낌
    //활동형인데 텍에 달려져있는 이름이 getInfo
    function getInfo( string memory _name ) public view returns( User memory ) {
        return list[ _name ] ;
    }
}

// 이름, 번호, 점수가 들어간 학생 구조체를 선언하세요.
//  학생들을 관리하는 자료구조도 따로 선언하고 학생들의 전체 평균을 계산하는 함수도 구현하세요.


// 맵핑은   for( uint i = 0 ; i < list.length ; i ++) 하면 오류가 뜨는데
// ChatGPT
// 맞습니다. mapping은 배열과 달리 length 속성을 갖지 않습니다. 
// 따라서 for 루프에서 list.length를 사용할 수 없습니다.

// mapping은 키와 값의 쌍을 저장하는 구조이며, 
// 저장된 요소에는 순서가 없습니다. 
// 그러므로 mapping을 반복문으로 순회하려면 다른 방식을 사용해야 합니다.
 
contract Q34 {
    struct student {
        string name ;
        uint number ;
        uint marks ;
    }

    //mapping( string => student ) list ; //맵핑은 길이를 못쓰나?? 못씀

    // function set( string memory _name , uint _number , uint _marks ) public {
    //     list[_name] = student(_name, _number, _marks) ;
    // }

    student[] students ;

    function set( string memory _name , uint _number , uint _marks ) public {
        students.push(student(_name,_number,_marks)) ;
    }

    function getAverage() public view returns( uint ) {
        uint sum = 0;

        for( uint i = 0 ; i < students.length ; i ++) {
            sum = sum + students[i].marks ; //sum += students.[i].marks ;
        }
        return sum / students.length;
    }


//     // 매핑의 요소를 인덱스를 통해 가져오는 함수
// function getStudentAtIndex(uint index) internal view returns (string memory, student memory) {
//     // 매핑 요소를 가져오기 위해 해당 키값을 조회
//     string memory name = /* 키값 조회 */;
//     student memory studentData = list[name];

//     return (name, studentData);
// }
}


// 1. 숫자만 들어갈 수 있는 array를 선언하고 해당 array의
//  짝수번째 요소만 모아서 반환하는 함수를 구현하세요.
    
//   예) [1,2,3,4,5,6] -> [2,4,6] // [3,5,7,9,11,13] -> [5,9,13]
contract Q35 {
    uint[] numbers;

    function setOnlyEven( uint[] memory _n ) public returns( uint[] memory ) {
        for( uint i = 0 ; i < 1+ _n.length/2 ; i = i + 2 ) {
            numbers.push(_n[i]) ; //그래야 여기에 배열의 전체 중 그 세부적 [i] 번째 녀석이 들어간다.
        }
        return numbers ;
    }
}

// high, neutral, low 상태를 구현하세요. a라는 변수의 값이 7이상이면 high,
//  4이상이면 neutral 그 이후면 low로 상태를 변경시켜주는 함수를 구현하세요.
contract Q36 {
    enum State { high , neutral , low } 
    State currentState ;

    function updateState( uint _a ) public {
        if ( _a >= 7 ) {
             currentState = State.high ; //밑에 아니면else/ 조건 또 달기 if
        } else if (_a >= 4 && 7 > _a) {
             currentState = State.neutral ;
        } else {
            currentState = State.low ;
        }
    }
}

// 1. 1 wei를 기부하는 기능,
//  1finney를 기부하는 기능 그리고 1 ether를 기부하는 기능을 구현하세요. 
//  최초의 배포자만이 해당 smart contract에서 자금을 회수할 수 있고
//   다른 이들은 못하게 막는 함수도 구현하세요.
    
//     (힌트 : 기부는 EOA가 해당 Smart Contract에게 돈을 보내는 행위, 
//     contract가 돈을 받는 상황)

contract Q37 {
    address payable owner ; 

    constructor() {
        owner = payable(msg.sender) ;
    }

    function donateWei() public payable {
        require( msg.value == 1 wei , "Please donate exactly 1 wei.") ;
    }

    function donateFinney() public payable {
        require( msg.value == 1^15 , " Please donate exactly 1 finney. ") ;
    }

    function donateEther() public payable {
        require( msg.value == 1 ether , "Please donate exactly 1 ether.") ;
    }

    function withdrawFunds() public {
        require(msg.sender == owner , "Only the contract owner can withdraw funds.") ;
        uint balance = address(this).balance ;
        require(balance > 0 , "No funds availavle to withdraw.") ;
        owner.transfer(balance) ;
    }
}


// 1. 상태변수 a를 "A"로 설정하여 선언하세요. 
// 이 함수를 "B" 그리고 "C"로 변경시킬 수 있는 함수를 각각 구현하세요. 
// 단 해당 함수들은 오직 owner만이 실행할 수 있습니다. 
// owner는 해당 컨트랙트의 최초 배포자입니다.
    
// (힌트 : 동일한 조건이 서로 다른 두 함수에 적용되니 더욱 효율성 있게 적용시킬 수 있는 방법을 생각해볼 수 있음)

contract Q38 {
    string a;
    address owner ;

    constructor() {
        owner = msg.sender ;
        a = "A" ;
    }

    modifier onlyOnwer() {
        require( msg.sender == owner , "Only owner can call this function. ") ;
        _;
    }

    function setB() public onlyOnwer {
        a = "B" ;
    }

    function setC() public {
        a = "C" ;
    }

    function getA() public view returns(string memory ) {
        return a;

    }
}

// 1. 특정 숫자의 자릿수까지의 2의 배수, 3의 배수,
//  5의 배수 7의 배수의 개수를 반환해주는 함수를 구현하세요.
    
// 예) 15 : 7,5,3,2  
// (2의 배수 7개, 3의 배수 5개, 5의 배수 3개, 7의 배수 2개) 
// // 100 : 50,33,20,14  
// (2의 배수 50개, 3의 배수 33개, 5의 배수 20개, 7의 배수 14개)
contract Q39 {

    function setNum( uint _n ) public pure returns (uint[4] memory) {
        uint[4] memory counts; // 배열 4개를 저장할건데

        for( uint i = 1 ; i <= _n ; i++ ) {
            if( i % 2 == 0 ) { 
                 counts[0]++ ;
            }
            if( i % 3 == 0 ) { 
                 counts[1]++ ;
            }
            if( i % 5 == 0 ) { 
                 counts[2]++ ;
            }
            if( i % 7 == 0 ) { 
                 counts[3]++ ;
            }
        }
        return counts;
    }
}

// 1. 숫자를 임의로 넣었을 때 오름차순으로 정렬하고
//  가장 가운데 있는 숫자를 반환하는 함수를 구현하세요.
//  가장 가운데가 없다면 가운데 2개 숫자를 반환하세요.
    
//     예) [5,2,4,7,1] -> [1,2,4,5,7], 4 
//     // [1,5,4,9,6,3,2,11] -> [1,2,3,4,5,6,9,11], 4,5 
//     // [6,3,1,4,9,7,8] -> [1,3,4,6,7,8,9], 6

contract Q40 {
    uint[] numbers;

    function setNum( uint[] memory _numbers ) public {
        numbers =_numbers ;
    

    for( uint i = 0 ; i < numbers.length ; i ++ ) { //i는 기준점j는 비교값 이전i보면 이미완성된 격을 보는 것 그러므로 다시 작업시 에러 발생 함.
        for( uint j = i + 1 ; j < numbers.length ; j ++ ) { //여기 미르띤 ★ 
            if(numbers[i] < numbers[j]) {
                (numbers[i] , numbers[j]) = (numbers[j] , numbers[i]) ;
            }
        }
    }
    }
    
    //1,2,3,4,5 / 2
    //0,1,2,3,4,5,6,7 (Index), lenght = 8 ;
    //1,2,3,4,5,6,7,8
    function getNumbers() public view returns( uint[] memory ) {
        
        
        //홀수일때 실행!
        if( numbers.length % 2 == 1 ) {
            uint[] memory newArr = new uint[](1) ;//배열의 길이를 (1) //newArr = [0]
            newArr[0] = numbers[ numbers.length / 2 ];
            return newArr;

        //짝수일때 실행!    
        } else { 
            uint[] memory newArr = new uint[](2) ;
            newArr[0] = numbers[  numbers.length / 2 + 1] ;
            newArr[1] = numbers[ numbers.length / 2 ] ;    
            return newArr;
        }                                     
    }

} 

// [i,j]
//     [0,1]
//     [0,2]
//     [0,3]
//     [0,4]
//     [0,5]

//     [1,2]
//     [1,3]
//     [1,4]
//     [1,5]

//     [2,3]
//     [2,4]
//     [2,5]

//     [3,4]
//     [3,5]

//     [4,5]

