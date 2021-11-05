Include2



######  module          X         :    sig      ######  type       t      =   int          



       

Comment   about   X   that   should   not   appear   when   including   X   below. 



Comment   about   X   that   should   not   appear   when   including   X   below. 

######  type       t      =   int          



######  module          Y         :    sig      ######  type       t             



       

Top-comment   of   Y. 



######  module          Y_include_synopsis         :    sig      ######  type       t      =   Y.t             



       

The   include Y     below   should   have   the   synopsis   from   Y   's   top-comment   attached   to   it. 



######  module          Y_include_doc         :    sig      ######  type       t      =   Y.t             



       



