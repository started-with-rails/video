import { Controller } from 'stimulus'; 
export default class extends Controller {
  static targets = [ "type", "url", "embed_code","file","thumbnail_option","thumbnail","content" ,"listview","gridview"]
 
  connect() {
    if (this.hastypeTarget) {
      let type = this.typeTarget.value.toLowerCase()
      this.source_type(type)
      let option = this.thumbnail_optionTarget.value
      this.thumbnail_type(option)
    }
  }

  set_video_input_type(event){
    let type = this.typeTarget.value.toLowerCase()
    this.source_type(type)
  }

  set_video_thumbnail_type(event){
    let option = this.thumbnail_optionTarget.value
    this.thumbnail_type(option)
  }

  source_type(type){
    this.urlTarget.classList.toggle("hidden", true)
    this.embed_codeTarget.classList.toggle("hidden", true)
    this.fileTarget.classList.toggle("hidden", true)
    switch(type) {
        case 'video_url':
            this.urlTarget.classList.toggle("hidden", false)
          break;
        case 'embed_code':
            this.embed_codeTarget.classList.toggle("hidden", false)
          break;
        case 'video_file':
            this.fileTarget.classList.toggle("hidden", false)
          break;  
        default:
          // code block
    }
    
  }

  thumbnail_type(option){
    this.thumbnailTarget.classList.toggle("hidden", true)
    if(option == 'upload'){
        this.thumbnailTarget.classList.toggle("hidden", false)
    }
  }

  toggle(event){
    event.preventDefault();
    let view = event.currentTarget.dataset.view
    this.listviewTarget.classList.remove("active")
    this.gridviewTarget.classList.remove("active")
    event.currentTarget.classList.add("active")
    this.contentTarget.classList.remove("grid","list")
    this.contentTarget.classList.add(view)
  }
}