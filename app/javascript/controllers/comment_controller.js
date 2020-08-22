import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for CommentReflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  static targets = [ "content" ]

  connect() {
    this.contentTarget.value = ''
  }

  afterReflex () {
    console.log('qwertyui')
  }
 
}
