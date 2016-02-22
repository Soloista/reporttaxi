#functionality
showReportDialogButton = document.querySelector '#showReportDialog'
closeReportDialogButton = document.querySelector '#closeDialog'
reportDialog = document.querySelector '#reportDialog'
reportForm = document.querySelector '#reportForm'

showReportDialogButton.addEventListener 'click', (e)->
    reportDialog.showModal()

closeReportDialogButton.addEventListener 'click', (e)->
    e.preventDefault()
    reportForm.reset()
    reportDialog.close()

reportForm.addEventListener 'submit', (e)->
    e.preventDefault()
    progressMessage.init()
    # credentials
    nodemailer = require 'nodemailer'
    emailaddress = 'reportataxi@gmail.com'
    password = 'reportataxi99'
    transporter = nodemailer.createTransport 'smtps://'+emailaddress+':'+password+'@smtp.gmail.com'
    date = document.querySelector 'input[name="date"]'
    plateno = document.querySelector 'input[name="plateno"]'
    taxiname = document.querySelector 'input[name="taxiname"]'
    location = document.querySelector 'input[name="location"]'
    comment = document.querySelector 'textarea[name="comment"]'
    violation = document.querySelector 'input[name="violation"]:checked'
    reporterName = document.querySelector 'input[name="reporterName"]'
    reporterEmail = document.querySelector 'input[name="reporterEmail"]'
    contactno = document.querySelector 'input[name="contactno"]'
    reporterAddress = document.querySelector 'input[name="reporterAddress"]'
    emailContent = 'To The Office of Land Transportation Franchising and Regulatory Board,'
    emailContent += '\n\n '
    emailContent += 'The Report-a-Taxi Application would like to send a report regarding with a misbehaved or an abusive taxi driver. Please see the details below:\n\n'
    emailContent += 'Reporter\'s Name: '+reporterName.value+'\n'
    emailContent += 'Reporter\'s Contact Number: '+contactno.value+'\n'
    emailContent += 'Reporter\'s Address: '+reporterAddress.value+'\n'
    emailContent += 'Reporter\'s Email Address: '+reporterEmail.value+'\n'
    emailContent += '\n\nConcern: \n'
    emailContent += 'Date of Incident: '+date.value+'\n'
    emailContent += 'Plate Number: '+plateno.value+'\n'
    emailContent += 'Taxi Name / Driver\'s Name: '+taxiname.value+'\n'
    emailContent += 'The incident happened at: '+location.value+'\n'
    emailContent += 'Driver\'s Violation: '+violation.value+'\n'
    emailContent += 'Other Details: '+comment.value+'\n'
    mailOptions = {
        from: 'Report A Taxi <'+emailaddress+'>'
        to: 'John Eric Orolfo <earljohn3ric@gmail.com>'
        cc: reporterName.value+' <'+reporterEmail.value+'>'
        subject: 'Issue Regarding With A Taxi / Taxi Driver'
        text: emailContent
    }
    transporter.sendMail mailOptions, (err, info)->
        if err
            progressMessage.putMessage 'An error occured on sending your report. Please check your Internet connection or try again later.'
            setTimeout progressMessage.closeModal, 2500
            return
        progressMessage.putMessage 'Report Sent!'
        setTimeout progressMessage.closeModal, 2500
        recordInterface.insert {
            'date': date.value
            'plateno': plateno.value
            'taxiname': taxiname.value
            'location': location.value
            'comment': comment.value
            'violation': violation.value
        }
        db.saveDatabase()
        return