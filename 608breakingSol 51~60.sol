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
 