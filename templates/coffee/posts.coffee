getPosts = {
    historyDiv: document.querySelector 'div.history'
    init: ()->
        @historyDiv.innerHTML = ''
        setTimeout @fillHistory, 500
        return
    fillHistory: ()->
        records = db.getCollection 'records'
        if records is null
            records = db.addCollection 'records'
        result = records.find().reverse()
        result.map (record, key)->
            postDiv = document.createElement 'div'
            postDiv.classList.add 'posts'
            postSection = document.createElement 'section'
            postSection.classList.add 'post'
            header = document.createElement 'header'
            header.classList.add 'post-header'
            hPostTitle = document.createElement 'h2'
            hPostTitle.classList.add 'post-header'
            pDateMeta = document.createElement 'p'
            pDateMeta.classList.add 'post-meta'
            pDnameMeta = document.createElement 'p'
            pDnameMeta.classList.add 'post-meta'
            pCaseMeta = document.createElement 'p'
            pCaseMeta.classList.add 'post-meta'
            pLocMeta = document.createElement 'p'
            pLocMeta.classList.add 'post-meta'
            postDesDiv = document.createElement 'div'
            postDesDiv.classList.add 'post-description'
            pPostDet = document.createElement 'p'
            # populate and insert
            hPostTitle.textContent = record.plateno
            pDateMeta.textContent = 'Date: '+record.date
            pDnameMeta.textContent = 'Driver\'s Name / Taxi Name: '+record.taxiname
            pCaseMeta.textContent = 'Case: '+record.violation
            pLocMeta.textContent = 'Location: '+record.location
            header.appendChild hPostTitle
            header.appendChild pDateMeta
            header.appendChild pDnameMeta
            header.appendChild pCaseMeta
            header.appendChild pLocMeta
            postSection.appendChild header
            pPostDet.textContent = record.comment
            postDesDiv.appendChild pPostDet
            postSection.appendChild postDesDiv
            postDiv.appendChild postSection
            getPosts.historyDiv.appendChild postDiv
        return
}
getPosts.init()