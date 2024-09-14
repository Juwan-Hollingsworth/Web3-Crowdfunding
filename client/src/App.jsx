import { RouterTypeInput } from '@thirdweb-dev/react'
import React from 'react'
import { Route, Routes } from 'react-router-dom'
import { CampaignDetails, CreateCampaign, Home, Profile } from './pages'
import { Sidebar, Navbar } from './components'

const App = () => {
  return (
    //create the layout for the application


    <div className='relative sm:-8 p-4 bg-[#13131a] min-h-screen flex flex-row'>
      {/* Application Sidebar */}
      <div className='sm:flex hidden mr-10 relative'>
        <Sidebar />
      </div>

      {/* Application Navbar */}
      <div className='flex-1 max-sm:w-full max-w-[1280px] mx-auto sm:pr-5'>
        <Navbar />
      </div>

      {/* Application Pages */}
      <Routes>
        <Route path='/' element={<Home />} />
      </Routes>
    </div>

  )
}

export default App
