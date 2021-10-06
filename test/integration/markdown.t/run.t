  $ ocamlc -c -bin-annot test.mli
  $ odoc compile test.cmti
  File "test.mli", line 23, characters 13-22:
  '{foo_bar}': bad markup.
  Suggestion: did you mean '{!foo_bar}' or '[foo_bar]'?
  $ odoc link test.odoc
  $ odoc markdown-generate test.odocl -o markdown
  $ cat markdown/Test.md
  Test
  
  Module  `` Test `` 
  
  
  # This is a heading
  
  ###### type y'
  
  ###### module X : sig
  
  ######     type x
  
  doc for x
  ######     module type Y = sig
  
  ######         type y = y'
  
  
  ######     end
  
  
  ###### end
  
  ###### type name = {
  ######      `` fname : string; `` 
  
  first name
  
  ######      `` lname : string; `` 
  
  ###### }
  
  
  ## Label
  ---
  
  test_two
  **test**
  test two foo
   `` foo_bar `` 
  **barz**
      verbatim
  text
  - p1
  p2
  
  $ odoc markdown-generate test.odocl -o markdown --generate-links
  $ cat markdown/Test.md
  Test
  
  Module Test
  
  
  # This is a heading
  
  <a id="type-y'"></a>
  ###### type y'
  
  <a id="module-X"></a>
  ###### module X : sig
  
  <a id="type-x"></a>
  ######     type x
  
  doc for x
  <a id="module-type-Y"></a>
  ######     module type Y = sig
  
  <a id="type-y"></a>
  ######         type y = [y'](#type-y')
  
  
  ######     end
  
  
  ###### end
  
  <a id="type-name"></a>
  ###### type name = {
  
  <a id="type-name.fname"></a>
  ######     fname : string;
  
  first name
  
  
  <a id="type-name.lname"></a>
  ######     lname : string;
  
  ###### }
  
  
  ## Label
  ---
  
  [test_two](href)
  [**test**](href)
  [test two foo](href)
  [foo_bar](href)
  [**barz**](href)
      verbatim
  text
  - p1
  p2
  

  $ odoc markdown-generate test.odocl -o markdown --md-flavour=pandoc
  $ cat markdown/Test.md
  Test
  
  Module  `` Test `` 
  
  
  # This is a heading {#this-is-a-heading}
  
  ###### type y'
  
  ###### module X : sig
  
  ######     type x
  
  doc for x
  ######     module type Y = sig
  
  ######         type y = y'
  
  
  ######     end
  
  
  ###### end
  
  ###### type name = {
  ######      `` fname : string; `` 
  
  first name
  
  ######      `` lname : string; `` 
  
  ###### }
  
  
  ## Label {#foo}
  ---
  
  test_two
  **test**
  test two foo
   `` foo_bar `` 
  **barz**
      verbatim
  text
  - p1
  p2
  
