define i1 @isVowel(i8 %char) {
  %is_a = icmp eq i8 %char, 97  ; 'a'
  %is_e = icmp eq i8 %char, 101 ; 'e'
  %is_i = icmp eq i8 %char, 105 ; 'i'
  %is_o = icmp eq i8 %char, 111 ; 'o'
  %is_u = icmp eq i8 %char, 117 ; 'u'
  %is_A = icmp eq i8 %char, 65  ; 'A'
  %is_E = icmp eq i8 %char, 69  ; 'E'
  %is_I = icmp eq i8 %char, 73  ; 'I'
  %is_O = icmp eq i8 %char, 79  ; 'O'
  %is_U = icmp eq i8 %char, 85  ; 'U'
  
  %or1 = or i1 %is_a, %is_e
  %or2 = or i1 %is_i, %is_o
  %or3 = or i1 %or1, %or2
  %or4 = or i1 %is_u, %is_A
  %or5 = or i1 %is_E, %is_I
  %or6 = or i1 %or4, %or5
  %or7 = or i1 %is_O, %is_U
  %or8 = or i1 %or3, %or6
  %is_vowel = or i1 %or7, %or8

  ret i1 %is_vowel
}

define i8 @main() {
  %vowel_check = call i1 @isVowel(i8 97)
  ret i8 %vowel_check
}