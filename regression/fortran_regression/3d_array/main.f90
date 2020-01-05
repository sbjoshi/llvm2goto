program array
    implicit none
    integer, dimension(2,3,4)   :: arr
    integer                     :: s, i, j, k
    do i  =1,2
        do j  =1,3
            do k  =1,4
   		        arr(i,j,k) = i+j+k
	        end do
	    end do
	end do
	s = 0
    do i  =1,2
        do j  =1,3
            do k  =1,4
                if(arr(i,j,k) .ne. (i+j+k)) then
                	call __ll2gb_assert_fail()
	            end if
	            s = s + arr(i,j,k);
	        end do
	    end do
	end do
    if(s .ne. 144) then
    	call __ll2gb_assert_fail()
    end if
end program array
