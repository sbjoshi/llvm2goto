program if_switch
    implicit none
	integer ::i, j

	if(i .ge. 0)then
		if(j .ge. 0)then
		
			j= j+1 ;
		else if(j .eq. 0)then
		
			j = j+1
		else
			j = 0
		end if
        if(j .lt. 0) then
	        call __ll2gb_assert_fail()
        end if
	else
	    select case(j)
		    case(0)
		        j = -1
		    case(-1)
		        j = -2
		    case default
		        j = j
        end select
        if(j .ge. 0) then
	        call __ll2gb_assert_fail()
        end if
	end if
	if((.not.(i.gt.0) .or. (j.ge.0)) .and. (.not.(i.le.0) .or.  (j.lt.0)))then
        call __ll2gb_assert_fail()
    end if
end program
