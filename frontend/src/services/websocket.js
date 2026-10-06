// URL WebSocket : configurable au build (VITE_WS_URL). Un chemin relatif (/ws) est converti en ws(s)://hôte
const wsProto = window.location.protocol === "https:" ? "wss" : "ws";
const rawWs = import.meta.env.VITE_WS_URL || `${wsProto}://${window.location.hostname}:8080/ws`;
const WS_BASE = rawWs.startsWith("/") ? `${wsProto}://${window.location.host}${rawWs}` : rawWs;

// connexion WebSocket pour le jeu
export const connectGame = (gameId, playerId, onMessage) => {
    const ws = new WebSocket(`${WS_BASE}/game/${gameId}/${playerId}`);
    ws.onmessage = (e) => onMessage(JSON.parse(e.data));
    ws.onerror = (e) => console.error("WS Game error", e);
    return ws;
};

// connexion WebSocket pour le chat
export const connectChat = (gameId, playerId, onMessage) => {
    const ws = new WebSocket(`${WS_BASE}/chat/${gameId}/${playerId}`);
    ws.onmessage = (e) => onMessage(JSON.parse(e.data));
    ws.onerror = (e) => console.error("WS Chat error", e);
    return ws;
};

// envoyer une action de jeu
export const sendAction = (ws, action, cardId, chosenColor) => {
    const msg = { action };
    if (cardId) msg.cardId = cardId;
    if (chosenColor) msg.chosenColor = chosenColor;
    ws.send(JSON.stringify(msg));
};

// envoyer un message chat
export const sendChatMessage = (ws, content) => {
    ws.send(JSON.stringify({ content }));
};