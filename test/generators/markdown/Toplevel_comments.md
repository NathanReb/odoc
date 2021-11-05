Toplevel_comments

A   doc   comment   at   the   beginning   of   a   module   is   considered   to   be   that   module's   doc. 



######  module        type          T         =    sig      ######  type       t             



       

Doc   of   T   ,   part   1. 



######  module          Include_inline         :    sig      ######  type       t             



       

Doc   of   T   ,   part   2. 



######  module          Include_inline'         :    sig      ######  type       t             



       

Doc   of   Include_inline   ,   part   1. 



######  module        type          Include_inline_T         =    sig      ######  type       t             



       

Doc   of   T   ,   part   2. 



######  module        type          Include_inline_T'         =    sig      ######  type       t             



       

Doc   of   Include_inline_T'   ,   part   1. 



######  module          M         :    sig             

Doc   of   M   



######  module          M'         :    sig             

Doc   of   M'     from   outside 



######  module          M''         :    sig             

Doc   of   M''   ,   part   1. 



######  module          Alias         :    sig      ######  type       t             



       

Doc   of   Alias   . 



######  class              c1         :    object             

Doc   of   c1   ,   part   1. 



######  class        type              ct         =    object             

Doc   of   ct   ,   part   1. 



######  class              c2         :    object             

Doc   of   c2   . 



######  module          Ref_in_synopsis         :    sig      ######  type       t             



       

t    . 



