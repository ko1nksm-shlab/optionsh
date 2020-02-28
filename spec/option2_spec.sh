Describe "option2.sh"
  Specify 'without any parameters'
    When run script ./option2.sh
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: '
    The line 4 of output should eq 'ARG_J: '
    The lines of output should eq 4
  End

  Specify 'with parameters'
    When run script ./option2.sh - 1 2
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: '
    The line 4 of output should eq 'ARG_J: '
    The line 5 of output should eq '$1: -'
    The line 6 of output should eq '$2: 1'
    The line 7 of output should eq '$3: 2'
    The lines of output should eq 7
  End

  Specify 'unrecognized option'
    When run script ./option2.sh -x
    The error should eq "unrecognized option '-x'"
    The status should be failure
  End

  Specify 'with short options'
    When run script ./option2.sh -a -i A -b -j B
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: 1'
    The line 3 of output should eq 'ARG_I: A'
    The line 4 of output should eq 'ARG_J: B'
    The lines of output should eq 4
  End

  Specify 'missing short option argument'
    When run script ./option2.sh -a -i
    The error should eq "option '-i' requires an argument"
    The status should be failure
  End

  Specify 'with long options'
    When run script ./option2.sh --flag-a --arg-i I
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: I'
    The line 4 of output should eq 'ARG_J: '
    The lines of output should eq 4
  End

  Specify 'missing long option argument'
    When run script ./option2.sh --flag-a --arg-i
    The error should eq "option '--arg-i' requires an argument"
    The status should be failure
  End

  Specify 'with paramters'
    When run script ./option2.sh a b
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: '
    The line 4 of output should eq 'ARG_J: '
    The line 5 of output should eq '$1: a'
    The line 6 of output should eq '$2: b'
    The lines of output should eq 6
  End

  Specify 'stop parsing with non-option'
    When run script ./option2.sh --flag-a param --arg-i I
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: '
    The line 4 of output should eq 'ARG_J: '
    The line 5 of output should eq '$1: param'
    The line 6 of output should eq '$2: --arg-i'
    The line 7 of output should eq '$3: I'
    The lines of output should eq 7
  End
End
