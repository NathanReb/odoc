Module

Foo. 



######  val       foo   :   unit    

The   module   needs   at   least   one   signature   item,   otherwise   a   bug   causes   the   compiler   to   drop   the   module   comment   (above).   See   [https://caml.inria.fr/mantis/view.php?id=7701 ](https://caml.inria.fr/mantis/view.php?id=7701) . 



######  module        type          S         =    sig      ######  type       t             



######  type       u             



######  type        'a     v               



######  type        ('a, 'b)     w               



######  module          M         :    sig             



       



######  module        type          S1          



######  module        type          S2      =   S          



######  module        type          S3         =    sig      ######  type       t      =   int          



######  type       u      =   string          



######  type        'a     v               



######  type        ('a, 'b)     w               



######  module          M         :    sig             



       



######  module        type          S4         =    sig      ######  type       u             



######  type        'a     v               



######  type        ('a, 'b)     w               



######  module          M         :    sig             



       



######  module        type          S5         =    sig      ######  type       t             



######  type       u             



######  type        ('a, 'b)     w               



######  module          M         :    sig             



       



######  type        ('a, 'b)     result               



######  module        type          S6         =    sig      ######  type       t             



######  type       u             



######  type        'a     v               



######  module          M         :    sig             



       



######  module          M'         :    sig             



######  module        type          S7         =    sig      ######  type       t             



######  type       u             



######  type        'a     v               



######  type        ('a, 'b)     w               



######  module          M      =   M'          



       



######  module        type          S8         =    sig      ######  type       t             



######  type       u             



######  type        'a     v               



######  type        ('a, 'b)     w               



       



######  module        type          S9         =    sig             



######  module          Mutually         :    sig             



######  module          Recursive         :    sig             



