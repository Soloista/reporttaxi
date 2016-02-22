progressDialog = document.querySelector '#progressDialog'

progressMessage = {
    divMessageHolder: document.querySelector '#messageProgress'
    init: ()->
        progressDialog.showModal()
        @putMessage 'Sending to LTFRB. Please Wait...'
    putMessage: (message)->
        @divMessageHolder.innerHTML = message
    closeModal: ()->
        progressDialog.close()
}