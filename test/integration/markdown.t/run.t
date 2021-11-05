  $ ocamlc -c -bin-annot test.mli
  $ odoc compile test.cmti
  File "test.mli", line 25, characters 13-22:
  '{foo_bar}': bad markup.
  Suggestion: did you mean '{!foo_bar}' or '[foo_bar]'?
  $ odoc link test.odoc
  $ odoc markdown-generate test.odocl -o markdown
  $ cat markdown/Test.md
  Test
  
  
  
  # This   is   a   heading ## This   has   a   label 
  
  ---######  type       y'             
  
  
  
  ######  module          X         :    sig      ######  type       x             
  
  doc   for   x 
  
  
  
  ######  module        type          Y         =    sig      ######  type       y      =   y'             
  
  
  
         
  
  
  
         
  
  
  
  ######  type       name         =      {    
  
  
  ###### fname   :   string  ;     
  
  first   name 
  
  
  
  
  
  
  ###### lname   :   string  ;     
  
   }          
  
  
  
  ## Label 
  
  ---[test_two ](href) 
  
  [**test ** ](href) 
  
  [test   two   foo ](href) 
  
  [foo_bar   ](href) 
  
  [**barz** ](href) 
  
  ```
  verbatim
  text
  ```
  
  See   if   listness   is   preserved. 
  
  This   is   an   _interface _   with   **all **   of   the   _module   system _   features.   This   documentation   demonstrates: 
  
  - comment   formatting 
    
    
  
  - unassociated   comments 
    
    
  
  - documentation   sections 
    
    
  
  - module   system   documentation   including 
    
    1. submodules 
       
       
    
    2. module   aliases 
       
       
    
    3. module   types 
       
       
    
    4. module   type   aliases 
       
       
    
    5. modules   with   signatures 
       
       
    
    6. modules   with   aliased   signatures 
       
       
    
    
  
  A   numbered   list: 
  
  1. 3 
     
     
  
  2. 2 
     
     
  
  3. 1 
     
     
  
  David   Sheets   is   the   author. 
  
  @author  : 
  
  David Sheets 
  
  
  
  ######  module          Foo         :    sig      ######  type       foo             
  
  
  
  ######  type       poly      =      [     
  
  
  ###### |       `Mon     
  
  
  
  
  
  
  ###### |       `Tue     
  
    ]          
  
  
  
  ######  type       name         =      {    
  
  
  ###### fname   :   string  ;     
  
  
  
  
  
  
  ###### lname   :   string  ;     
  
   }          
  
  
  
         
  
  The   end   foo   end   keyword   in   doc   comment. 
  
  
  
  p1 
  
  p2 
  
  p3 
  
  - a 
    
    
  
  - b 
    
    
  
  This   is   where   I   begin   my   thing   from. 
  
  1. one 
     
     
  
  2. two 
     
     
  
  - Mon 
    
    
  
  - Tue 
    
    
  
  $ odoc markdown-generate test.odocl -o markdown --generate-links
  $ cat markdown/Test.md
  Test
  
  
  
  # This   is   a   heading ## This   has   a   label 
  
  ---<a id="type-y'"></a>
  
  ######  type       y'             
  
  <a id="module-X"></a>
  
  ######  module          X         :    sig      <a id="type-x"></a>
  
  ######  type       x             
  
  doc   for   x 
  
  <a id="module-type-Y"></a>
  
  ######  module        type          Y         =    sig      <a id="type-y"></a>
  
  ######  type       y      =              
  
         
  
         
  
  <a id="type-name"></a>
  
  ######  type       name         =      {    <a id="type-name.fname"></a>
  
  ###### fname   :   string  ;     
  
  first   name 
  
  
  
  <a id="type-name.lname"></a>
  
  ###### lname   :   string  ;     
  
   }          
  
  ## Label 
  
  ---[test_two ](href) 
  
  [**test ** ](href) 
  
  [test   two   foo ](href) 
  
  [foo_bar   ](href) 
  
  [**barz** ](href) 
  
  ```
  verbatim
  text
  ```
  
  See   if   listness   is   preserved. 
  
  This   is   an   _interface _   with   **all **   of   the   _module   system _   features.   This   documentation   demonstrates: 
  
  - comment   formatting 
    
    
  
  - unassociated   comments 
    
    
  
  - documentation   sections 
    
    
  
  - module   system   documentation   including 
    
    1. submodules 
       
       
    
    2. module   aliases 
       
       
    
    3. module   types 
       
       
    
    4. module   type   aliases 
       
       
    
    5. modules   with   signatures 
       
       
    
    6. modules   with   aliased   signatures 
       
       
    
    
  
  A   numbered   list: 
  
  1. 3 
     
     
  
  2. 2 
     
     
  
  3. 1 
     
     
  
  David   Sheets   is   the   author. 
  
  @author  : 
  
  David Sheets 
  
  
  
  <a id="module-Foo"></a>
  
  ######  module          Foo         :    sig      <a id="type-foo"></a>
  
  ######  type       foo             
  
  <a id="type-poly"></a>
  
  ######  type       poly      =      [     <a id="type-poly.Mon"></a>
  
  ###### |       `Mon     
  
  
  
  <a id="type-poly.Tue"></a>
  
  ###### |       `Tue     
  
    ]          
  
  <a id="type-name"></a>
  
  ######  type       name         =      {    <a id="type-name.fname"></a>
  
  ###### fname   :   string  ;     
  
  
  
  <a id="type-name.lname"></a>
  
  ###### lname   :   string  ;     
  
   }          
  
         
  
  The   end   foo   end   keyword   in   doc   comment. 
  
  p1 
  
  p2 
  
  p3 
  
  - a 
    
    
  
  - b 
    
    
  
  This   is   where   I   begin   my   thing   from. 
  
  1. one 
     
     
  
  2. two 
     
     
  
  - Mon 
    
    
  
  - Tue 
    
    
  
