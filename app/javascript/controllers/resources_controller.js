import { Controller } from 'stimulus'; 
export default class extends Controller {
  static targets = [ "type", "url", "embed_code","file","thumbnail_option","thumbnail" ]
  connect() {
    console.log("hello from StimulusJS")
  }

  set_video_input_type(event){
    let type = this.typeTarget.value.toLowerCase()
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
        case 'source_file':
            this.fileTarget.classList.toggle("hidden", false)
          break;  
        default:
          // code block
      }
  }

  set_video_thumbnail_type(event){
    let option = this.thumbnail_optionTarget.value
    this.thumbnailTarget.classList.toggle("hidden", true)
    console.log(option)
    if(option == 1){
        this.thumbnailTarget.classList.toggle("hidden", false)
    }
  }
}