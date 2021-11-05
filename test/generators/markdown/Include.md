Include



######  module        type          Not_inlined         =    sig      ######  type       t             



       



######  type       t             



######  module        type          Inlined         =    sig      ######  type       u             



       



######  type       u             



######  module        type          Not_inlined_and_closed         =    sig      ######  type       v             



       



  include       Not_inlined_and_closed       ######  module        type          Not_inlined_and_opened         =    sig      ######  type       w             



       



######  type       w             



######  module        type          Inherent_Module         =    sig      ######  val       a   :   t       



       



######  module        type          Dorminant_Module         =    sig      ######  val       a   :   u       



       



######  val       a   :   u       



