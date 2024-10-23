import React, { useState } from 'react';
import './InputAi.css';
import { FaSpinner } from 'react-icons/fa';

interface ChatItem {
  question: string;
  answer: string;
}

interface InputAiProps {
  type?: string;
  children?: React.ReactNode;
}

const InputAi: React.FC<InputAiProps> = ({ type = '', children }) => {
  // const [isFocused, setIsFocused] = useState(false);
  // const [isActive, setIsActive] = useState(false);
  const [inputValue, setInputValue] = useState<string>(''); // Für das Input-Feld
  const [chatHistory, setChatHistory] = useState<ChatItem[]>([]); // Chatverlauf

  // Funktion zur Behandlung der Antwortgenerierung (z. B. durch API-Call)
  const handleGenerateAnswer = () => {
    if (inputValue.trim() !== '') {
      const newAnswer = 'Hier ist die generierte Antwort.'; // Simulierte Antwort
      const newChatItem = { question: inputValue, answer: newAnswer };
      setChatHistory([...chatHistory, newChatItem]); // Neuen Eintrag zum Chatverlauf hinzufügen
      setInputValue(''); // Input-Feld leeren
      // setIsFocused(false); // Fokus entfernen
    }
  };

   // Funktion zur Überprüfung der Enter-Taste
  const handleKeyPress = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      handleGenerateAnswer();
    }
  };

  if (type === 'help') {
    return (
      <div className='ai-area'>
        <h2>Hilfecenter</h2>
        <div className='ai-input-wrap'>
          <input
            data-function={type}
            className="ai-help"
            placeholder="Geben Sie hier Ihre Frage ein"
            value={inputValue} // Das Input-Feld an den State binden
            onChange={(e) => setInputValue(e.target.value)} // Eingabe speichern
            //onFocus={() => setIsFocused(true)}
            // onBlur={() => !inputValue && setIsFocused(false)}
            onKeyPress={handleKeyPress}
          />
        </div>
        <p>Diese Funktion ist KI-Unterstützt. Ihre persönlichen Daten werden vor der Überprüfung anonymisiert.</p>
        {/* <button onClick={handleGenerateAnswer} onMouseOver={() => setIsActive(true)} onMouseLeave={() => setIsActive(false)}>
          <span>Anfragen</span>
        </button>*/}

        {/* Chatverlauf anzeigen */}
        {(chatHistory.length > 0) && (
        <div className='ai-chat-history'>
          {chatHistory.map((item, index) => (
            <div key={index} className='ai-chat-item'>
              <span className='ai-question-input'>{item.question}</span>
              <div className="ai-answer-field-wrap">
                <span className='ai-answer-loading'>
                  <FaSpinner />
                </span>
                <span className='ai-answer-text'>{item.answer}</span>
              </div>
            </div>
          ))}
        </div>
        )}
      </div>
    );
  } else if (type === 'create') {
    return (
      <div className='ai-area'>
        <button data-function={type} className='ai-create'>
          {children}
        </button>
        <p>Diese Funktion ist KI-Unterstützt. Ihre persönlichen Daten werden vor der Überprüfung anonymisiert.</p>
      </div>
    );
  } else {
    return null;
  }
};

export default InputAi;
