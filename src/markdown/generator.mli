type args = { generate_links : bool; flavour : string }

val render : Odoc_document.Types.Page.t -> args -> Odoc_document.Renderer.page
