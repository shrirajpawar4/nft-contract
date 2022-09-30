import Head from 'next/head'
import Image from 'next/image'
import { useEffect, useRef, useState } from 'react'
import styles from '../styles/Home.module.css'
import Web3Modal from 'web3modal';
import {Contracts, providers, utils} from "ethers";

export default function Home() {
  const [walletConnected, setWalletConnected] = useState(false);
  const web3ModalRef = useRef();
  
  const connectWallet = async() => {
    await getProvider();
    setWalletConnected(true);
    }

  const getProvider = async (needSigner = false) => {
    const provider = await web3ModalRef.current.connect();
    const web3Provider = new providers.Web3Provider(provider);

    const { chainId } = await web3Provider.getNetwork();
    if ( chainId !== 8001) {
      window.alert("Change network to polygon mumbai");
      throw new Error("Change network to polygon mumbai");
    }

    if (needSigner) {
      const signer = web3Provider.getSigner();
      return signer;
    }

    return web3Provider;
  }

  useEffect(() => {
    if (!walletConnected) {
      web3ModalRef.current = new Web3Modal({
        network: "mumbai",
        providerOptions: {},
        disableInjectedProvider: false,
      });
      connectWallet();
    }
  }, [])
  
  return (
    <>
    <Head>NFT Collection</Head>
    <div>
      <button onClick={connectWallet} className="flex justify-center bg-indigo-600 py-2 px-4 text-sm rounded-md text-white" >Connect Wallet</button>
    </div>
    </>
  )
}
