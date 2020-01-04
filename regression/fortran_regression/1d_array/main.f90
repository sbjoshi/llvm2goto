program array
    implicit none
    integer, dimension(5)	:: arr
    integer					:: s, i
    do i  =1,5
   		arr(i) = i
	end do
	s = 0
    do i  =1,5
   		s = s + arr(i)
	end do
    if(s .ne. 15) then
    	call __ll2gb_assert_fail()
	end if
end program array

