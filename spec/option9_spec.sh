Describe "option9.sh"
  Specify 'without any parameters'
    When run script ./option9.sh
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The lines of output should eq 2
  End

  Specify 'with parameters'
    When run script ./option9.sh - 1 2
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq '$1: -'
    The line 4 of output should eq '$2: 1'
    The line 5 of output should eq '$3: 2'
    The lines of output should eq 5
  End

  Specify 'unrecognized option'
    When run script ./option9.sh -x
    The error should eq "unrecognized option '-x'"
    The status should be failure
  End

  Specify 'with short options'
    When run script ./option9.sh -a -i A -b -j B
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: 1'
    The line 3 of output should eq 'ARG_I: A'
    The line 4 of output should eq 'ARG_J: B'
    The lines of output should eq 4
  End

  Specify 'missing short option argument'
    When run script ./option9.sh -a -i
    The error should eq "option '-i' requires an argument"
    The status should be failure
  End

  Specify 'with long options'
    When run script ./option9.sh --flag-a --arg-i I
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: I'
    The lines of output should eq 3
  End

  Specify 'missing long option argument'
    When run script ./option9.sh --flag-a --arg-i
    The error should eq "option '--arg-i' requires an argument"
    The status should be failure
  End

  Specify 'with paramters'
    When run script ./option9.sh a b
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq '$1: a'
    The line 4 of output should eq '$2: b'
    The lines of output should eq 4
  End

  Specify 'mixed options and parameters'
    When run script ./option9.sh --flag-a param --arg-i I
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: I'
    The line 4 of output should eq '$1: param'
    The lines of output should eq 4
  End

  Specify 'stop parsing with --'
    When run script ./option9.sh --flag-a -- param --arg-i I param2
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq '$1: param'
    The line 4 of output should eq '$2: --arg-i'
    The line 5 of output should eq '$3: I'
    The line 6 of output should eq '$4: param2'
    The lines of output should eq 6
  End

  Specify 'consecutive short options'
    When run script ./option9.sh +ab -ab
    The line 1 of output should eq 'FLAG_A: 1'
    The line 2 of output should eq 'FLAG_B: 1'
    The lines of output should eq 2
  End

  Specify 'consecutive short options (negative)'
    When run script ./option9.sh -ab +ab
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The lines of output should eq 2
  End

  Specify 'short option with argument'
    When run script ./option9.sh -i123 -j=456
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: 123'
    The line 4 of output should eq 'ARG_J: =456'
    The lines of output should eq 4
  End

  Specify 'long option with argument'
    When run script ./option9.sh --arg-i=123 --arg-j=456
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: 123'
    The line 4 of output should eq 'ARG_J: 456'
    The lines of output should eq 4
  End

  Specify 'short option with optional argument'
    When run script ./option9.sh -o123 -p param
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'OPT_O: 123'
    The line 4 of output should eq 'OPT_P: default'
    The line 5 of output should eq '$1: param'
    The lines of output should eq 5
  End

  Specify 'short option with optional argument'
    When run script ./option9.sh --opt-o=123 --opt-p param
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'OPT_O: 123'
    The line 4 of output should eq 'OPT_P: default'
    The line 5 of output should eq '$1: param'
    The lines of output should eq 5
  End

  Specify 'negative option'
    When run script ./option9.sh -a +a --flag-b --no-flag-b
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The lines of output should eq 2
  End

  Specify 'unrecognized negative option'
    When run script ./option9.sh +x
    The error should eq "unrecognized option '+x'"
    The status should be failure
  End

  Specify 'negative option'
    When run script ./option9.sh -a +a --flag-b --no-flag-b
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The lines of output should eq 2
  End

  Specify 'multiple args'
    When run script ./option9.sh -i arg --arg-i "I've a pen"
    The line 1 of output should eq 'FLAG_A: '
    The line 2 of output should eq 'FLAG_B: '
    The line 3 of output should eq 'ARG_I: arg'
    The line 4 of output should eq "ARG_I: I've a pen"
    The lines of output should eq 4
  End
End
