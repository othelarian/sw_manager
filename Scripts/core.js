// core.js

function loadgame() {
    swmdb.openDatabase(dbpath,createdbStatus)
    var infos = swmdb.getInfos()
    //
    // TODO : parse infos
    //
    gameTitle.text = infos
    infosIn1.titleLab = infos
    //
    loaded = true
    mainStack.push(gameScreen)
}

function closegame() {
    if (screenPop.diceroller === 2) dicerollerWin.close()
    if (screenPop.deck === 2) deckWin.close()
    if (screenPop.rules === 2) rulesWin.close()
    if (screenPop.chars === 2) charsWin.close()
    if (screenPop.extras === 2) extrasWin.close()
    if (screenPop.locations === 2) locationsWin.close()
    if (screenPop.history === 2) historyWin.close()
    if (screenPop.stories === 2) storiesWin.close()
    if (screenPop.sessions === 2) sessionsWin.close()
    var lstlinks = ["diceroller","deck","rules","chars","extras",
                    "location","history","stories","sessions"]
    for (var i=0;i<lstlinks.length;i++)
        if (screenPop[lstlinks[i]] === 1) { gameStackChange(lstlinks[i]); break }
    swmdb.closeDatabase(); loaded = false; mainStack.pop()
}

var screenPop = {
    "current": "",
    "diceroller": 0, "deck": 0, "rules": 0,
    "chars": 0, "extras": 0, "locations": 0,
    "history": 0, "stories": 0, "sessions": 0
}

function gameStackChange(screen) {
    if (screenPop[screen] === 0) {
        if (screenPop.current !== "") screenPop[screenPop.current] = 0
        screenPop.current = screen
        screenPop[screen] = 1
        switch (screen) {
        case "diceroller": dicerollerIn1.initDice(); gameStack.push(dicerollerScreen); break
        case "deck": deckIn1.initDeck(); gameStack.push(deckScreen); break
        case "rules": rulesIn1.initRules(); gameStack.push(rulesScreen); break
        case "chars": charsIn1.initChars(); gameStack.push(charsScreen); break
        case "extras": extrasIn1.initExtras(); gameStack.push(extrasScreen); break
        case "locations": locationsIn1.initLocations(); gameStack.push(locationsScreen); break
        case "history": historyIn1.initHistory(); gameStack.push(historyScreen); break
        case "stories": storiesIn1.initStories(); gameStack.push(storiesScreen); break
        case "sessions": sessionsIn1.initSessions(); gameStack.push(sessionsScreen); break
        }
    }
    else if (screenPop[screen] === 1) {
        screenPop.current = ""
        screenPop[screen] = 0
        gameStack.pop(gameinfosScreen)
    }
}

function gameStackSeparate(screen) {
    screenPop[screen] = 2
    screenPop.current = ""
    gameStack.pop(gameinfosScreen)
    switch (screen) {
    case "diceroller": dicerollerIn2.initDice(); dicerollerWin.show(); break
    case "deck": deckIn2.initDeck(); deckWin.show(); break
    case "rules": rulesIn2.initRules(); rulesWin.show(); break
    case "chars": charsIn2.initChars(); charsWin.show(); break
    case "extras": extrasIn2.initExtras(); extrasWin.show(); break
    case "locations": locationsIn2.initLocations(); locationsWin.show(); break
    case "history": historyIn2.initHistory(); historyWin.show(); break
    case "stories": storiesIn2.initStories(); storiesWin.show(); break
    case "sessions": sessionsIn2.initSessions(); sessionsWin.show(); break
    }
}

function gameStackReintegrate(screen) { screenPop[screen] = 0 }
