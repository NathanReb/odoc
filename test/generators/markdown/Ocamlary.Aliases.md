Ocamlary

Aliases

Let's   imitate   jst's   layout. 



######  module          Foo         :    sig      ######  module          A         :    sig      ######  type       t             



######  val       id   :    t                      t       



       



######  module          B         :    sig      ######  type       t             



######  val       id   :    t                      t       



       



######  module          C         :    sig      ######  type       t             



######  val       id   :    t                      t       



       



######  module          D         :    sig      ######  type       t             



######  val       id   :    t                      t       



       



######  module          E         :    sig      ######  type       t             



######  val       id   :    t                      t       



       



       



######  module          A'      =   Foo.A          



######  type       tata      =   Foo.A.t             



######  type       tbtb      =   Foo.B.t             



######  type       tete             



######  type       tata'      =   A'.t             



######  type       tete2      =   Foo.E.t             



######  module          Std         :    sig      ######  module          A      =   Foo.A          



######  module          B      =   Foo.B          



######  module          C      =   Foo.C          



######  module          D      =   Foo.D          



######  module          E      =   Foo.E          



       



######  type       stde      =   Std.E.t             



### include   of   Foo 

---Just   for   giggle,   let's   see   what   happens   when   we   include   Foo    . 

######  module          A      =   Foo.A          



######  module          B      =   Foo.B          



######  module          C      =   Foo.C          



######  module          D      =   Foo.D          



######  module          E         :    sig      ######  type       t             



######  val       id   :    t                      t       



       



######  type       testa      =   A.t             



And   also,   let's   refer   to   A.t      and   Foo.B.id    

######  module          P1         :    sig      ######  module          Y         :    sig      ######  type       t             



######  val       id   :    t                      t       



       



       



######  module          P2         :    sig      ######  module          Z      =   Z          



       



######  module          X1      =   P2.Z          



######  module          X2      =   P2.Z          



######  type       p1      =   X1.t             



######  type       p2      =   X2.t             



