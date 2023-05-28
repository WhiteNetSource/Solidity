    // * 브레이크 기능 - 속도를 1 줄이는 기능, 브레이크 기능을 이용할 때마다 연료가 1씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
    function breakCar() public {
        require(/*myCar.speed !=0 &&*/ myCar.status != carStatus.turnedOff && myCar.status != carStatus.stop);
        myCar.speed--;
        myCar.fuelGauage --;

        if(myCar.speed == 0) {
            myCar.status = carStatus.stop;
        }

        if(myCar.fuelGauage == 0) {
            myCar.status = carStatus.outOfFuel;
        }
    }

    // * 시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
    function turnOff() public {
        require(myCar.speed ==0 && myCar.status != carStatus.turnedOff || myCar.fuelGauage ==0); /*a || b&c || d&e || f*/
        if(myCar.speed !=0) {
            myCar.speed =0; //fuelGauage가 0인 상태라면 speed가 0이 아닌 상황이 있을 수 있음
        }

        myCar.status = carStatus.turnedOff;
    }

    // * 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
    function turnOn() public {
        require(myCar.status == carStatus.turnedOff && myCar.fuelGauage >0/*out of fuel로 변경 가능?*/);
        myCar.status = carStatus.stop;
    }

    GASSTATION public gs;

    constructor(address payable _a) {
        gs = GASSTATION(_a);
    }

    function getPrePaid() public returns(uint) {
        uint prePaid = gs.prePaidList(address(this)); //prePaidList[address(this)]
        return prePaid;
    }

    // * 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨
    function reCharge() public payable {
        uint prePaid = getPrePaid();
        require(((prePaid >= 10**18 && msg.value ==0) || msg.value == 10**18) && myCar.status == carStatus.turnedOff);
        /*
        prepaid 1 이상, msg.value = 0 -> o
        prepaid 1 이상, msg.value = 1 fin -> x
        prepaid 1 이상, msg.value = 1 eth -> o
        prepaid 1 이하, msg.value = 1 fin -> x
        prepaid 1 이하, msg.value = 1 eth -> x
        */

        if(msg.value != 10**18) {
            prePaid -= 10**18;
        }

        myCar.fuelGauage = 100;
    }

    function deposit() public payable {}

    function depositToGS(uint _a) public {
        _a = _a * 10 ** 18;
        payable(gs).transfer(_a);
        gs.renewPrePaidList(address(this), _a);
    }
}

contract GASSTATION {

    address payable public owner;
    uint public a;

    receive() external payable{}

    constructor(/*필요하면 input값을 받아서 실행해야함*/) {
        owner = payable(msg.sender);
    }

    mapping(address => uint) public prePaidList;

    function renewPrePaidList(address _a, uint _n) public {
        prePaidList[_a] = _n;
    }

    //* 주유소 사장님은 2번 지갑의 소유자임, 주유소 사장님이 withdraw하는 기능
    function withdraw() public {
        require(owner==msg.sender);
        owner.transfer(address(this).balance);
    }


}