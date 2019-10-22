Describe "option1.sh"
  Specify 'without any parameters'
    When run shell ./option1.sh
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The lines of output should eq 2
  End

  Specify 'with parameters'
    When run shell ./option1.sh - 1 2
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq '$1: -'
    The line 4 of output should eq '$2: 1'
    The line 5 of output should eq '$3: 2'
    The lines of output should eq 5
  End

  Specify 'with flags'
    When run shell ./option1.sh -a -b 1 2 3
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: 1'
    The line 3 of output should eq '$1: 1'
    The line 4 of output should eq '$2: 2'
    The line 5 of output should eq '$3: 3'
    The lines of output should eq 5
  End

  Specify 'unrecognized option'
    When run shell ./option1.sh -x
    The error should eq "unrecognized option '-x'"
    The status should be failure
  End
End
