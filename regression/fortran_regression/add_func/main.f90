function func(a, b) result(c)
    integer, intent(in) :: a, b ! input
    integer             :: c ! output
    c = a + b
 end function func
 
program add
    implicit none
    integer :: a, b
    integer :: func
    a = 10
    b = 20
    if(func(a, b) .ne. a+b) then
    	call __ll2gb_assert_fail()
	end if
 end program add
      
