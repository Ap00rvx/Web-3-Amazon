import { useEffect, useState } from 'react'
import { ethers } from 'ethers'

// Components
import Navigation from './components/Navigation'
import Section from './components/Section'
import Product from './components/Product'

// ABIs
import Dappazon from './abis/Dappazon.json'

// Config
import config from './config.json'

function App() {
  const loadBlockchainData = async () =>{
    
  }
  const [account,setAccount] = useState(null); 

  useEffect(()=>{
    loadBlockchainData()
  },[])
  return (
    <div>
      <Navigation account = {account} setAccount = {setAccount}/>
      <h2>Welcome to CryptoCart</h2>
      

    </div>
  );
}

export default App;
