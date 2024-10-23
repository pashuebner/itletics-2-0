import SearchInput from '../../components/Search'
import './Header.css'

function Header() {

  return (
    <>
      <header>
        <div id='search'><SearchInput/></div>
        <div id='breadcrumbs'></div>
        <div id='profile'>
          <span id="profile-info"><span id='name-id'>Pascal Hübner</span>
            <span id='role-id'> Teammanager </span>
          </span>
          <span id='profile-pic'></span>
        </div>
      </header>
    </>
  )
}

export default Header
