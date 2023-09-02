# MyCurrency

MyCurrency è un'applicazione che offre diverse funzionalità per la conversione di valuta e la gestione delle conversioni preferite e dello storico dei tassi di cambio. L'app è organizzata tramite un Navigation Controller per una facile navigazione tra le diverse schermate.

## Schermata principale

La schermata principale presenta i seguenti elementi:

- **Campi di testo**: Ci sono due campi di testo, uno per inserire l'importo da convertire e uno non modificabile dove verrà visualizzato l'importo convertito.

- **Pulsanti di scelta valuta**: Ci sono due pulsanti che permettono di scegliere le valute di partenza e di arrivo. Cliccando su di essi, si apre un menu a tendina con tutte le valute disponibili.

- **Pulsanti in basso**: Due pulsanti in fondo alla schermata, uno per eseguire la conversione e uno per aggiungere la coppia di valute corrente alla lista dei preferiti (se non è già presente).

- **Conversione**: Quando si fa clic sul pulsante di conversione, l'app invia una richiesta a un'API pubblica e gratuita (CurrencyAPI, che offre 300 richieste al mese con il piano gratuito) per ottenere il tasso di conversione tra le due valute selezionate. Questo tasso viene utilizzato per calcolare l'importo convertito e visualizzato nel secondo campo di testo.

- **ToolBar**: Nella ToolBar del Navigation Controller in alto a destra è presente un pulsante che apre un menu a tendina per navigare verso la lista dei preferiti e la lista dello storico.

## Lista dei preferiti

La schermata per visualizzare la lista dei preferiti è organizzata attraverso una TableView controller. Ogni elemento della lista rappresenta una coppia di valute preferite e mostra la valuta di partenza, la valuta di arrivo e un pulsante per eliminarla dalla lista dei preferiti. Cliccando su un elemento, si ritorna alla schermata principale con le valute impostate su quelle della coppia selezionata. È anche presente una SearchBar per filtrare gli elementi in base alla valuta di partenza.

## Storico dei tassi di cambio

La schermata per visualizzare lo storico dei tassi di cambio è anch'essa organizzata attraverso un TableView controller. Ogni elemento rappresenta il tasso di conversione tra le valute selezionate nella schermata principale nei 7 giorni precedenti all'attuale (in ordine dal giorno più recente al meno recente). Questo viene reso possibile grazie a diverse richieste all'API (di tipo Historic).

## Requisiti:
- L'applicazione richiede una connessione internet.

