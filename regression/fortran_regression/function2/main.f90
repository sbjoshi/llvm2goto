subroutine foo(a, b)
    integer, intent(out):: a, b ! output
    integer             :: c ! temp
    c = a
    a = b
    b = c
end subroutine foo
 
program add
    implicit none
    integer :: a, b
    a = 10
    b = 20
    if((a .ne. 10) .or. (b .ne. 20)) then
    	call __ll2gb_assert_fail()
	end if
    call foo(a, b)
    if((a .ne. 20) .or. (b .ne. 10)) then
    	call __ll2gb_assert_fail()
	end if
	
	if((a+b) .eq. 30) then
    	call __ll2gb_assert_fail()
	end if
end program add

