import './Search.css';
import { FaSearch } from 'react-icons/fa'; // Verwende Font Awesome Icons für Search Icon

function SearchInput(){

    return (
    <>
      <div className="searchInput">
        <label htmlFor="searchField"><FaSearch className="icon" /></label>
        <input type='text' id="searchField" placeholder='Suche'/>
      </div>
    </>
  )
}

export default SearchInput;

