import SearchInput from '../../components/Search'
import { useEffect } from 'react'
import { useAuth } from '../../auth/AuthContext'
import { FaSignOutAlt } from 'react-icons/fa'
import './Header.css'

function Header() {
  const { user, logout } = useAuth();
  const isAuthenticated = !!user;

  useEffect(() => {
    const scrollContainer = document.querySelector('.content-inner')
    if (!scrollContainer) {
      return
    }

    const handleScroll = () => {
      const header = document.querySelector('header')
      if (scrollContainer.scrollTop > 0) {
        header?.classList.add('scrolled')
      } else {
        header?.classList.remove('scrolled')
      }
    }

    handleScroll()
    scrollContainer.addEventListener('scroll', handleScroll)

    return () => {
      scrollContainer.removeEventListener('scroll', handleScroll)
    }
  }, [])

  return (
    <>
      <header>
        <div id='search'><SearchInput/></div>
        <div id='breadcrumbs'></div>
        <div id='profile'>
          <span id="profile-info">
            <span id='name-id'>{user ? `${user.firstName} ${user.lastName}` : ''}</span>
            <span id='role-id'>{user?.roles[0]?.role ?? ''}</span>
          </span>
          {isAuthenticated && 
          <>
            <span id='profile-pic'></span>
             <button id='logout-button' onClick={logout} type='button'>
              <span><FaSignOutAlt /></span></button>
          </>
          }
        </div>
      </header>
    </>
  )
}

export default Header
